# Transaction processor Lambda
resource "aws_lambda_function" "transaction_processor" {
  filename         = data.archive_file.transaction_processor.output_path
  function_name    = "${var.project_name}-${var.environment}-transaction-processor"
  role            = aws_iam_role.lambda_role.arn
  handler         = "index.handler"
  source_code_hash = data.archive_file.transaction_processor.output_base64sha256
  runtime         = "python3.9"
  timeout         = 300
  memory_size     = 512

  environment {
    variables = {
      ENVIRONMENT = var.environment
      S3_BUCKET   = var.processed_data_bucket
      LOG_LEVEL   = "INFO"
    }
  }

  dead_letter_config {
    target_arn = aws_sqs_queue.dlq.arn
  }
}

# Event source mapping
resource "aws_lambda_event_source_mapping" "transaction_stream_mapping" {
  event_source_arn  = var.transaction_stream_arn
  function_name     = aws_lambda_function.transaction_processor.arn
  starting_position = "LATEST"
  batch_size        = 100
  parallelization_factor = 2

  maximum_batching_window_in_seconds = 30
}

# Dead letter queue for failed processing
resource "aws_sqs_queue" "dlq" {
  name = "${var.project_name}-${var.environment}-transaction-dlq"
  
  message_retention_seconds = 1209600  # 14 days
}

# Lambda execution role
resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}-${var.environment}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_iam_role_policy" "lambda_policy" {
  name = "${var.project_name}-${var.environment}-lambda-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kinesis:DescribeStream",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:ListStreams"
        ]
        Resource = var.transaction_stream_arn
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "${var.processed_data_bucket_arn}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:SendMessage"
        ]
        Resource = aws_sqs_queue.dlq.arn
      }
    ]
  })
}

# Package Lambda function
data "archive_file" "transaction_processor" {
  type        = "zip"
  source_dir  = "${path.module}/../../../src/lambda/processors/transaction"
  output_path = "${path.module}/transaction_processor.zip"
}
# Main transaction stream
resource "aws_kinesis_stream" "transaction_stream" {
  name             = "${var.project_name}-${var.environment}-transactions"
  shard_count      = var.transaction_stream_shards
  retention_period = 168  # 7 days

  encryption_type = "KMS"
  kms_key_id      = aws_kms_key.kinesis_key.arn

  shard_level_metrics = [
    "IncomingRecords",
    "IncomingBytes",
    "OutgoingRecords",
    "OutgoingBytes",
  ]
}

# Market data stream
resource "aws_kinesis_stream" "market_data_stream" {
  name             = "${var.project_name}-${var.environment}-market-data"
  shard_count      = var.market_data_stream_shards
  retention_period = 24   # 1 day for market data

  encryption_type = "KMS"
  kms_key_id      = aws_kms_key.kinesis_key.arn
}

# User activity stream
resource "aws_kinesis_stream" "user_activity_stream" {
  name             = "${var.project_name}-${var.environment}-user-activity"
  shard_count      = var.user_activity_stream_shards
  retention_period = 24

  encryption_type = "KMS"
  kms_key_id      = aws_kms_key.kinesis_key.arn
}

# KMS key for encryption
resource "aws_kms_key" "kinesis_key" {
  description = "KMS key for Kinesis streams"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "kinesis_key_alias" {
  name          = "alias/${var.project_name}-${var.environment}-kinesis"
  target_key_id = aws_kms_key.kinesis_key.key_id
}

data "aws_caller_identity" "current" {}
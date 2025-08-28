# Lambda function outputs
output "transaction_processor_arn" {
  description = "ARN of the transaction processor Lambda function"
  value       = aws_lambda_function.transaction_processor.arn
}

output "transaction_processor_name" {
  description = "Name of the transaction processor Lambda function"
  value       = aws_lambda_function.transaction_processor.function_name
}

output "transaction_processor_invoke_arn" {
  description = "Invoke ARN of the transaction processor Lambda function"
  value       = aws_lambda_function.transaction_processor.invoke_arn
}

# Event source mapping outputs
output "transaction_stream_mapping_uuid" {
  description = "UUID of the Kinesis event source mapping"
  value       = aws_lambda_event_source_mapping.transaction_stream_mapping.uuid
}

output "transaction_stream_mapping_state" {
  description = "State of the Kinesis event source mapping"
  value       = aws_lambda_event_source_mapping.transaction_stream_mapping.state
}

# Dead letter queue outputs
output "dlq_arn" {
  description = "ARN of the dead letter queue"
  value       = aws_sqs_queue.dlq.arn
}

output "dlq_url" {
  description = "URL of the dead letter queue"
  value       = aws_sqs_queue.dlq.url
}

output "dlq_name" {
  description = "Name of the dead letter queue"
  value       = aws_sqs_queue.dlq.name
}

# IAM role outputs
output "lambda_role_arn" {
  description = "ARN of the Lambda execution role"
  value       = aws_iam_role.lambda_role.arn
}

output "lambda_role_name" {
  description = "Name of the Lambda execution role"
  value       = aws_iam_role.lambda_role.name
}
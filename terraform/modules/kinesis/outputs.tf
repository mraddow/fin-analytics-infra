# Transaction stream outputs
output "transaction_stream_arn" {
  description = "ARN of the transaction Kinesis stream"
  value       = aws_kinesis_stream.transaction_stream.arn
}

output "transaction_stream_name" {
  description = "Name of the transaction Kinesis stream"
  value       = aws_kinesis_stream.transaction_stream.name
}

# Market data stream outputs
output "market_data_stream_arn" {
  description = "ARN of the market data Kinesis stream"
  value       = aws_kinesis_stream.market_data_stream.arn
}

output "market_data_stream_name" {
  description = "Name of the market data Kinesis stream"
  value       = aws_kinesis_stream.market_data_stream.name
}

# User activity stream outputs
output "user_activity_stream_arn" {
  description = "ARN of the user activity Kinesis stream"
  value       = aws_kinesis_stream.user_activity_stream.arn
}

output "user_activity_stream_name" {
  description = "Name of the user activity Kinesis stream"
  value       = aws_kinesis_stream.user_activity_stream.name
}

# Firehose outputs
output "transaction_firehose_arn" {
  description = "ARN of the transaction Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.transaction_firehose.arn
}

output "transaction_firehose_name" {
  description = "Name of the transaction Firehose delivery stream"
  value       = aws_kinesis_firehose_delivery_stream.transaction_firehose.name
}

# IAM role outputs
output "firehose_role_arn" {
  description = "ARN of the Firehose IAM role"
  value       = aws_iam_role.firehose_role.arn
}

# CloudWatch log group outputs
output "firehose_log_group_name" {
  description = "Name of the Firehose CloudWatch log group"
  value       = aws_cloudwatch_log_group.firehose_log_group.name
}

output "firehose_log_group_arn" {
  description = "ARN of the Firehose CloudWatch log group"
  value       = aws_cloudwatch_log_group.firehose_log_group.arn
}

# KMS key outputs
output "kinesis_kms_key_arn" {
  description = "ARN of the KMS key used for Kinesis encryption"
  value       = aws_kms_key.kinesis_key.arn
}

output "kinesis_kms_key_id" {
  description = "ID of the KMS key used for Kinesis encryption"
  value       = aws_kms_key.kinesis_key.key_id
}

output "kinesis_kms_key_alias" {
  description = "Alias of the KMS key used for Kinesis encryption"
  value       = aws_kms_alias.kinesis_key_alias.name
}
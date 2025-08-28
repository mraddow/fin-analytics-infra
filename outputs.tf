# terraform/outputs.tf (ROOT LEVEL)
# Basic environment information
output "environment" {
  description = "Environment name"
  value       = var.environment
}
output "project_name" {
  description = "Project name"
  value       = var.project_name
}
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}
# Terraform state information
output "terraform_workspace" {
  description = "Current Terraform workspace"
  value       = terraform.workspace
}
# Account information for verification
output "aws_account_id" {
  description = "AWS Account ID"
  value       = data.aws_caller_identity.current.account_id
}
output "aws_caller_arn" {
  description = "ARN of the AWS caller"
  value       = data.aws_caller_identity.current.arn
  sensitive   = true
}

# S3 bucket outputs (from S3 module)
output "raw_data_bucket_name" {
  description = "Name of the raw data S3 bucket"
  value       = module.s3.raw_data_bucket_name
}
output "raw_data_bucket_arn" {
  description = "ARN of the raw data S3 bucket"
  value       = module.s3.raw_data_bucket_arn
}
output "processed_data_bucket_name" {
  description = "Name of the processed data S3 bucket"
  value       = module.s3.processed_data_bucket_name
}
output "processed_data_bucket_arn" {
  description = "ARN of the processed data S3 bucket"
  value       = module.s3.processed_data_bucket_arn
}
output "failed_records_bucket_name" {
  description = "Name of the failed records S3 bucket"
  value       = module.s3.failed_records_bucket_name
}

# Kinesis stream outputs (from Kinesis module)
output "transaction_stream_name" {
  description = "Name of the transaction Kinesis stream"
  value       = module.kinesis.transaction_stream_name
}
output "transaction_stream_arn" {
  description = "ARN of the transaction Kinesis stream"
  value       = module.kinesis.transaction_stream_arn
}
output "market_data_stream_name" {
  description = "Name of the market data Kinesis stream"
  value       = module.kinesis.market_data_stream_name
}
output "user_activity_stream_name" {
  description = "Name of the user activity Kinesis stream"
  value       = module.kinesis.user_activity_stream_name
}
output "transaction_firehose_name" {
  description = "Name of the transaction Firehose delivery stream"
  value       = module.kinesis.transaction_firehose_name
}

# Lambda function outputs (from Lambda module)
output "transaction_processor_name" {
  description = "Name of the transaction processor Lambda function"
  value       = module.lambda.transaction_processor_name
}
output "transaction_processor_arn" {
  description = "ARN of the transaction processor Lambda function"
  value       = module.lambda.transaction_processor_arn
}
output "dlq_name" {
  description = "Name of the dead letter queue"
  value       = module.lambda.dlq_name
}

# Data source for AWS account info
data "aws_caller_identity" "current" {}
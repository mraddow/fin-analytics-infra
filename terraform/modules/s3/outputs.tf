# Raw data bucket outputs
output "raw_data_bucket_name" {
  description = "Name of the raw data S3 bucket"
  value       = aws_s3_bucket.raw_data.bucket
}

output "raw_data_bucket_arn" {
  description = "ARN of the raw data S3 bucket"
  value       = aws_s3_bucket.raw_data.arn
}

output "raw_data_bucket_id" {
  description = "ID of the raw data S3 bucket"
  value       = aws_s3_bucket.raw_data.id
}

# Processed data bucket outputs
output "processed_data_bucket_name" {
  description = "Name of the processed data S3 bucket"
  value       = aws_s3_bucket.processed_data.bucket
}

output "processed_data_bucket_arn" {
  description = "ARN of the processed data S3 bucket"
  value       = aws_s3_bucket.processed_data.arn
}

output "processed_data_bucket_id" {
  description = "ID of the processed data S3 bucket"
  value       = aws_s3_bucket.processed_data.id
}

# Failed records bucket outputs
output "failed_records_bucket_name" {
  description = "Name of the failed records S3 bucket"
  value       = aws_s3_bucket.failed_records.bucket
}

output "failed_records_bucket_arn" {
  description = "ARN of the failed records S3 bucket"
  value       = aws_s3_bucket.failed_records.arn
}

output "failed_records_bucket_id" {
  description = "ID of the failed records S3 bucket"
  value       = aws_s3_bucket.failed_records.id
}

# Random suffix output (in case other resources need it)
output "bucket_suffix" {
  description = "Random suffix used for bucket naming"
  value       = random_string.suffix.result
}
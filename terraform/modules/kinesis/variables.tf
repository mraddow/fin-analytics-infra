variable "project_name" {
  description = "Project name used for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "transaction_stream_shards" {
  description = "Number of shards for the transaction stream"
  type        = number
  default     = 2
  validation {
    condition     = var.transaction_stream_shards >= 1 && var.transaction_stream_shards <= 10
    error_message = "Transaction stream shards must be between 1 and 10."
  }
}

variable "market_data_stream_shards" {
  description = "Number of shards for the market data stream"
  type        = number
  default     = 1
  validation {
    condition     = var.market_data_stream_shards >= 1 && var.market_data_stream_shards <= 10
    error_message = "Market data stream shards must be between 1 and 10."
  }
}

variable "user_activity_stream_shards" {
  description = "Number of shards for the user activity stream"
  type        = number
  default     = 1
  validation {
    condition     = var.user_activity_stream_shards >= 1 && var.user_activity_stream_shards <= 10
    error_message = "User activity stream shards must be between 1 and 10."
  }
}

variable "raw_data_bucket_arn" {
  description = "ARN of the raw data S3 bucket for Firehose delivery"
  type        = string
}

variable "failed_records_bucket_arn" {
  description = "ARN of the failed records S3 bucket for Firehose error handling"
  type        = string
}
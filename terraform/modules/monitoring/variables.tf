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

variable "transaction_stream_name" {
  description = "Name of the Kinesis transaction stream"
  type        = string
}

variable "transaction_processor_name" {
  description = "Name of the Lambda transaction processor function"
  type        = string
}

variable "aws_region" {
  description = "AWS region for CloudWatch metrics"
  type        = string
}

variable "alert_emails" {
  description = "List of email addresses to receive CloudWatch alerts"
  type        = list(string)
  default     = []
}
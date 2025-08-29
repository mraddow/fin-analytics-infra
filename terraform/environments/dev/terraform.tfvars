# Dev Environment Configuration
project_name = "financial-analytics-platform"
environment  = "dev"
aws_region   = "us-east-1"

# Email alerts for monitoring (replace with your email)
alert_emails = ["addowk@gmail.com"]

# Note: Kinesis shard counts are hardcoded in main.tf
# If you want to make them configurable, add them as variables
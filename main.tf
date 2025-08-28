# S3 module
module "s3" {
  source = "./terraform/modules/s3"
  
  project_name = var.project_name
  environment  = var.environment
}

# Kinesis module
module "kinesis" {
  source = "./terraform/modules/kinesis"
  
  project_name                    = var.project_name
  environment                     = var.environment
  transaction_stream_shards       = 2
  market_data_stream_shards      = 1
  user_activity_stream_shards    = 1
  raw_data_bucket_arn            = module.s3.raw_data_bucket_arn
  failed_records_bucket_arn      = module.s3.failed_records_bucket_arn
}

# Lambda module
module "lambda" {
  source = "./terraform/modules/lambda"
  
  project_name              = var.project_name
  environment               = var.environment
  transaction_stream_arn    = module.kinesis.transaction_stream_arn
  processed_data_bucket     = module.s3.processed_data_bucket_name
  processed_data_bucket_arn = module.s3.processed_data_bucket_arn
}

# Monitoring module
module "monitoring" {
  source = "./terraform/modules/monitoring"
  
  project_name               = var.project_name
  environment                = var.environment
  aws_region                 = var.aws_region
  transaction_stream_name    = module.kinesis.transaction_stream_name
  transaction_processor_name = module.lambda.transaction_processor_name
  alert_emails              = var.alert_emails
}
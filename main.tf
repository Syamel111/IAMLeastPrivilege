provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source = "./lambda_module"

  lambda_role_arn = aws_iam_role.lambda_exec_role.arn
  table_name      = aws_dynamodb_table.demo_table.name
  bucket_name     = aws_s3_bucket.report_bucket.bucket
  sns_topic_arn   = aws_sns_topic.alert_topic.arn
}

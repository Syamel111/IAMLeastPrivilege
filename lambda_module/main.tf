variable "lambda_role_arn" {}
variable "table_name" {}
variable "bucket_name" {}
variable "sns_topic_arn" {}

resource "aws_lambda_function" "iam_demo_lambda" {
  function_name = "iam-least-privilege"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  handler          = "handler.lambda_handler"
  runtime          = "python3.12"
  role             = var.lambda_role_arn

  environment {
    variables = {
      TABLE_NAME    = var.table_name
      BUCKET_NAME   = var.bucket_name
      SNS_TOPIC_ARN = var.sns_topic_arn
    }
  }
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../lambda"
  output_path = "${path.module}/lambda.zip"
}

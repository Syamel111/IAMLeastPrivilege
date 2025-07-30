resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/iam-least-privilege"
  retention_in_days = 7
}

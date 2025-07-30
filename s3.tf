resource "aws_s3_bucket" "report_bucket" {
  bucket = "iam-demo-reports-${random_id.suffix.hex}"
}

resource "random_id" "suffix" {
  byte_length = 4
}

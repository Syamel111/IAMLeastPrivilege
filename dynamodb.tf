resource "aws_dynamodb_table" "demo_table" {
  name         = "DemoIAMTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

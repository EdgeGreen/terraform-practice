#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
#------------------------------------------------------------------------------------------
resource "aws_dynamodb_table" "file_metadata" {
  name         = var.dynamoDB.table_name
  hash_key     = var.dynamoDB.table_hash_key
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = var.dynamoDB.atribute_name
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }
  tags = {
    "Name"        = "s3-metadata-table"
    "Description" = "DynamoDB table for S3 Metadata"
  }
}

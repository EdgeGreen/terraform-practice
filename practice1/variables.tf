#https://developer.hashicorp.com/terraform/language/values/variables
#-------------------------------------------------------------------
variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "account_number" {
  type    = string
  default = "433349744699"
}

variable "s3_bucket_name" {
  description = "S3 bucket"
  type        = string
  default     = "terraform-practice-info-bucket"
}

variable "dynamoDB" {
  description = "DynamoDB table for storing files metadata"
  type        = map(any)
  default = {
    "table_name"     = "file-metadata"
    "table_hash_key" = "bucket_name"

    "atribute_name" = "bucket_name"
  }
}

variable "lambda_function_metadata" {
  description = "DynamoDB table for storing files metadata"
  type        = map(any)
  default = {
    "function_name"  = "metadata"
    "table_hash_key" = "bucket_name"

    "atribute_name" = "bucket_name"
  }
}

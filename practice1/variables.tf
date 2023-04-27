# https://developer.hashicorp.com/terraform/language/values/variables
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

variable "lambda_function_role" {
  description = "Executeble Lambda Function Role Name"
  type        = string
  default     = "executeble-lambda-role"
}

variable "iam_role_policies" {
  description = "A list of default policies for IAM lamda role"
  type        = list(string)
  default = [
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}

variable "dynamoDB" {
  description = "DynamoDB table for storing files metadata"
  type        = map(any)
  default = {
    "table_name"     = "file-metadata"
    "table_hash_key" = "creation_date"

    "atribute_name" = "creation_date"
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

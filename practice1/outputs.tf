#https://developer.hashicorp.com/terraform/language/values/outputs
#-----------------------------------------------------------------
output "s3_bucket" {
  value       = aws_s3_bucket.info_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.file_metadata.arn
  description = "The ARN of the DynamoDB table"
}

output "lambda_function" {
  value       = aws_lambda_function.store_metadata.arn
  description = "The ARN of the Metadata Lambda Function"
}


output "iam_role" {
  value       = aws_iam_role.executeble_lambda_role.id
  description = "The ARN of the Lambdas Role"
}

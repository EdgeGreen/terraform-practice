output "s3_bucket" {
  value       = aws_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}

output "dynamodb_table" {
  value       = aws_dynamodb_table.terraform_state_locks.arn
  description = "The ARN of the DynamoDB table"
}

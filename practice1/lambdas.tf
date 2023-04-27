data "archive_file" "create-store_metadata-archive" {
  source_file = "./lambda/metadata/metadata.py"
  output_path = "./lambda/metadata.zip"
  type        = "zip"
}

resource "aws_lambda_function" "store_metadata" {
  function_name = var.lambda_function_metadata.function_name
  environment {
    variables = {
      DYNAMODB_TABLE = aws_dynamodb_table.file_metadata.name
    }
  }
  memory_size      = "128"
  timeout          = 10
  runtime          = "python3.8"
  architectures    = ["x86_64"]
  handler          = "metadata.lambda_handler"
  role             = aws_iam_role.executeble_lambda_role.arn
  filename         = data.archive_file.create-store_metadata-archive.output_path
  source_code_hash = data.archive_file.create-store_metadata-archive.output_base64sha256
}

resource "aws_lambda_permission" "s3_permission_to_trigger_lambda" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.store_metadata.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.info_bucket.arn
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.info_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.store_metadata.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.s3_permission_to_trigger_lambda]
}

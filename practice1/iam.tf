resource "aws_iam_role" "executeble_lambda_role" {
  name = "executeble-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Resource = ["arn:aws:lambda:${var.aws_region}:${var.account_number}:function:${var.lambda_function_metadata.function_name}"]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_s3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.executeble_lambda_role.id
}

resource "aws_iam_role_policy_attachment" "lambda_dynamodb" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
  role       = aws_iam_role.executeble_lambda_role.id
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.executeble_lambda_role.id
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_metadata.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

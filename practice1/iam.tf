# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
#-------------------------------------------------------------------------------------------------
resource "aws_iam_role" "executeble_lambda_role" {
  name = var.lambda_function_role
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

resource "aws_iam_role_policy_attachment" "function_policies_attachment" {
  role       = aws_iam_role.executeble_lambda_role.id
  count      = length(var.iam_role_policies)
  policy_arn = var.iam_role_policies[count.index]
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_metadata.function_name}"
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

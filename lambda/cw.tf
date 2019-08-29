resource "aws_cloudwatch_log_group" "main" {
  name              = "/aws/lambda/${local.lambda_name}"
  retention_in_days = 3
}

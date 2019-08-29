resource "aws_cloudwatch_event_rule" "main" {
  name        = local.rule_name
  description = "Schedule to trigger lambda backups of DynDb"

  schedule_expression = "cron(0 22 * * ? *)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.main.name
  target_id = "DynDbLambdaBackup"
  arn       = var.lambda_arn
}

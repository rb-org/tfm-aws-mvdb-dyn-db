resource "aws_cloudwatch_event_rule" "main" {
  name        = local.rule_name
  description = "Schedule to trigger lambda backups of DynDb"

  schedule_expression = "cron(0 22 * * ? *)"

  is_enabled = var.create_backup
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule      = aws_cloudwatch_event_rule.main.name
  target_id = "DynDbLambdaBackup"
  arn       = var.lambda_arn
}

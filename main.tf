module "db" {
  source = "./db"

  prefix       = var.prefix
  table_name   = "movies"
  default_tags = var.default_tags

}

module "cw" {
  source = "./cw"

  prefix        = var.prefix
  region        = data.aws_region.current.name
  account_id    = data.aws_caller_identity.current.account_id
  lambda_arn    = module.lambda.lambda_arn
  create_backup = false
}

module "lambda" {
  source = "./lambda"

  prefix        = var.prefix
  default_tags  = var.default_tags
  region        = data.aws_region.current.name
  create_backup = false
  table_arn     = module.db.table_arn

}

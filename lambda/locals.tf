locals {
  prefix      = "${var.prefix}-${terraform.workspace}"
  lambda_name = "${local.prefix}-backup-movies-dyndb"
  max_backups = "${var.create_backup == true ? 3 : 0}"
  env_vars = {
    REGION      = var.region
    MAX_BACKUPS = local.max_backups
  }
}

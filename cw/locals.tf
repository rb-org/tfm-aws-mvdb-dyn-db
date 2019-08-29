locals {
  rule_name = "${var.prefix}-${terraform.workspace}-trigger-lambda-backup"
  prefix    = "${var.prefix}-${terraform.workspace}"
}

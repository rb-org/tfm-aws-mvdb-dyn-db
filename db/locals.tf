locals {
  table_name = "${var.prefix}-${terraform.workspace}-${var.table_name}"
  prefix     = "${var.prefix}-${terraform.workspace}"
}

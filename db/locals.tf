locals {
  table_name = "${var.name_prefix}-${terraform.workspace}-${var.table_name}"
}

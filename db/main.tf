module "main" {
  source = "../../../../terraform/mods/terraform-aws-dynamo-db"

  table_name     = "${var.name_prefix}-${var.table_name}"
  billing_mode   = var.billing_mode
  hash_key       = var.hash_key
  range_key      = var.range_key
  hash_key_type  = var.hash_key_type
  range_key_type = var.range_key_type
  tags           = var.default_tags
  gsi_enabled    = var.gsi_enabled

}

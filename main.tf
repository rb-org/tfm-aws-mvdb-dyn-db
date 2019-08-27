module "db" {
  source = "./db"

  name_prefix = var.name_prefix
  table_name  = "movies"
  tags        = var.default_tags

}

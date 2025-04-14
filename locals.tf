resource "random_id" "this" {
  byte_length = 8
}

resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
  numeric = false
}

locals {
  random_number = substr(random_id.this.dec, 0, 6)

  instance = format("%02s", var.name_attributes.instance)

  resource_names = var.naming_convention == "oss" ? local.resource_names_oss : local.resource_names_gc
}

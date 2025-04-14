module "azure_resource_names_gc" {
  source = "../"

  naming_convention = "gc"
  user_defined      = "example"

  name_attributes = {
    department_code = "Gc"
    owner           = "ABC"
    project         = "gen"
    environment     = "P"
    location        = "c"
    instance        = "1"
  }
}

output "azure_resource_names_gc" {
  value = module.azure_resource_names_gc
}
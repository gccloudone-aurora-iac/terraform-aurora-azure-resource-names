module "azure_resource_names_oss" {
  source = "../"

  naming_convention = "oss"
  user_defined      = "example"

  name_attributes = {
    department_code = "Gc"
    owner           = "ABC"
    project         = "aur"
    environment     = "dev"
    location        = "cc"
    instance        = "00"
  }
}

output "azure_resource_names_oss" {
  value = module.azure_resource_names_oss
}

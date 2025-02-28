module "azure_resource_names_stc" {
  source = "../"

  government = "stc"

  name_attributes = {
    department_code = "St"
    environment     = "D"
    csp_region      = "c"
    instance        = "00"
    owner           = "ABC"
    project         = "aur"
  }
  user_defined = []
}

output "azure_resource_names_values_stc" {
  value = module.azure_resource_names_stc
}

module "azure_resource_names_ssc" {
  source = "../"

  government = "ssc"

  name_attributes = {
    department_code = "Sc"
    environment     = "P"
    csp_region      = "c"
    instance        = "1"
    owner           = "ABC"
  }

  parent_object_names = ["ScDcCNR-VDC-MRZ"]

  user_defined = ["CORE", "EX2", "Logging"]

}

output "azure_resource_names_values_ssc" {
  value = module.azure_resource_names_ssc
}

output "des_name_ssc" {
  value = module.azure_resource_names_ssc.disk_encryption_set_name["CORE"]
}

output "snet_name_ssc" {
  value = module.azure_resource_names_ssc.subnet_name["CORE"]["Logging"]
}

output "snet_name_specific_parent_ssc" {
  value = module.azure_resource_names_ssc.subnet_name["ScDcCNR-VDC-MRZ"]["Logging"]
}

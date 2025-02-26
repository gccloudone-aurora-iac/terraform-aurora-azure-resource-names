module "azure_resource_prefixes_stc" {
  source = "../"

  government = false

  name_attributes = {
    department_code     = "St"
    environment         = "D"
    csp_region          = "c"
    instance            = "00"
    owner               = "ABC"
    parent_object_names = []
  }
  user_defined = ["aur"]
}

output "azure_resource_prefixes_values_stc" {
  value = module.azure_resource_prefixes_stc
}

module "azure_resource_prefixes_ssc" {
  source = "../"

  government = true

  name_attributes = {
    department_code     = "Sc"
    environment         = "P"
    csp_region          = "c"
    instance            = 1
    owner               = "ABC"
    parent_object_names = ["ScPcCNR-VDC-MRZ"]
  }

  user_defined = ["CORE", "EX2", "Logging"]

}

output "azure_resource_prefixes_values_ssc" {
  value = module.azure_resource_prefixes_ssc
}

output "des_name_ssc" {
  value = module.azure_resource_prefixes_ssc.disk_encryption_set_prefix["CORE"]
}

output "snet_name_ssc" {
  value = module.azure_resource_prefixes_ssc.subnet_prefix["CORE"]["Logging"]
}

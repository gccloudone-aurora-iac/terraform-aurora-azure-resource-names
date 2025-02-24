module "azure_resource_prefixes_ssc" {
  source = "../"

  government = true

  name_attributes_ssc = {
    department_code    = "Sc"
    environment        = "P"
    csp_region         = "c"
    instance           = 1
    owner              = "ABC"
    parent_object_name = "ScPcCNR-CORE"
  }

  user_defined = ["CORE","EX2"]

}

output "azure_resource_prefixes_values_ssc" {
  value = module.azure_resource_prefixes_ssc
}

output "my_des" {
  value = module.azure_resource_prefixes_ssc.disk_encryption_set_prefix["CORE"]
}

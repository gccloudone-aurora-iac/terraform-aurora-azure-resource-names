locals {
  ##############################
  #   STC NAMING CONVENTION    #
  ##############################

  # The following variables are used to create the standardized naming convention for the resources.
  instance = format("%02s", var.name_attributes.instance)

  # SSC CSP region -> STC Location
  location_table = {
    "c" = "cc" # Canada Central
    "d" = "ce" # Canada East
  }

  environment_table = {
    "P" = "prod",
    "D" = "dev",
    "T" = "test",
    "S" = "sandbox",
    "Q" = "qa",
    "U" = "uat"
  }

  common_conv_base_stc = "${var.name_attributes.project}-${local.environment_table[upper(var.name_attributes.environment)]}-${local.location_table[lower(var.name_attributes.csp_region)]}-${local.instance}"

  resource_type_suffixes_stc = {
    "application security group"     = "asg"
    "disk encryption set"            = "des"
    "firewall"                       = "fw"
    "kubernetes service"             = "aks"
    "load balancer"                  = "lb"
    "network interface card"         = "nic"
    "network security group"         = "nsg"
    "private endpoint"               = "pe"
    "public ip address"              = "pip"
    "resource group"                 = "rg"
    "route server"                   = "rs"
    "route table"                    = "rt"
    "service endpoint policy"        = "sep"
    "service principal"              = "sp"
    "user-assigned managed identity" = "msi"
    "virtual machine"                = "vm"
    "virtual machine scale set"      = "vmss"
    "virtual network"                = "vnet"
  }

  common_conv_names_stc_standard = {
    for resource_type, abbrev in local.resource_type_suffixes_stc :
    resource_type => {
      stc = "${local.common_conv_base_stc}-${abbrev}"
    }
  }

  # Force STC names to have the same structure as SSC's
  common_conv_names_stc = merge(
    local.common_conv_names_ssc,
    local.common_conv_names_stc_standard,
    {
      for resource_type in local.resource_types_children :
      resource_type => {
        stc = {
          stc = "${local.common_conv_base_stc}-${lookup(local.resource_type_suffixes_stc, resource_type, "")}"
        }
      }
    }
  )
}

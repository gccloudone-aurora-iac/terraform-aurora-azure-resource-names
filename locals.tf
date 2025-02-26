locals {
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
  }

  common_conv_base_stc = "${var.user_defined[0]}-${local.environment_table[upper(var.name_attributes.environment)]}-${local.location_table[lower(var.name_attributes.csp_region)]}-${local.instance}"
  common_conv_base_ssc = "${var.name_attributes.department_code}${var.name_attributes.environment}${var.name_attributes.csp_region}"

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

  resource_type_suffixes_ssc = {
    "application security group"        = "asg"
    "disk encryption set"               = "des"
    "firewall"                          = "afw"
    "kubernetes service"                = "aks"
    "load balancer"                     = "lb"
    "network interface card"            = "nic${var.name_attributes.instance}"
    "network security group"            = "nsg"
    "private endpoint"                  = "pe"
    "public ip address"                 = "pip${var.name_attributes.instance}"
    "resource group"                    = "rg"
    "route server"                      = "rs"
    "route table"                       = "rt"
    "service endpoint policy"           = "sep"
    "service principal"                 = "spn"
    "user-assigned managed identity"    = ""
    "virtual machine"                   = ""
    "virtual machine scale set"         = "vmss"
    "virtual network"                   = "vnet"
    "databricks service"                = "dbw"
    "management group"                  = ""
    "subscription"                      = ""
    "virtual machine os disk"           = "osdisk${var.name_attributes.instance}"
    "virtual machine data disk"         = "datadisk${var.name_attributes.instance}"
    "availability set"                  = "as"
    "bastion end-point"                 = "bstn"
    "local network gateway"             = "lgn"
    "virtual network gateway"           = "vng"
    "load balancer backend pool"        = "lbbp"
    "load balancer health probe"        = "lbhp"
    "traffic manager"                   = "tm"
    "subnet"                            = "snet"
    "route"                             = "route"
    "connection"                        = "con"
    "network security group rule"       = ""
    "load balancer front end interface" = "lbr${var.name_attributes.instance}"
    "load balancer rule"                = "lbbp"
    "azure application gateway"         = "agw"
    "traffic manager profile"           = "tm"
  }

  # Follows the standard naming pattern of <dept code><environment><CSP Region>-<userDefined-string>-suffix
  common_conv_prefixes_ssc_standard = {
    for resource_type, suffix in local.resource_type_suffixes_ssc :
    resource_type => {
      for user_defined_string in var.user_defined :
      user_defined_string => abbrev == "" ?
      "${local.common_conv_base_ssc}-${user_defined_string}" :
      "${local.common_conv_base_ssc}-${user_defined_string}-${suffix}"
    }
  }

  resource_prefixes_exception = {
    for resource_type, name_list in {
      "resource group"                    = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${user_defined_string}-rg"]
      "route"                             = [for user_defined_string in var.user_defined : "${user_defined_string}-route"]
      "route table"                       = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${user_defined_string}-rt"]
      "user-assigned managed identity"    = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}_${user_defined_string}"]
      "management group"                  = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${user_defined_string}"]
      "subscription"                      = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${user_defined_string}"]
      "load balancer rules"               = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${user_defined_string}-lbr${var.name_attributes.instance}"]
      "load balancer backend pool"        = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${user_defined_string}-lbbp"]
      "load balancer front end interface" = [for user_defined_string in var.user_defined : "${local.common_conv_base_ssc}-${user_defined_string}-lbbp"]
      "network security group rule"       = [for user_defined_string in var.user_defined : "${user_defined_string}"]
    } :
    resource_type => zipmap(var.user_defined, name_list)
  }

  resource_types_children = [
    "network interface card",
    "network security group",
    "public ip address",
    "virtual machine os disk",
    "virtual machine data disk",
    "availability set",
    "subnet",
    "virtual network gateway",
    "local network gateway",
    "connection",
    "load balancer health probe"
  ]

  resource_prefixes_children = {
    for resource_type in local.resource_types_children : resource_type => {
      for user_defined_outer in var.user_defined : user_defined_outer => {
        for user_defined_inner in var.user_defined : user_defined_inner => (
          "${local.common_conv_base_ssc}-${user_defined_outer}-${user_defined_inner}-${lookup(local.resource_type_suffixes_ssc, resource_type, "")}"
        )
      }
    }
  }

  common_conv_prefixes_ssc = merge(
    local.common_conv_prefixes_ssc_standard,
    local.resource_prefixes_exception,
    local.resource_prefixes_children
  )

  # Force STC prefixes to have the same structure as SSC's
  common_conv_prefixes_stc = merge(
    local.common_conv_prefixes_ssc,
    {
      for resource_type, abbrev in local.resource_type_suffixes_stc :
      resource_type => {
        stc = "${local.common_conv_base_stc}-${abbrev}"
      }
    },
    {
      for resource_type in local.resource_types_children :
      resource_type => {
        stc = {
          stc = "${local.common_conv_base_stc}-${lookup(local.resource_type_suffixes_stc, resource_type, "")}"
        }
      }
    }
  )

  common_conv_prefixes = var.government ? local.common_conv_prefixes_ssc : local.common_conv_prefixes_stc
}

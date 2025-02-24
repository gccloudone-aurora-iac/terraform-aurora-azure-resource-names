locals {
  # The following variables are used to create the standardized naming convention for the resources.
  instance = format("%02s", var.name_attributes_ssc.instance)
  location_table = {
    "c" = "cc" # Canada Central
    "d" = "ce" # Canada East
  }
  environment_table = {
    "P" = "prod",
    "D" = "dev",
    "T" = "test",
  }

  common_convention_base_stc = "${var.user_defined[0]}-${local.environment_table[upper(var.name_attributes_ssc.environment)]}-${local.location_table[lower(var.name_attributes_ssc.csp_region)]}-${local.instance}"
  common_convention_base_ssc = "${var.name_attributes_ssc.department_code}${var.name_attributes_ssc.environment}${var.name_attributes_ssc.csp_region}"

  resource_type_abbreviations_stc = {
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

  resource_type_abbreviations_ssc = {
    "application security group"        = "asg"
    "disk encryption set"               = "des"
    "firewall"                          = "afw"
    "kubernetes service"                = "aks"
    "load balancer"                     = "lb"
    "network interface card"            = "nic"
    "network security group"            = "nsg"
    "private endpoint"                  = "pe"
    "public ip address"                 = "pip"
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
    "virtual machine os disk"           = ""
    "virtual machine data disk"         = ""
    "availability set"                  = "as"
    "bastion end-point"                 = "bstn"
    "local network gateway"             = "lgn"
    "virtual network gateway"           = "vng"
    "load balancer backend pool"        = "lbhp"
    "load balancer health probe"        = "lbhp"
    "load balancer rule"                = "lbr"
    "traffic manager"                   = "tm"
    "subnet"                            = "snet"
    "route"                             = "route"
    "connection"                        = "con"
    "network security group rule"       = ""
    "load balancer front end interface" = "lbr"
    "load balancer rules"               = "lbbp"
    "azure application gateway"         = "agw"
    "traffic manager profile"           = "tm"
  }

  # For any resources that does not follow the convention <dept code><environment><CSP Region>-<userDefined-string>-suffix
  resource_names_exception = {
    for resource_type, name_list in {
      "network interface card"            = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-nic${var.name_attributes_ssc.instance}"]
      "network security group"            = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-nsg"]
      "public ip address"                 = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-pip${var.name_attributes_ssc.instance}"]
      "resource group"                    = [for user_defined_string in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_defined_string}-rg"]
      "route table"                       = [for _ in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-rt"]
      "user-assigned managed identity"    = [for user_defined_string in var.user_defined : "${local.common_convention_base_ssc}_${user_defined_string}"]
      "management group"                  = [for user_defined_string in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_defined_string}"]
      "subscription"                      = [for user_defined_string in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_defined_string}"]
      "virtual machine os disk"           = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-osdisk${var.name_attributes_ssc.instance}"]
      "virtual machine data disk"         = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-datadisk${var.name_attributes_ssc.instance}"]
      "availability set"                  = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-as"]
      "subnet"                            = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-snet"]
      "route"                             = [for user_defined_string in var.user_defined : "${user_defined_string}-route"]
      "virtual network gateway"           = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-vng"]
      "local network gateway"             = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-lng"]
      "connection"                        = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-con"]
      "network security group rule"       = [for user_defined_string in var.user_defined : "${user_defined_string}"]
      "load balancer front end interface" = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-lbr${var.name_attributes_ssc.instance}"]
      "load balancer rules"               = [for _ in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-lbbp"]
      "load balancer backend pool"        = [for _ in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-lbhp"]
      "load balancer health probe"        = [for user_defined_string in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_defined_string}-lbhp"]
    } :
    resource_type => zipmap(var.user_defined, name_list)
  }

  common_conv_prefixes_ssc = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_ssc :
      resource_type => zipmap(
        var.user_defined,
        [
          for user_defined_string in var.user_defined :
          abbrev == "" ?
          "${local.common_convention_base_ssc}-${user_defined_string}" :
          "${local.common_convention_base_ssc}-${user_defined_string}-${abbrev}"
        ]
      )
    },
    local.resource_names_exception
  )


  common_conv_prefixes_stc = merge(
    {
      for resource_type in keys(local.resource_type_abbreviations_ssc) :
      resource_type => zipmap(var.user_defined, [for _ in var.user_defined : ""])
    },
    {
      for resource_type, abbrev in local.resource_type_abbreviations_stc :
      resource_type => zipmap(
        var.user_defined,
        [for user_defined_string in var.user_defined : "${local.common_convention_base_stc}-${abbrev}"]
      )
    }
  )

  common_conv_prefixes = var.government ? local.common_conv_prefixes_ssc : local.common_conv_prefixes_stc

}

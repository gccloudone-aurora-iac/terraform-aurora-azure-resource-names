locals {
  # The following variables are used to create the standardized naming convention for the resources.
  location = var.government ? "" : lookup(local.location_table, replace(lower(var.name_attributes.location), " ", ""))
  instance = format("%02s", var.name_attributes.instance)

  common_convention_base_statcan = "${var.name_attributes.project}-${var.name_attributes.environment}-${local.location}-${local.instance}"
  common_convention_base_ssc     = "${var.name_attributes_ssc.department_code}${var.name_attributes_ssc.environment}${var.name_attributes_ssc.csp_region}"

  location_table = {
    "canadacentral" = "cc"
    "canadaeast"    = "ce"
  }

  resource_type_abbreviations_statcan = {
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
    "system-assigned managed identity"  = ""
    "virtual machine"                   = ""
    "virtual machine scale set"         = "vmss"
    "virtual network"                   = "vnet"
    "databricks service"                = "dbw"
    "management group"                  = ""
    "subscription"                      = ""
    "virtual machine os disk"           = ""
    "virtual machine data disk"         = ""
    "availability set"                  = "as"
    "application insights"              = "appi"
    "bastion end-point"                 = "bstn"
    "network watcher"                   = "nw"
    "local network gateway"             = "lgn"
    "virtual network gateway"           = "vng"
    "load balancer backend pool"        = "lbhp"
    "load balancer health probe"        = "lbhp"
    "load balancer rule"                = "lbr"
    "azure load balancer"               = "alb"
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
    "network interface card"            = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-nic${var.name_attributes_ssc.instance}"]
    "network security group"            = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-nsg"]
    "public ip address"                 = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-pip${var.name_attributes_ssc.instance}"]
    "resource group"                    = [for user_item in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_item}-rg"]
    "route table"                       = ["${var.name_attributes_ssc.parent_object_name}-rt"]
    "user-assigned managed identity"    = [for user_item in var.user_defined : "${local.common_convention_base_ssc}_${user_item}"]
    "management group"                  = [for user_item in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_item}"]
    "subscription"                      = [for user_item in var.user_defined : "${local.common_convention_base_ssc}-${var.name_attributes_ssc.owner}-${user_item}"]
    "virtual machine os disk"           = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-osdisk${var.name_attributes_ssc.instance}"]
    "virtual machine data disk"         = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-datadisk${var.name_attributes_ssc.instance}"]
    "availability set"                  = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-as"]
    "subnet"                            = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-snet"]
    "route"                             = [for user_item in var.user_defined : "${user_item}-route"]
    "virtual network gateway"           = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-vng"]
    "local network gateway"             = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-lng"]
    "connection"                        = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-con"]
    "network security group rule"       = [for user_item in var.user_defined : "${user_item}"]
    "load balancer front end interface" = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-lbr${var.name_attributes_ssc.instance}"]
    "load balancer rules"               = ["${var.name_attributes_ssc.parent_object_name}-lbbp"]
    "load balancer backend pool"        = ["${var.name_attributes_ssc.parent_object_name}-lbhp"]
    "load balancer health probe"        = [for user_item in var.user_defined : "${var.name_attributes_ssc.parent_object_name}-${user_item}-lbhp"]
  }

  common_conv_prefixes_ssc = {
    for resource_type, abbrev in local.resource_type_abbreviations_ssc :
    resource_type => zipmap(
      var.user_defined,
      [for user_defined_string in var.user_defined : "${local.common_convention_base_ssc}-${user_defined_string}-${abbrev}"]
    )
  }

  common_conv_prefixes_statcan = merge(
    {
      for resource_type in keys(local.common_conv_prefixes_ssc) :
      resource_type => ""
    },
    { for resource_type, abbrev in local.resource_type_abbreviations_statcan :
      resource_type => "${local.common_convention_base_statcan}-${abbrev}"
    }
  )

  common_conv_prefixes = local.common_conv_prefixes_ssc

}

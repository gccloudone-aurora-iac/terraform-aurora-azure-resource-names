locals {
  ##############################
  #   SSC NAMING CONVENTION    #
  ##############################
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

  common_conv_base_ssc = "${var.name_attributes.department_code}${var.name_attributes.environment}${var.name_attributes.csp_region}"

  # List of resources that require the name of the parent object & user_defined string in its name
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

  resource_names_children = {
    for resource_type in local.resource_types_children : resource_type => {
      for user_defined_outer in concat(var.user_defined, var.parent_object_names) : user_defined_outer => {
        for user_defined_inner in var.user_defined : user_defined_inner => (
          # If iterating over the parent_object_names, we can ignore the common_conv_base_ssc since the parent name should include that.
          contains(var.parent_object_names, user_defined_outer) ?
          "${user_defined_outer}-${var.name_attributes.project}-${user_defined_inner}-${lookup(local.resource_type_suffixes_ssc, resource_type, "")}" :
          "${local.common_conv_base_ssc}-${user_defined_outer}-${var.name_attributes.project}-${user_defined_inner}-${lookup(local.resource_type_suffixes_ssc, resource_type, "")}"
        )
      }
    }
  }

  # Any resources that are exceptions to both of the two above naming convention patterns
  resource_names_exception = merge(
    {
      "resource group"                 = { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${var.name_attributes.project}-${user_defined_string}-rg" }
      "route"                          = { for user_defined_string in var.user_defined : user_defined_string => "${var.name_attributes.project}-${user_defined_string}-route" }
      "user-assigned managed identity" = { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}_${var.name_attributes.project}-${user_defined_string}" }
      "management group"               = { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${var.name_attributes.project}-${user_defined_string}" }
      "subscription"                   = { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.owner}-${var.name_attributes.project}-${user_defined_string}" }
      "network security group rule"    = { for user_defined_string in var.user_defined : user_defined_string => "${var.name_attributes.project}-${user_defined_string}" }
    },
    {
      "route table" = merge(
        { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}-rt" },
        { for parent in var.parent_object_names : parent => "${parent}-rt" }
      )
      "load balancer rules" = merge(
        { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}-lbr${var.name_attributes.instance}" },
        { for parent in var.parent_object_names : parent => "${parent}-lbr${var.name_attributes.instance}" }
      )
      "load balancer backend pool" = merge(
        { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}-lbbp" },
        { for parent in var.parent_object_names : parent => "${parent}-lbbp" }
      )
      "load balancer front end interface" = merge(
        { for user_defined_string in var.user_defined : user_defined_string => "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}-lbr" },
        { for parent in var.parent_object_names : parent => "${parent}-lbr" }
      )
    }
  )

  # Follows the standard naming pattern of <dept code><environment><CSP Region>-<userDefined-string>-suffix
  common_conv_names_ssc_standard = {
    for resource_type, suffix in local.resource_type_suffixes_ssc :
    resource_type => {
      for user_defined_string in var.user_defined :
      user_defined_string => suffix == "" ?
      "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}" :
      "${local.common_conv_base_ssc}-${var.name_attributes.project}-${user_defined_string}-${suffix}"
    }
  }

  common_conv_names_ssc = merge(
    local.common_conv_names_ssc_standard,
    local.resource_names_exception,
    local.resource_names_children
  )
}

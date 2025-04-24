#############################
#   GC NAMING CONVENTION    #
#############################

locals {
  location_table_gc = {
    "cc"            = "c"
    "ce"            = "d"
    "canadacentral" = "c"
    "canadaeast"    = "d"
  }
}

locals {
  location_gc = lookup(local.location_table_gc, replace(lower(var.name_attributes.location), " ", ""))

  common_convention_base_gc = "${var.name_attributes.department_code}${var.name_attributes.environment}${local.location_gc}"

  resource_type_abbreviations_gc = {
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
    "user-assigned managed identity"    = "msi"
    "virtual machine"                   = "vm"
    "virtual machine scale set"         = "vmss"
    "virtual network"                   = "vnet"
    "databricks service"                = "dbw"
    "management group"                  = "mg"
    "subscription"                      = "sub"
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
    "network security group rule"       = "nsgr"
    "load balancer front end interface" = "lbr${var.name_attributes.instance}"
    "load balancer rule"                = "lbbp"
    "azure application gateway"         = "agw"
    "traffic manager profile"           = "tm"
  }

  resource_type_abbreviations_gc_custom = {
    "key vault secret"                  = "${lower(local.common_convention_base_gc)}-${lower(var.name_attributes.project)}-${lower(var.user_defined)}-kvs"
    "public ip address route server"    = "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-rs-pip${var.name_attributes.instance}"
    "resource group kubernetes service" = "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-aks-managed-rg"
    "resource group backup"             = "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-backup-rg"
    "resource group platform"           = "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-platform-rg"
    "resource group secrets"            = "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-secrets-rg"
  }

  resource_names_gc = merge(
    {
      for resource_type, suffix in local.resource_type_abbreviations_gc :
      resource_type => "${local.common_convention_base_gc}-${var.name_attributes.project}-${var.user_defined}-${suffix}"
    },
    local.resource_type_abbreviations_gc_custom
  )
}

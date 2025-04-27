##############################
#   OSS NAMING CONVENTION    #
##############################

locals {
  location_table_oss = {
    "cc"            = "cc"
    "ce"            = "ce"
    "canadacentral" = "cc"
    "canadaeast"    = "ce"
  }
}

locals {
  location_oss = lookup(local.location_table_oss, replace(lower(var.name_attributes.location), " ", ""))

  common_convention_base_oss = "${var.name_attributes.project}-${var.name_attributes.environment}-${local.location_oss}-${local.instance}"

  resource_type_abbreviations_oss = {
    "application security group"        = "asg"
    "disk encryption set"               = "des"
    "firewall"                          = "fw"
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
    "service principal"                 = "sp"
    "user-assigned managed identity"    = "msi"
    "virtual machine"                   = "vm"
    "virtual machine scale set"         = "vmss"
    "virtual network"                   = "vnet"
    "databricks service"                = "dbw"
    "management group"                  = "mg"
    "subscription"                      = "sub"
    "virtual machine os disk"           = "osdisk"
    "virtual machine data disk"         = "datadisk"
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
    "load balancer front end interface" = "lbr"
    "load balancer rule"                = "lbbp"
    "azure application gateway"         = "agw"
    "traffic manager profile"           = "tm"
  }

  resource_type_abbreviations_oss_custom = {
    "active directory group"            = "${local.common_convention_base_gc}-adg"
    "key vault secret"                  = "${lower(local.common_convention_base_oss)}-kvs"
    "public ip address route server"    = "${local.common_convention_base_oss}-pip"
    "resource group kubernetes service" = "${local.common_convention_base_oss}-rg-managed-aks"
    "resource group backup"             = "${local.common_convention_base_oss}-rg-backup"
    "resource group platform"           = "${local.common_convention_base_oss}-rg-platform"
    "resource group secrets"            = "${local.common_convention_base_oss}-rg-secrets"
  }

  resource_names_oss = merge(
    {
      for resource_type, abbrev in local.resource_type_abbreviations_oss :
      resource_type => "${local.common_convention_base_oss}-${abbrev}"
    },
    local.resource_type_abbreviations_oss_custom
  )
}

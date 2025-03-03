locals {
################################
#   COMMON CONVENTION NAMES    #
################################

  common_conv_names = var.naming_convention == "ssc" ? local.common_conv_names_ssc : local.common_conv_names_stc
}

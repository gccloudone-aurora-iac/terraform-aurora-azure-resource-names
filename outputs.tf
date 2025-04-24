#############
## General ##
#############

output "name" {
  description = "The common prefix for an Azure resource name. Under typical circumstances, the resource type acronym would just be appended to complete the resource name."
  value       = var.naming_convention == "oss" ? local.common_convention_base_oss : local.common_convention_base_gc
}

// Scope: subscription
// Length: 1-90
// Valid Characters: Underscores, hyphens, periods, parentheses, and letters or digits. Can't end with a period.
output "resource_group_name" {
  description = "The name of an Azure Resource Group."
  value       = local.resource_names["resource group"]
}

// Scope: subscription
// Length: 1-90
// Valid Characters: Underscores, hyphens, periods, parentheses, and letters or digits. Can't end with a period.
output "resource_group_kubernetes_service_name" {
  description = "The name of an Azure Resource Group for the Kubernetes Service."
  value       = local.resource_names["resource group kubernetes service"]
}

// Scope: subscription
// Length: 1-90
// Valid Characters: Underscores, hyphens, periods, parentheses, and letters or digits. Can't end with a period.
output "resource_group_backup_name" {
  description = "The name of an Azure Resource Group for Backups."
  value       = local.resource_names["resource group backups"]
}

// Scope: subscription
// Length: 1-90
// Valid Characters: Underscores, hyphens, periods, parentheses, and letters or digits. Can't end with a period.
output "resource_group_platform_name" {
  description = "The name of an Azure Resource Group for Platform."
  value       = local.resource_names["resource group platform"]
}

// Scope: subscription
// Length: 1-90
// Valid Characters: Underscores, hyphens, periods, parentheses, and letters or digits. Can't end with a period.
output "resource_group_secrets_name" {
  description = "The name of an Azure Resource Group for Secrets."
  value       = local.resource_names["resource group secrets"]
}

// Scope: tenant
// Length: 1-90
// Valid Characters: Alphanumeric, underscore, hyphen, spaces
output "management_group_name" {
  description = "The name of an Azure Resource Group."
  value       = local.resource_names["management group"]
}

// Scope: tenant
// Length: 1-90
// Valid Characters: Alphanumeric, underscore, hyphen, spaces
output "subscription_name" {
  description = "The name of an Azure Resource Group."
  value       = local.resource_names["subscription"]
}

###############
### Network ###
###############

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "application_security_group_name" {
  description = "The name of an Azure Application Security Group."
  value       = local.resource_names["application security group"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "firewall_name" {
  description = "The name of an Azure Firewall."
  value       = local.resource_names["firewall"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "load_balancer_name" {
  description = "The name of an Azure Load Balancer."
  value       = local.resource_names["load balancer"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "network_security_group_name" {
  description = "The name of an Azure Network Security Group."
  value       = local.resource_names["network security group"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "private_endpoint_name" {
  description = "The name of an Azure Private Endpoint."
  value       = local.resource_names["private endpoint"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "public_ip_address_name" {
  description = "The name of a Public IP Address in Azure."
  value       = local.resource_names["public ip address"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "public_ip_address_route_server_name" {
  description = "The name of a Public IP Address in Azure."
  value       = local.resource_names["public ip address route server"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "route_server_name" {
  description = "The name of an Azure Route Server."
  value       = local.resource_names["route server"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "route_table_name" {
  description = "The name of an Azure Route Table."
  value       = local.resource_names["route table"]
}

// Scope: resource group
// Length: 2-80
// Valid Characters:Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End with alphanumeric or underscore.
output "route_name" {
  description = "The name of a route for a route."
  value       = local.resource_names["route"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "service_endpoint_policy_name" {
  description = "The name of an Azure Service Endpoint Policy."
  value       = local.resource_names["service endpoint policy"]
}

// Scope: resource group
// Length: 2-64
// Valid Characters: Alphanumerics, underscores, periods, and hyphens. Start with alphanumeric. End alphanumeric or underscore.
output "virtual_network_name" {
  description = "The name of an Azure Virtual Network."
  value       = local.resource_names["virtual network"]
}

// Scope: virtual network
// Length: 2-64
// Valid Characters: Alphanumeric, hyphen and underscore
output "subnet_name" {
  description = "The name of a subnet for a virtual network"
  value       = local.resource_names["subnet"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumeric, hyphen and underscore
output "bastion_end_point_name" {
  description = "The name of an Azure Bastion End-point"
  value       = local.resource_names["bastion end-point"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumeric, hyphen and underscore
output "virtual_network_gateway_name" {
  description = "The name of a virtual network gateway"
  value       = local.resource_names["bastion end-point"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumeric, hyphen and underscore
output "local_network_gateway_name" {
  description = "The name of a virtual network gateway"
  value       = local.resource_names["bastion end-point"]
}

// Scope: virtual network
// Length: 1-80
// Valid Characters: Alphanumeric, hyphen and underscore
output "connection_name" {
  description = "The name of a connection for a virtual network"
  value       = local.resource_names["connection"]
}

// Scope: resource group
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "network_security_group_rule_name" {
  description = "The name of a network security group rule."
  value       = local.resource_names["network security group rule"]
}

// Scope: resource group
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "load_balancer_front_end_interface_name" {
  description = "The name of a load balancer front end interface"
  value       = local.resource_names["load balancer front end interface"]
}

// Scope: load balancer
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "load_balancer_rules_name" {
  description = "The name of a load balancer rule"
  value       = local.resource_names["load balancer rule"]
}

// Scope: load balancer
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "load_balancer_backend_pool_name" {
  description = "The name of a load balancer backend pool"
  value       = local.resource_names["load balancer front end interface"]
}

// Scope: load balancer
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "load_balancer_health_probe_name" {
  description = "The name of a load balancer health probe"
  value       = local.resource_names["load balancer front end interface"]
}

// Scope: resource group
// Length: 1-80
// Valid Characters: Alphanumeric, hyphen and underscore
output "azure_application_gateway_name" {
  description = "The name of an azure application gateway"
  value       = local.resource_names["azure application gateway"]
}

// Scope: resource group
// Length: 1-63
// Valid Characters: Alphanumeric, hyphen and underscore
output "traffic_manager_profile_name" {
  description = "The name of a traffic manager profile"
  value       = local.resource_names["traffic manager profile"]
}


###############
### Compute ###
###############

// Scope: resource group
// Length: 2-63
// Valid Characters: The name can contain only letters, numbers, underscores, and hyphens. The name must start and end with a letter or number.
output "disk_encryption_set_name" {
  description = "The name of an Azure Disk Encryption Set."
  value       = local.resource_names["disk encryption set"]
}

// Scope: resource group
// Length: 2-63
// Valid Characters: The name can contain only letters, numbers, underscores, and hyphens. The name must start and end with a letter or number.
output "kubernetes_service_name" {
  description = "The name of an Azure Kubernetes Service."
  value       = local.resource_names["kubernetes service"]
}

// Scope: resource group
// Length: 2-63
// Valid Characters: The name can contain only letters, numbers, underscores, and hyphens. The name must start and end with a letter or number.
output "network_interface_card_name" {
  description = "The name of a Network Interface Card."
  value       = local.resource_names["network interface card"]
}

// Scope: resource group
// Length: 2-63
// Valid Characters: The name can contain only letters, numbers, underscores, and hyphens. The name must start and end with a letter or number.
output "virtual_machine_name" {
  description = "The name of an Azure Virtual Machine"
  value       = local.resource_names["virtual machine"]
}

// Scope: resource group
// Length: 2-63
// Valid Characters: The name can contain only letters, numbers, underscores, and hyphens. The name must start and end with a letter or number.
output "virtual_machine_scale_set_name" {
  description = "The name of a Virtual Machine Scale Set (VMSS)"
  value       = local.resource_names["virtual machine scale set"]
}

// Scope: resource group
// Length: 3-64
// Valid Characters: Alphanumerics, underscores, and hyphens.
output "azure_databricks_name" {
  description = "The name of an azure data brick service"
  value       = local.resource_names["databricks service"]
}

// Scope: resource group
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "virtual_machine_os_disk_name" {
  description = "The name of a managed disk for an OS disk for a virtual machine"
  value       = local.resource_names["virtual machine os disk"]
}

// Scope: resource group
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "virtual_machine_data_disk_name" {
  description = "The name of a managed disk for an OS disk for a virtual machine"
  value       = local.resource_names["virtual machine data disk"]
}

// Scope: resource group
// Length: 1-80
// Valid characters: Alphanumeric, hyphen and underscore
output "availability_set_name" {
  description = "The name of an availability set"
  value       = local.resource_names["availability set"]
}

################
### Identity ###
################

// Scope: resource group
// Length: 3-128
// Valid Characters: Alphanumerics, hyphens, and underscores. Start with letter or number.
output "managed_identity_name" {
  description = "The name of an Azure User-Assigned Managed Identity."
  value       = local.resource_names["user-assigned managed identity"]
}

// Scope: tenant
// Length: 1-255
// Valid Characters: Alphanumerics, hyphens, and underscores. Start with letter or number.
output "service_principal_name" {
  description = "The name of an Azure Service Principal."
  value       = local.resource_names["service principal"]
}

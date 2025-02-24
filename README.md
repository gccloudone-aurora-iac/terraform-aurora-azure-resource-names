# terraform-aurora-azure-resource-names

This module produces resource names using the common naming convention for various Azure resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |





## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name_attributes"></a> [name\_attributes](#input\_name\_attributes) | n/a | <pre>object({<br>    project     = string<br>    environment = string<br>    location    = string<br>    instance    = string<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_security_group_prefix"></a> [application\_security\_group\_prefix](#output\_application\_security\_group\_prefix) | The prefix of an Azure Application Security Group. |
| <a name="output_disk_encryption_set_prefix"></a> [disk\_encryption\_set\_prefix](#output\_disk\_encryption\_set\_prefix) | The prefix of an Azure Disk Encryption Set. |
| <a name="output_firewall_prefix"></a> [firewall\_prefix](#output\_firewall\_prefix) | The prefix of an Azure Firewall. |
| <a name="output_kubernetes_service_prefix"></a> [kubernetes\_service\_prefix](#output\_kubernetes\_service\_prefix) | The prefix of an Azure Kubernetes Service. |
| <a name="output_load_balancer_prefix"></a> [load\_balancer\_prefix](#output\_load\_balancer\_prefix) | The prefix of an Azure Load Balancer. |
| <a name="output_managed_identity_prefix"></a> [managed\_identity\_prefix](#output\_managed\_identity\_prefix) | The prefix of an Azure User-Assigned Managed Identity. |
| <a name="output_network_interface_card_prefix"></a> [network\_interface\_card\_prefix](#output\_network\_interface\_card\_prefix) | The prefix of a Network Interface Card. |
| <a name="output_network_security_group_prefix"></a> [network\_security\_group\_prefix](#output\_network\_security\_group\_prefix) | The prefix of an Azure Network Security Group. |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The common prefix for an Azure resource name. Under typical circumstances, the resource type acronym would just be appended to the prefix to complete the resource name. |
| <a name="output_private_endpoint_prefix"></a> [private\_endpoint\_prefix](#output\_private\_endpoint\_prefix) | The prefix of an Azure Private Endpoint. |
| <a name="output_public_ip_address_prefix"></a> [public\_ip\_address\_prefix](#output\_public\_ip\_address\_prefix) | The prefix of a Public IP Address in Azure. |
| <a name="output_resource_group_prefix"></a> [resource\_group\_prefix](#output\_resource\_group\_prefix) | The prefix of an Azure Resource Group. |
| <a name="output_route_server_prefix"></a> [route\_server\_prefix](#output\_route\_server\_prefix) | The prefix of an Azure Route Server. |
| <a name="output_route_table_prefix"></a> [route\_table\_prefix](#output\_route\_table\_prefix) | The prefix of an Azure Route Table. |
| <a name="output_service_endpoint_policy_prefix"></a> [service\_endpoint\_policy\_prefix](#output\_service\_endpoint\_policy\_prefix) | The prefix of an Azure Service Endpoint Policy. |
| <a name="output_service_principal_prefix"></a> [service\_principal\_prefix](#output\_service\_principal\_prefix) | The prefix of an Azure Service Principal. |
| <a name="output_virtual_machine_prefix"></a> [virtual\_machine\_prefix](#output\_virtual\_machine\_prefix) | The prefix of an Azure Virtual Machine |
| <a name="output_virtual_machine_scale_set_prefix"></a> [virtual\_machine\_scale\_set\_prefix](#output\_virtual\_machine\_scale\_set\_prefix) | The prefix of a Virtual Machine Scale Set (VMSS) |
| <a name="output_virtual_network_prefix"></a> [virtual\_network\_prefix](#output\_virtual\_network\_prefix) | The prefix of an Azure Virtual Network. |
<!-- END_TF_DOCS -->

## History

| Date       | Release | Change                                          |
| ---------- | ------- | ----------------------------------------------- |
| 2025-02-25 | v2.0.0  | Add SSC naming convention                       |
| 2025-01-25 | v1.0.0  | Initial commit                                  |

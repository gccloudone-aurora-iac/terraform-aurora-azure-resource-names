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
| <a name="output_application_security_group_name"></a> [application\_security\_group\_name](#output\_application\_security\_group\_name) | The name of an Azure Application Security Group. |
| <a name="output_disk_encryption_set_name"></a> [disk\_encryption\_set\_name](#output\_disk\_encryption\_set\_name) | The name of an Azure Disk Encryption Set. |
| <a name="output_firewall_name"></a> [firewall\_name](#output\_firewall\_name) | The name of an Azure Firewall. |
| <a name="output_kubernetes_service_name"></a> [kubernetes\_service\_name](#output\_kubernetes\_service\_name) | The name of an Azure Kubernetes Service. |
| <a name="output_load_balancer_name"></a> [load\_balancer\_name](#output\_load\_balancer\_name) | The name of an Azure Load Balancer. |
| <a name="output_managed_identity_name"></a> [managed\_identity\_name](#output\_managed\_identity\_name) | The name of an Azure User-Assigned Managed Identity. |
| <a name="output_network_interface_card_name"></a> [network\_interface\_card\_name](#output\_network\_interface\_card\_name) | The name of a Network Interface Card. |
| <a name="output_network_security_group_name"></a> [network\_security\_group\_name](#output\_network\_security\_group\_name) | The name of an Azure Network Security Group. |
| <a name="output_name"></a> [name](#output\_name) | The common name for an Azure resource name. Under typical circumstances, the resource type acronym would just be appended to the name to complete the resource name. |
| <a name="output_private_endpoint_name"></a> [private\_endpoint\_name](#output\_private\_endpoint\_name) | The name of an Azure Private Endpoint. |
| <a name="output_public_ip_address_name"></a> [public\_ip\_address\_name](#output\_public\_ip\_address\_name) | The name of a Public IP Address in Azure. |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | The name of an Azure Resource Group. |
| <a name="output_route_server_name"></a> [route\_server\_name](#output\_route\_server\_name) | The name of an Azure Route Server. |
| <a name="output_route_table_name"></a> [route\_table\_name](#output\_route\_table\_name) | The name of an Azure Route Table. |
| <a name="output_service_endpoint_policy_name"></a> [service\_endpoint\_policy\_name](#output\_service\_endpoint\_policy\_name) | The name of an Azure Service Endpoint Policy. |
| <a name="output_service_principal_name"></a> [service\_principal\_name](#output\_service\_principal\_name) | The name of an Azure Service Principal. |
| <a name="output_virtual_machine_name"></a> [virtual\_machine\_name](#output\_virtual\_machine\_name) | The name of an Azure Virtual Machine |
| <a name="output_virtual_machine_scale_set_name"></a> [virtual\_machine\_scale\_set\_name](#output\_virtual\_machine\_scale\_set\_name) | The name of a Virtual Machine Scale Set (VMSS) |
| <a name="output_virtual_network_name"></a> [virtual\_network\_name](#output\_virtual\_network\_name) | The name of an Azure Virtual Network. |
<!-- END_TF_DOCS -->

## History

| Date       | Release | Change                                          |
| ---------- | ------- | ----------------------------------------------- |
| 2025-02-25 | v2.0.0  | Add SSC naming convention                       |
| 2025-01-25 | v1.0.0  | Initial commit                                  |

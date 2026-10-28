output "resource_group_name" {
  description = "Name of the Azure foundation resource group."
  value       = azurerm_resource_group.foundation.name
}

output "virtual_network_id" {
  description = "Resource ID of the foundation VNet."
  value       = azurerm_virtual_network.foundation.id
}

output "workload_subnet_id" {
  description = "Resource ID of the workload subnet."
  value       = azurerm_subnet.workload.id
}

output "storage_account_name" {
  description = "Private storage account name."
  value       = azurerm_storage_account.foundation.name
}

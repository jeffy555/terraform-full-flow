output "resource_group_id" {
  description = "The ID of the resource group."
  value       = azurerm_resource_group.terraform_root_rg.id
}

output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.terraformroot996262.id
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint for the storage account."
  value       = azurerm_storage_account.terraformroot996262.primary_blob_endpoint
}

output "virtual_network_id" {
  description = "The ID of the virtual network."
  value       = azurerm_virtual_network.terraform_root_vnet.id
}

output "subnet_id" {
  description = "The ID of the subnet."
  value       = azurerm_subnet.terraform_root_subnet.id
}

output "nsg_id" {
  description = "The ID of the network security group."
  value       = azurerm_network_security_group.terraform_root_nsg.id
}

output "key_vault_id" {
  description = "The ID of the Azure Key Vault."
  value       = azurerm_key_vault.terraformrootkv996262.id
}

output "terraform_root_vm_id" {
  description = "The ID of the Virtual Machine."
  value       = azurerm_windows_virtual_machine.terraform_root_vm.id
}

output "terraform_root_vm_private_ip" {
  description = "The private IP address of the VM."
  value       = azurerm_network_interface.terraform_root_vm_nic.private_ip_address
}

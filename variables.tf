variable "location" {
  type        = string
  description = "Azure region for all resources."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to all resources."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "storage_account_name" {
  type        = string
  description = "Name of the storage account."
}

variable "storage_account_replication_type" {
  type        = string
  description = "Replication type for the storage account."
}

variable "public_container_name" {
  type        = string
  description = "Name of the public blob container."
}

variable "private_container_name" {
  type        = string
  description = "Name of the private blob container."
}

variable "default_container_name" {
  type        = string
}

variable "virtual_network_name" {
  type        = string
  description = "Name of the virtual network."
}

variable "virtual_network_address_space" {
  type        = list(string)
  description = "Address space for the virtual network."
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet."
}

variable "subnet_address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet."
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group."
}

variable "key_vault_name" {
  type        = string
  description = "Name of the Azure Key Vault."
}

variable "account_tier" {
  description = "Value for account_tier"
  type        = string
}

variable "type" {
  description = "Value for type"
  type        = string
}

variable "name" {
  description = "Value for name"
  type        = string
}

variable "environment" {
  description = "Value for environment"
  type        = string
}

variable "owner" {
  description = "Value for owner"
  type        = string
}

# cicd-fix: Documented in vm_size variable that the value must be available in the selected Azure region.
# cicd-fix: Documented that vm_size must be available in the selected Azure region.
variable "vm_size" {
  type        = string
# cicd-fix: Documented in vm_size variable that the value must be available in the selected Azure region.
  description = "The size of the Virtual Machine. Example: Standard_DS1_v2. Must be available in the selected Azure region."
}

variable "vm_admin_username" {
  type        = string
  description = "The admin username for the Virtual Machine."
  sensitive   = true
}

variable "vm_admin_password" {
  type        = string
  description = "The admin password for the Virtual Machine."
  sensitive   = true
}

variable "vm_image_publisher" {
  type        = string
  description = "The publisher of the VM image. Example: MicrosoftWindowsServer."
}

variable "vm_image_offer" {
  type        = string
  description = "The offer of the VM image. Example: WindowsServer."
}

variable "vm_image_sku" {
  type        = string
  description = "The SKU of the VM image. Example: 2019-Datacenter."
}

variable "vm_image_version" {
  type        = string
  description = "The version of the VM image. Use 'latest' for latest version."
}

variable "storage_account_type" {
  description = "Value for storage_account_type"
  type        = string
}

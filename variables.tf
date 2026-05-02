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
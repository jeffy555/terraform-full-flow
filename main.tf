resource "azurerm_resource_group" "terraform_root_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_storage_account" "terraformroot996262" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.terraform_root_rg.name
  location                 = azurerm_resource_group.terraform_root_rg.location
  account_tier             = var.account_tier
  account_replication_type = var.storage_account_replication_type
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = false
  enable_https_traffic_only = true
  tags                     = var.tags
}

resource "azurerm_storage_container" "public" {
  name                  = var.public_container_name
  storage_account_name  = azurerm_storage_account.terraformroot996262.name
  container_access_type = var.type
}

resource "azurerm_storage_container" "private" {
  name                  = var.private_container_name
  storage_account_name  = azurerm_storage_account.terraformroot996262.name
  container_access_type = var.type
}

resource "azurerm_storage_container" "default" {
  name                  = var.default_container_name
  storage_account_name  = azurerm_storage_account.terraformroot996262.name
  container_access_type = var.type
}

resource "azurerm_virtual_network" "terraform_root_vnet" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address_space
  location            = azurerm_resource_group.terraform_root_rg.location
  resource_group_name = azurerm_resource_group.terraform_root_rg.name
  tags                = var.tags
}

resource "azurerm_subnet" "terraform_root_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.terraform_root_rg.name
  virtual_network_name = azurerm_virtual_network.terraform_root_vnet.name
  address_prefixes     = var.subnet_address_prefixes
}

resource "azurerm_network_security_group" "terraform_root_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.terraform_root_rg.location
  resource_group_name = azurerm_resource_group.terraform_root_rg.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "allow_https_inbound" {
  name                        = var.name
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  network_security_group_name = azurerm_network_security_group.terraform_root_nsg.name
  resource_group_name         = azurerm_resource_group.terraform_root_rg.name
  description                 = "Allow inbound HTTPS from Internet."
}

resource "azurerm_subnet_network_security_group_association" "terraform_root_subnet_assoc" {
  subnet_id                 = azurerm_subnet.terraform_root_subnet.id
  network_security_group_id = azurerm_network_security_group.terraform_root_nsg.id
}

resource "azurerm_key_vault" "terraformrootkv996262" {
  name                        = var.key_vault_name
  location                    = azurerm_resource_group.terraform_root_rg.location
  resource_group_name         = azurerm_resource_group.terraform_root_rg.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = var.name
  enable_rbac_authorization   = true
  soft_delete_enabled         = true
  purge_protection_enabled    = true
  public_network_access_enabled = true
  tags                       = var.tags
}

data "azurerm_client_config" "current" {}
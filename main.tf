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
  allow_nested_items_to_be_public = false
  https_traffic_only_enabled = true
  tags                     = var.tags
}

locals {
  container_names = [var.public_container_name, var.private_container_name, var.default_container_name]
}

resource "azurerm_storage_container" "containers" {
  for_each            = toset(local.container_names)
  name               = each.key
  storage_account_id = azurerm_storage_account.terraformroot996262.id
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
# cicd-fix: Replaced the deprecated Key Vault RBAC argument with rbac_authorization_enabled for azurerm 4.x.
  # cicd-fix: Use a valid Key Vault SKU instead of the shared name variable.
  sku_name                    = "standard"
  # cicd-fix: Use azurerm 4.x Key Vault RBAC argument name.
  rbac_authorization_enabled  = true
  purge_protection_enabled    = true
  public_network_access_enabled = true
  tags                       = var.tags
}

data "azurerm_client_config" "current" {}

resource "azurerm_network_interface" "terraform_root_vm_nic" {
  name                = var.name
  location            = azurerm_resource_group.terraform_root_rg.location
  resource_group_name = azurerm_resource_group.terraform_root_rg.name

  ip_configuration {
    name                          = var.name
    subnet_id                     = azurerm_subnet.terraform_root_subnet.id
# cicd-fix: Replaced the deprecated Key Vault RBAC argument with rbac_authorization_enabled for azurerm 4.x.
    # cicd-fix: Use a valid NIC private IP allocation value for azurerm 4.x.
    private_ip_address_allocation = "Dynamic"
  }

# cicd-fix: Replaced the deprecated Key Vault RBAC argument with rbac_authorization_enabled for azurerm 4.x.
  # cicd-fix: Removed unsupported NIC network_security_group_id; subnet NSG association applies the NSG.
  tags = var.tags
}

resource "azurerm_windows_virtual_machine" "terraform_root_vm" {
  name                = var.name
  location            = azurerm_resource_group.terraform_root_rg.location
  resource_group_name = azurerm_resource_group.terraform_root_rg.name
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password
  network_interface_ids = [azurerm_network_interface.terraform_root_vm_nic.id]

  os_disk {
    name              = var.name
    caching           = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
# cicd-fix: Replaced the deprecated Key Vault RBAC argument with rbac_authorization_enabled for azurerm 4.x.
    # cicd-fix: Use the configured Windows image SKU instead of the VM size SKU.
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  enable_automatic_updates = true
  provision_vm_agent       = true

  tags = var.tags
}

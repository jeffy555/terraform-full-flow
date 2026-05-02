location = "eastus"
resource_group_name = "terraform-root-rg"
storage_account_name = "terraformroot996262"
storage_account_replication_type = "LRS"
public_container_name = "public"
private_container_name = "private"
default_container_name = "default"
virtual_network_name = "terraform-root-vnet"
virtual_network_address_space = ["10.10.0.0/16"]
subnet_name = "terraform-root-subnet"
subnet_address_prefixes = ["10.10.1.0/24"]
nsg_name = "terraform-root-nsg"
key_vault_name = "terraformrootkv996262"
tags = {
  environment = "production"
  owner       = "terraform"
}

name = "Allow-HTTPS-Inbound"

account_tier = "Standard"
type = "private"
environment = "production"
owner = "terraform"

vm_size            = "Standard_DS1_v2"
vm_admin_username  = "azureuser"
vm_admin_password  = "P@ssw0rd1234!"
vm_image_publisher = "MicrosoftWindowsServer"
vm_image_offer     = "WindowsServer"
vm_image_sku       = "2019-Datacenter"
vm_image_version   = "latest"

storage_account_type = "Standard_LRS"

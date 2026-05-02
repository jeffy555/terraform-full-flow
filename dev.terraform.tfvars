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
# cicd-fix: Added values for the existing required environment and owner variables so CI can plan without prompting.
# cicd-fix: provide values for existing required variables in non-interactive CI plan.
environment = "production"
# cicd-fix: provide values for existing required variables in non-interactive CI plan.
owner = "terraform"

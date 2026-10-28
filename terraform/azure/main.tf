locals {
  common_tags = {
    Environment = var.environment
    Owner       = var.owner
    Application = "enterprise-platform"
    CostCenter  = "platform"
    ManagedBy   = "Terraform"
  }

  storage_name = substr(replace(lower("${var.name_prefix}${var.environment}state"), "-", ""), 0, 24)
}

resource "azurerm_resource_group" "foundation" {
  name     = "rg-${var.name_prefix}-${var.environment}"
  location = var.location
  tags     = local.common_tags
}

resource "azurerm_virtual_network" "foundation" {
  name                = "vnet-${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.foundation.location
  resource_group_name = azurerm_resource_group.foundation.name
  address_space       = var.address_space
  tags                = local.common_tags
}

resource "azurerm_subnet" "workload" {
  name                 = "snet-workload"
  resource_group_name  = azurerm_resource_group.foundation.name
  virtual_network_name = azurerm_virtual_network.foundation.name
  address_prefixes     = var.subnet_prefixes
}

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-${var.name_prefix}-${var.environment}"
  location            = azurerm_resource_group.foundation.location
  resource_group_name = azurerm_resource_group.foundation.name
  tags                = local.common_tags

  # No broad inbound allow rule is defined. Add app-specific rules after security review.
}

resource "azurerm_subnet_network_security_group_association" "workload" {
  subnet_id                 = azurerm_subnet.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

resource "azurerm_storage_account" "foundation" {
  name                            = local.storage_name
  resource_group_name             = azurerm_resource_group.foundation.name
  location                        = azurerm_resource_group.foundation.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  allow_nested_items_to_be_public = false
  public_network_access_enabled   = false
  infrastructure_encryption_enabled = true
  shared_access_key_enabled       = false
  tags                            = local.common_tags
}

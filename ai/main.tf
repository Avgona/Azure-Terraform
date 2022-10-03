terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.23.0"
    }
  }
}
provider "azurerm" {
  client_id       = "60dc240b-5736-4811-8fc5-b1a925426a04"
  tenant_id       = "6ddec164-95ff-48a1-b874-61fe191eb8b4"
  client_secret   = "zc98Q~uoD9zYZy6CWwYgFZGT_qTTsVVbqfn~RaU9"
  subscription_id = "c9f1e2be-70ea-4852-b506-05c49109baa0"
  features {}
}

data "azurerm_resource_group" "resource-group" {
  name = var.resourceGroupName
}


resource "azurerm_storage_account" "blob_storage" {
  name                     = var.storage.name
  account_kind             = var.storage.account_kind
  account_tier             = var.storage.account_tier
  account_replication_type = var.storage.account_replication_type
  resource_group_name      = data.azurerm_resource_group.resource_group.name
  location                 = data.azurerm_resource_group.resource_group.location
}
resource "azurerm_storage_container" "container" {
  name                  = var.container.name
  storage_account_name  = azurerm_storage_account.blob_storage.name
  container_access_type = var.container.container_access_type
}


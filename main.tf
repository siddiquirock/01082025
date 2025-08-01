resource "azurerm_resource_group" "tfrevision" {
  name     = "xyz"
  location = "US"


}

provider "azurerm" {
      features {}
  subscription_id = "709e014e-7a63-438d-aacd-9a26332e0948"
}
resource "azurerm_storage_account" "abcd3456" {
  name                     = "abcd3456"
  resource_group_name      = azurerm_resource_group.tfrevision.name
  location                 = azurerm_resource_group.tfrevision.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
resource "azurerm_storage_container" "container" {
  name                  = "devops-container"         # ✅ lowercase + hyphen only
  storage_account_name = "abcd3456"                  # ← आपका storage account name
  container_access_type = "private"                  # या "blob", "container"
}
terraform {
  backend "azurerm" {
    resource_group_name   = "xyz"
    storage_account_name  = "abcd3456"
    container_name        = "devops-container"
    key                   = "terraform.tfstate3"
  }
}

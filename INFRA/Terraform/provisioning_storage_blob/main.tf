resource "azurerm_resource_group" "secgrp_app" {
  name     = "app-grp"
  location = var.region
}

resource "azurerm_storage_account" "storage_acc" {
  name                     = "terraformstorage1203094"
  resource_group_name      = azurerm_resource_group.secgrp_app.name
  location                 = var.region
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "data" {
  name                  = "data"
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = "private"
}

//In the source file you have to specify the path of the file you want to upload to the blob storage
resource "azurerm_storage_blob" "sample_file" {
  name                   = "sample.txt"
  storage_account_name   = azurerm_storage_account.storage_acc.name
  storage_container_name = azurerm_storage_container.data.name
  type                   = "Block"
  source                 = var.file_path
}


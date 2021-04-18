# storage part of Azure infrastructure

######################
#create storage account
######################

resource "azurerm_storage_account" "tf_storage" {
  name                      = var.storage_name
  resource_group_name       = var.rg_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  enable_https_traffic_only = true
  allow_blob_public_access  = true

  static_website {
    index_document = "index.html"
  }
}

######################
#create storage container
######################

resource "azurerm_storage_container" "tf_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.tf_storage.name
  container_access_type = "blob"
}

######################
#add cloud.jpg file to storage container
######################

resource "azurerm_storage_blob" "tf_blob" {
  name                   = "cloud.jpg"
  storage_account_name   = azurerm_storage_account.tf_storage.name
  storage_container_name = azurerm_storage_container.tf_container.name
  type                   = "Block"
  source                 = "${path.module}/cloud.jpg"
}
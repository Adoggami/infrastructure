resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "photos" {
  name                  = "photos"
  # Usiamo storage_account_name per compatibilità con la versione di GitHub Actions
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

output "name"                { value = azurerm_storage_account.this.name }
output "primary_access_key"  { value = azurerm_storage_account.this.primary_access_key }

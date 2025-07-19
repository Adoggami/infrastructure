resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "photos" {
  name                  = "photos"
  storage_account_id  = azurerm_storage_account.this.id
  container_access_type = "private"
}

output "name"                { value = azurerm_storage_account.this.name }
output "primary_access_key"  { value = azurerm_storage_account.this.primary_access_key }

# Bootstrap per il backend state di Terraform
# Questo codice va eseguito una sola volta per creare le risorse necessarie per il backend

# Configurazione del provider Azure
provider "azurerm" {
  features {}
}

# Resource group per il backend state
resource "azurerm_resource_group" "tfstate" {
  name     = "rg-adoggami-tfstate"
  location = "westeurope"
  
  tags = {
    Environment = "management"
    Purpose     = "terraform-state"
    ManagedBy   = "terraform"
    Stage       = "infrastructure"
  }
}

# Storage account per il backend state
resource "azurerm_storage_account" "tfstate" {
  name                     = "sttfadoggami"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  min_tls_version         = "TLS1_2"

  tags = {
    Environment = "management"
    Purpose     = "terraform-state"
    ManagedBy   = "terraform"
  }
}

# Container per il backend state
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate.id
  container_access_type = "private"
}

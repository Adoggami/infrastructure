# Configurazione del backend Azure per lo stato remoto di Terraform
# Questo garantisce che lo stato sia salvato in modo sicuro e condivisibile
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-adoggami-tfstate"  # Resource group dedicato per il backend
    storage_account_name = "sttfadoggami"         # Storage account per il tfstate
    container_name       = "tfstate"              # Container dedicato per gli stati
    key                  = "adoggami.dev.tfstate" # Nome del file di stato
  }
}

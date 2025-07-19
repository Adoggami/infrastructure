variable "name" { 
  description = "Nome della Function App"
  type = string 
}

variable "rg_name" { 
  description = "Nome del Resource Group"
  type = string 
}

variable "location" { 
  description = "Azure Region dove creare le risorse"
  type = string 
}

variable "sa_name" { 
  description = "Nome dello Storage Account per la Function App"
  type = string 
}

variable "sa_key" { 
  description = "Chiave di accesso dello Storage Account"
  type = string 
  sensitive = true
}

variable "postgres_conn" { 
  description = "Stringa di connessione a PostgreSQL"
  type = string 
  sensitive = true
}

variable "extra_settings" {
  description = "Impostazioni aggiuntive per la Function App"
  type    = map(string)
  default = {}
}

variable "sku_name" {
  description = "SKU del Service Plan"
  type        = string
  default     = "Y1"  # Consumption plan
}

variable "tags" {
  description = "Tag da applicare alle risorse"
  type        = map(string)
  default     = {}
}

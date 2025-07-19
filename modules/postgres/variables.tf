variable "name" { 
  description = "Nome del server PostgreSQL"
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

variable "admin_user" { 
  description = "Username amministratore PostgreSQL"
  type = string 
}

variable "admin_pass" { 
  description = "Password amministratore PostgreSQL"
  type = string 
  sensitive = true
}

variable "sku_name" {
  description = "SKU del server PostgreSQL"
  type        = string
  default     = "B_Standard_B1ms"  # Entry-level per sviluppo
}

variable "storage_mb" {
  description = "Dimensione storage in MB"
  type        = number
  default     = 32768  # 32GB
}

variable "tags" {
  description = "Tag da applicare alle risorse"
  type        = map(string)
  default     = {}
}

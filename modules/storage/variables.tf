variable "name" { 
  description = "Nome dello storage account"
  type = string 
}
variable "rg_name" { 
  description = "Nome del resource group"
  type = string 
}
variable "location" { 
  description = "Azure region dove creare le risorse"
  type = string 
}
variable "tags" {
  description = "Tag da applicare alle risorse"
  type        = map(string)
  default     = {}
}

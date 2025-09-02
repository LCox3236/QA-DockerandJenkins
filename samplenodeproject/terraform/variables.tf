variable "client_id" {
  description = "The client ID for the application"
}
variable "client_secret" {
  description = "The client secret for the application"
}
variable "tenant_id" {
  description = "The tenant ID for the application"
}
variable "subscription_id" {
  description = "The subscription ID for the application"
}
variable "rg_name" {
  description = "The name of the resource group"
  default     = "rg-lewisc-1"
}
variable "rg_location" {
  description = "The Azure region to deploy resources in"
  default     = "UK South"
  
}
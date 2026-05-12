# variable "deployment_subscription_id" {
#   description = "The subscription ID where the infrastructure will be deployed."
#   type        = string
# }

variable "region" {
  description = "The Azure region where resources will be deployed."
#   type        = string
#   default     = "eastus"
}

variable "environment" {
  description = "The deployment environment (e.g., dev, uat, prod)."  
}
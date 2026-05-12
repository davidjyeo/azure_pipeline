variable "region" {
  description = "The Azure region where resources will be deployed."
}

variable "environment" {
  description = "The deployment environment (e.g., dev, uat, prod)."  
}

variable "enable_telemetry" {
  description = "Enable telemetry for Azure modules that support it."
  type        = bool
  default     = false  
}
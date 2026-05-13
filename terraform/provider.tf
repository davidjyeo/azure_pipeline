terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
    }
    #     azapi = {
    #       source = "azure/azapi"
    #     }
    #     random = {
    #       source = "hashicorp/random"
    #     }
    #     modtm = {
    #       source = "Azure/modtm"
    #     }
    #     local = {
    #       source = "hashicorp/local"
    #     }
    #     azuread = {
    #       source = "hashicorp/azuread"
    #     }
    #     tls = {
    #       source = "hashicorp/tls"
    #     }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  use_oidc            = true
  storage_use_azuread = true
  use_cli             = false

  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    virtual_machine {
      delete_os_disk_on_deletion     = true
      skip_shutdown_and_force_delete = true
    }
  }

}

#provider "azurerm" {
#  alias           = "plat-mon"
#  subscription_id = "dee5be86-5d21-435a-b43b-1d057ab65627"
#  use_oidc        = true
#  features {}
#}

#provider "azapi" {}

#provider "azuread" {
#  use_oidc  = true # or use the environment variable "ARM_USE_OIDC=true"
#  tenant_id = data.azurerm_subscription.current.tenant_id
#}

data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

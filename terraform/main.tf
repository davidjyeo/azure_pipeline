module "resource_group" {
  version  = "0.4.0"
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  name     = "${module.naming.resource_group.name}-01"
  location = "uksouth"
}

module "resource_group_uami" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  name     = "${module.naming.resource_group.name}-01-uami"
  location = "uksouth"
}

module "user_assigned_identity" {
  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  name                = "${module.naming.user_assigned_identity.name}-01"
  location            = module.resource_group_uami.location
  resource_group_name = module.resource_group_uami.name
  enable_telemetry    = var.enable_telemetry

  federated_identity_credentials = {
    github_actions = {
      name         = "github-actions"
      issuer       = "https://token.actions.githubusercontent.com"
      subject      = "repo:davidjyeo/azure_pipeline:ref:refs/heads/main"
      descriptions = "Federated identity credential for GitHub Actions"
    }
  }

}



# module "storage_account" {
#   version                       = "0.6.7"
#   source                        = "Azure/avm-res-storage-storageaccount/azurerm"
#   name                          = replace("${module.naming.storage_account.name}-01", "-", "")
#   location                      = module.resource_group.location
#   resource_group_name           = module.resource_group.name
#   account_replication_type      = "LRS"
#   account_kind                  = "StorageV2"
#   account_tier                  = "Premium"
#   enable_telemetry              = false
#   shared_access_key_enabled     = true
#   public_network_access_enabled = true

#   managed_identities = {
#     system_assigned = true
#   }

#   network_rules = {
#     bypass = [
#       "AzureServices"
#     ]
#     default_action = "Allow"
#   }

#   # role_assignments = merge(
#   #   # {
#   #   #   for vm_key, vm in local.vm_definitions :
#   #   #   "blob_contributor_${vm_key}" => {
#   #   #     role_definition_id_or_name       = "Storage Blob Data Contributor"
#   #   #     principal_id                     = module.avm-res-compute-virtualmachine[vm_key].system_assigned_mi_principal_id
#   #   #     skip_service_principal_aad_check = false
#   #   #   }
#   #   # },
#   #   # {
#   #   #   for vm_key, vm in local.vm_definitions :
#   #   #   "queue_contributor_${vm_key}" => {
#   #   #     role_definition_id_or_name       = "Storage Queue Data Contributor"
#   #   #     principal_id                     = module.avm-res-compute-virtualmachine[vm_key].system_assigned_mi_principal_id
#   #   #     skip_service_principal_aad_check = false
#   #   #   }
#   #   # },
#   #   {
#   #     "contributor" = {
#   #       role_definition_id_or_name       = "Contributor"
#   #       principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
#   #       skip_service_principal_aad_check = false
#   #     }
#   #   },
#   #   {
#   #     "storage_account_contributor" = {
#   #       role_definition_id_or_name       = "Storage Account Contributor"
#   #       principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
#   #       skip_service_principal_aad_check = false
#   #     }
#   #   },
#   #   {
#   #     "storage_blob_data_contributor" = {
#   #       role_definition_id_or_name       = "Storage Blob Data Contributor"
#   #       principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
#   #       skip_service_principal_aad_check = false
#   #     }
#   #   }
#   # )

#   # private_endpoints = {
#   #   primary = {
#   #     name                          = "plat-fs-prd-uks-pe-rsv-01-sa"
#   #     private_dns_zone_resource_ids = ["/subscriptions/7641f99e-0503-4c58-b2e7-a7d44dcd31fb/resourceGroups/plat-conn-prd-uks-rg-privatednszones/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
#   #     subnet_resource_id            = data.azurerm_subnet.snet.id
#   #     network_interface_name        = "plat-fs-prd-uks-pe-rsv-01-sa-nic"
#   #     ip_configurations = {
#   #       staticIpConfig = {
#   #         name = "plat-fs-prd-uks-pe-rsv-01-sa-ipConfig"
#   #         # private_ip_address = "10.16.8.126"
#   #       }
#   #     }
#   #   }
#   # }

# }

# # module "storage_account" {
# #   version                       = "0.7.0"
# #   source                        = "Azure/avm-res-storage-storageaccount/azurerm"
# #   name                          = replace("${module.naming.storage_account.name}-01", "-", "")
# #   location                      = module.resource_group.location
# #   parent_id                     = module.resource_group.resource_id
# #   enable_telemetry              = false
# #   shared_access_key_enabled     = true
# #   public_network_access_enabled = true
# #   account_kind                  = "StorageV2"
# #   account_sku_name              = "PremiumV2_LRS"

# #   managed_identities = {
# #     system_assigned = true
# #   }

# #   network_rules = {
# #     bypass = [
# #       "AzureServices"
# #     ]
# #     default_action = "Allow"
# #   }

# #   #   role_assignments = merge(
# #   #     # {
# #   #     #   for vm_key, vm in local.vm_definitions :
# #   #     #   "blob_contributor_${vm_key}" => {
# #   #     #     role_definition_id_or_name       = "Storage Blob Data Contributor"
# #   #     #     principal_id                     = module.avm-res-compute-virtualmachine[vm_key].system_assigned_mi_principal_id
# #   #     #     skip_service_principal_aad_check = false
# #   #     #   }
# #   #     # },
# #   #     # {
# #   #     #   for vm_key, vm in local.vm_definitions :
# #   #     #   "queue_contributor_${vm_key}" => {
# #   #     #     role_definition_id_or_name       = "Storage Queue Data Contributor"
# #   #     #     principal_id                     = module.avm-res-compute-virtualmachine[vm_key].system_assigned_mi_principal_id
# #   #     #     skip_service_principal_aad_check = false
# #   #     #   }
# #   #     # },
# #   #     {
# #   #       "contributor" = {
# #   #         role_definition_id_or_name       = "Contributor"
# #   #         principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
# #   #         skip_service_principal_aad_check = false
# #   #       }
# #   #     },
# #   #     {
# #   #       "storage_account_contributor" = {
# #   #         role_definition_id_or_name       = "Storage Account Contributor"
# #   #         principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
# #   #         skip_service_principal_aad_check = false
# #   #       }
# #   #     },
# #   #     {
# #   #       "storage_blob_data_contributor" = {
# #   #         role_definition_id_or_name       = "Storage Blob Data Contributor"
# #   #         principal_id                     = module.avm-res-recoveryservices-vault.resource.identity[0].principal_id
# #   #         skip_service_principal_aad_check = false
# #   #       }
# #   #     }
# #   #   )

# #   # private_endpoints = {
# #   #   primary = {
# #   #     name                          = "plat-fs-prd-uks-pe-rsv-01-sa"
# #   #     private_dns_zone_resource_ids = ["/subscriptions/7641f99e-0503-4c58-b2e7-a7d44dcd31fb/resourceGroups/plat-conn-prd-uks-rg-privatednszones/providers/Microsoft.Network/privateDnsZones/privatelink.blob.core.windows.net"]
# #   #     subnet_resource_id            = data.azurerm_subnet.snet.id
# #   #     network_interface_name        = "plat-fs-prd-uks-pe-rsv-01-sa-nic"
# #   #     ip_configurations = {
# #   #       staticIpConfig = {
# #   #         name = "plat-fs-prd-uks-pe-rsv-01-sa-ipConfig"
# #   #         # private_ip_address = "10.16.8.126"
# #   #       }
# #   #     }
# #   #   }
# #   # }

# #   #   depends_on = [
# #   #     module.avm-res-recoveryservices-vault
# #   #   ]

# # }

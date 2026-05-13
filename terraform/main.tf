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
  # Convert the list of subscription objects into a map keyed by subscription ID
  for_each = {
    for subscription in data.azurerm_subscriptions.available.subscriptions :
    subscription.subscription_id => subscription
  }

  source              = "Azure/avm-res-managedidentity-userassignedidentity/azurerm"
  name                = lower(each.value.display_name)
  location            = module.resource_group_uami.location
  resource_group_name = module.resource_group_uami.name
  enable_telemetry    = var.enable_telemetry

  # federated_identity_credentials = {
  #   github_actions = {
  #     name    = "github-actions"
  #     issuer  = "https://token.actions.githubusercontent.com"
  #     subject = "repo:davidjyeo/azure_pipeline:ref:refs/heads/main"

  #     audience = [
  #       "api://AzureADTokenExchange"
  #     ]

  #   }
  # }

}

# Assign Owner role to each UAMI at the corresponding subscription scope
resource "azurerm_role_assignment" "subscription_owner" {
  for_each = {
    for subscription in data.azurerm_subscriptions.available.subscriptions :
    subscription.subscription_id => subscription
  }

  scope                = "/subscriptions/${each.key}"
  role_definition_name = "Owner"
  principal_id         = module.user_assigned_identity[each.key].principal_id
}

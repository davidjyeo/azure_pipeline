# output "region_short_name" {
#   value = module.avm-utl-regions.regions.short_name
# }

output "subscriptions" {
  value = data.azurerm_subscriptions.available.subscriptions
}

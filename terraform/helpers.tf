module "naming" {
#   version  = "0.4.3"
  source   = "Azure/naming/azurerm"
  prefix = [
    "az",
    "djy",
    var.environment
  ]
}

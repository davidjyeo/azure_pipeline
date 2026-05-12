module "naming" {
#   version  = "0.4.3"
  source   = "Azure/naming/azurerm"
  suffix = [
    "az",
    "djy",
    var.environment
  ]
}

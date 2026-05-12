module "naming" {
#   version  = "0.4.3"
  source   = "Azure/naming/azurerm"
  suffix = [
    "az",
    "djy",
    var.environment
  ]
}


module "avm-utl-regions" {
    version = "0.12.0"
    source  = "Azure/avm-utl-regions/azurerm"

}
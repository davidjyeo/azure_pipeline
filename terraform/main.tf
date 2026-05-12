# resource "azurerm_resource_group" "this" {
#     name     = "rg-plat-mon"
#     location = "uksouth"
# }

module "rg" {
    version = "0.4.0"
    source  = "Azure/avm-res-resources-resourcegroup/azurerm"
    name     = "${module.naming.resource_group.name}-01"
    location = "uksouth"
}
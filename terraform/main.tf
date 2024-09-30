
resource "azurerm_resource_group" "aks_rg" {
  name     = "rg_aks"
  location = "northeurope"
}

resource "azurerm_kubernetes_cluster" "clus" {
  name                = "mat-aks"
  location            = "northeurope"
  resource_group_name = azurerm_resource_group.aks_rg.name

  dns_prefix = "matclus"

  default_node_pool {
    name                = "matdefault"
    vm_size             = "Standard_D2_v2"
    enable_auto_scaling = false
    node_count          = 1
    
  }
  identity {
    type = "SystemAssigned"
  }
}

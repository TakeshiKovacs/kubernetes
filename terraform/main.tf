
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
    node_count          = 2
    
  }
  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
  }
}

resource "azurerm_role_assignment" "aks_contributor" {
  scope                = azurerm_resource_group.aks_rg.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_kubernetes_cluster.clus.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "aks_contributor2" {
  scope                = azurerm_resource_group.aks_rg.id
  role_definition_name = "Contributor"
  principal_id         = "74f108b0-2511-4895-8e2a-17a62cbda10c"
}
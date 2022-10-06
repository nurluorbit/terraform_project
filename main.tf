resource "azurerm_resource_group" "dev-rg" {
  name     = "dev-resources"
  location = "West Europe"
  tags = {
    environment = "dev"
  }
}

resource "azurerm_virtual_network" "dev-vn" {
  name                = "dev-network"
  resource_group_name = azurerm_resource_group.dev-rg.name
  location            = azurerm_resource_group.dev-rg.location
  address_space       = ["10.123.0.0/24"]

  tags = {
    environment = "dev"
  }
}

resource "azurerm_subnet" "dev-subnet" {
  name                 = "dev-subnet"
  resource_group_name  = azurerm_resource_group.dev-rg.name
  virtual_network_name = azurerm_virtual_network.dev-vn.name
  address_prefixes     = ["10.123.0.0/28"]

}

resource "azurerm_kubernetes_cluster" "dev-aks" {
  name                = "dev-aks"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name
  dns_prefix          = "devaks"

  default_node_pool {
    name       = "devagent_system"
    node_count = 1
    vm_size    = "Standard_D2_v2"

  }

  service_principal {
    client_id     = "1a0a5f71-9201-4bb3-9eb1-6e188d1e8ecb"
    client_secret = "WRR8Q~zTLhBm-eddihBOhh.So.sVbfBnpz7jUcoJ"
  }

  tags = {
    environment = "dev"
    cluster_name = "devaks-k8s"
    }

  role_based_access_control {
    enabled = true
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "dev-aks" {
  name                  = "devagent_user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.dev-aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1

  tags = {
    Environment = "dev"
  }
}

resource "azurerm_network_interface" "dev-nic" {
  name                = "dev-nic"
  location            = azurerm_resource_group.dev-rg.location
  resource_group_name = azurerm_resource_group.dev-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.dev-subnet.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "dev"
  }
}
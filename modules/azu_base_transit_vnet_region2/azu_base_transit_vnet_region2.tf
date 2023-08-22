terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.7"
    }
  }
}

provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "transit_rg_name" {
  name     = var.transit_rg_name
  location = var.region2
}

resource "azurerm_virtual_network" "transit_vnet1" {
  name = var.transit_vnet_name
  address_space = [
    var.transit_vnet_cidr
  ]
  location            = var.region2
  resource_group_name = var.transit_rg_name
  depends_on = [
    azurerm_resource_group.transit_rg_name
  ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.transit_vnet_sub1_name
  resource_group_name  = var.transit_rg_name
  virtual_network_name = var.transit_vnet_name
  address_prefixes = [
    var.transit_vnet_sub1_cidr
  ]
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1
  ]
}

resource "azurerm_virtual_network_peering" "vnet_peering1a" {
  name                      = var.vnet_peering1a_name
  resource_group_name       = var.transit_rg_name
  virtual_network_name      = var.transit_vnet_name
  remote_virtual_network_id = var.network1_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_gateway_transit
  use_remote_gateways       = var.use_remote_gateways
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1
  ]
}


resource "azurerm_virtual_network_peering" "vnet_peering1b" {
  name                      = var.vnet_peering1b_name
  resource_group_name       = var.rg1_name
  virtual_network_name      = var.network1_name
  remote_virtual_network_id = var.transit_vnet_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_gateway_transit
  use_remote_gateways       = var.use_remote_gateways
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1
  ]
}


resource "azurerm_virtual_network_peering" "vnet_peering2a" {
  name                      = var.vnet_peering2a_name
  resource_group_name       = var.transit_rg_name
  virtual_network_name      = var.transit_vnet_name
  remote_virtual_network_id = var.network2_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_gateway_transit
  use_remote_gateways       = var.use_remote_gateways
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1
  ]
}


resource "azurerm_virtual_network_peering" "vnet_peering2b" {
  name                      = var.vnet_peering2b_name
  resource_group_name       = var.rg2_name
  virtual_network_name      = var.network2_name
  remote_virtual_network_id = var.transit_vnet_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_gateway_transit
  use_remote_gateways       = var.use_remote_gateways
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1
  ]
}



output "azu_base_transit_vnet_vnet1_id" {
  value = azurerm_virtual_network.transit_vnet1.id
}
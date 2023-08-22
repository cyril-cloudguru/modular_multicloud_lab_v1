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
  location = var.region
}

resource "azurerm_virtual_network" "transit_vnet1" {
  name = var.transit_vnet_name
  address_space = [
    var.transit_vnet_cidr
  ]
  location            = var.region
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
  allow_gateway_transit     = var.allow_gateway_transit_hub
  use_remote_gateways       = var.use_remote_gateways_hub
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
  allow_gateway_transit     = var.allow_gateway_transit_spoke
  use_remote_gateways       = var.use_remote_gateways_spoke
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1,
    azurerm_virtual_network_gateway.vnetgw1
  ]
}


resource "azurerm_virtual_network_peering" "vnet_peering2a" {
  name                      = var.vnet_peering2a_name
  resource_group_name       = var.transit_rg_name
  virtual_network_name      = var.transit_vnet_name
  remote_virtual_network_id = var.network2_id
  allow_forwarded_traffic   = var.allow_forwarded_traffic
  allow_gateway_transit     = var.allow_gateway_transit_hub
  use_remote_gateways       = var.use_remote_gateways_hub
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
  allow_gateway_transit     = var.allow_gateway_transit_spoke
  use_remote_gateways       = var.use_remote_gateways_spoke
  depends_on = [
    azurerm_resource_group.transit_rg_name,
    azurerm_virtual_network.transit_vnet1,
    azurerm_virtual_network_gateway.vnetgw1
  ]
}


resource "azurerm_subnet" "vnet_gateway1_sub" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.transit_rg_name
  virtual_network_name = azurerm_virtual_network.transit_vnet1.name
  address_prefixes     = [var.transit_vnet_gw_sub1_cidr]
}

resource "azurerm_public_ip" "vnet_gateway1_pip1" {
  name                = var.transit_vnet_gw1_pip
  location            = var.region
  resource_group_name = azurerm_resource_group.transit_rg_name.name
  allocation_method = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "vnetgw1" {
  name                = "test"
  location            = var.region
  resource_group_name = azurerm_resource_group.transit_rg_name.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = true
  sku           = "Standard"

  timeouts {
    create = "1h"
    delete = "1h"
  }

  bgp_settings {
    asn                = 65001
    peering_addresses {
      ip_configuration_name = "vnetGatewayConfig1"
    }

  }

  ip_configuration {
    name                          = "vnetGatewayConfig1"
    public_ip_address_id          = azurerm_public_ip.vnet_gateway1_pip1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vnet_gateway1_sub.id
  }
}


resource "azurerm_local_network_gateway" "local1" {
  name                = "local1gw"
  resource_group_name = azurerm_resource_group.transit_rg_name.name
  location            = var.region
  gateway_address     = var.transit_vnet_local1gw1_pip
  address_space       = var.transit_vnet_local1gw1_cidr
  depends_on = [
    var.depends_on_local1_pip1
  ]
}

resource "azurerm_virtual_network_gateway_connection" "local1" {
  name                = "local1gwconn1"
  location            = var.region
  resource_group_name = azurerm_resource_group.transit_rg_name.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vnetgw1.id
  local_network_gateway_id   = azurerm_local_network_gateway.local1.id

  shared_key = "4-v3ry-53cr37-1p53c-5h4r3d-k3y"
}

output "azu_base_transit_vnet_vnet1_id" {
  value = azurerm_virtual_network.transit_vnet1.id
}
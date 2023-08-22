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

resource "azurerm_resource_group" "rg1_name" {
  name     = var.rg1_name
  location = var.region1
}


resource "azurerm_virtual_wan" "vwan1" {
  name                = var.vwan1_name
  resource_group_name = var.rg1_name
  location            = var.region1
  depends_on = [ 
    azurerm_resource_group.rg1_name
     ]
}


resource "azurerm_virtual_hub" "vhub1" {
  name                = var.vhub1_name
  resource_group_name = var.rg1_name
  location            = var.region1
  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
  address_prefix      = var.vhub1_cidr
}


#resource "azurerm_virtual_hub" "vhub2" {
#  name                = var.vhub2_name
#  resource_group_name = var.rg1_name
#  location            = var.region
#  virtual_wan_id      = azurerm_virtual_wan.vwan1.id
#  address_prefix      = var.vhub1_cidr
#}

resource "azurerm_virtual_hub_connection" "vhubconn1" {
  name                      = "${var.region1}-vhubconn1"
  virtual_hub_id            = azurerm_virtual_hub.vhub1.id
  remote_virtual_network_id = var.remote_virtual_network1_id
}

#resource "azurerm_virtual_hub_connection" "vhubconn2" {
#  name                      = "${var.region1}-vhubconn2"
#  virtual_hub_id            = azurerm_virtual_hub.vhub1.id
#  remote_virtual_network_id = var.remote_virtual_network2_id
#}
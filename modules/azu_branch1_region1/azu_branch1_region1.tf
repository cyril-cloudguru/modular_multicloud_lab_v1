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

resource "azurerm_virtual_network" "vnet1" {
  name                = var.vnet1_name
  address_space       = [
    var.vnet1_cidr
  ]  
  location            = var.region1
  resource_group_name = var.rg1_name
  depends_on = [
    azurerm_resource_group.rg1_name
    ]
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.vnet1_sub1_name
  resource_group_name  = var.rg1_name
  virtual_network_name = var.vnet1_name
  address_prefixes     = [
    var.vnet1_sub1_cidr
    ]
  depends_on = [
    azurerm_resource_group.rg1_name,
    azurerm_virtual_network.vnet1
    ]
}


resource "azurerm_network_security_group" "nsg1" {
   name = var.nsg1_name
   resource_group_name = var.rg1_name
   location = var.region1
   depends_on = [
    azurerm_resource_group.rg1_name,
    ]
  
   security_rule {
       name = "ESP"
       priority = 100
       direction = "Inbound"
       access = "Allow"
       protocol = "Esp"
       source_port_range = "*"
       destination_port_range = "*"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "IKE"
       priority = 110
       direction = "Inbound"
       access = "Allow"
       protocol = "Udp"
       source_port_range = "*"
       destination_port_range = "500"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "ssh"
       priority = 200
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "22"
       source_address_prefix = "68.250.226.223/32"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "icmp"
       priority = 300
       direction = "Inbound"
       access = "Allow"
       protocol = "Icmp"
       source_port_range = "*"
       destination_port_range = "*"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "allout"
       priority = 100
       direction = "Outbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "*"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }
}


resource "azurerm_public_ip" "pip1" {
   name = var.pip1_name
   location = var.region1
   resource_group_name = var.rg1_name
   allocation_method = "Dynamic"
   depends_on = [
    azurerm_resource_group.rg1_name
    ]
}


resource "azurerm_network_interface" "nic1" {
   name = var.nic1_name
   location = var.region1
   resource_group_name = var.rg1_name

   ip_configuration {
       name = "internal"
       private_ip_address_allocation = "Static"
       private_ip_address = cidrhost (var.vnet1_sub1_cidr , 101)
       subnet_id = azurerm_subnet.subnet1.id
       public_ip_address_id = azurerm_public_ip.pip1.id
   }   
}


resource "azurerm_network_interface_security_group_association" "nic1_to_nsg1" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = azurerm_network_security_group.nsg1.id
  depends_on = [
    azurerm_resource_group.rg1_name,
    azurerm_network_interface.nic1,
    azurerm_network_security_group.nsg1
    ]
}

resource "azurerm_linux_virtual_machine" "vm1" {
   size = "Standard_B2s"
   name = var.vm1_name
   resource_group_name = var.rg1_name
   location = var.region1
   custom_data = base64encode(file("userdata_ubu_nginx.sh"))
   network_interface_ids = [
       azurerm_network_interface.nic1.id,
   ]

   source_image_reference {
       publisher = "sentriumsl"
       offer = "vyos-1-2-lts-on-azure"
       sku = "vyos-1-3"
       version = "latest"
   }

   plan {
        name      = "vyos-1-3"
        publisher = "sentriumsl"
        product   = "vyos-1-2-lts-on-azure"
    }

   computer_name = var.vm1_name
   admin_username = "adminuser"
   admin_password = "test123$"
   disable_password_authentication = false

   os_disk {
       name = "disk01"
       caching = "ReadWrite"
       storage_account_type = "Standard_LRS"
   }
}



# OUTPUT
output "azu_branch1_router1_pip1" {
  value = azurerm_public_ip.pip1.ip_address
}

output "azu_branch1_router1_vnet1_cidr" {
  value = var.vnet1_sub1_cidr
}


# output "azu_base_ubuntu_vnet1_id" {
#   value = azurerm_virtual_network.vnet1.id
# }

# output "azu_base_ubuntu_vnet1_name" {
#   value = azurerm_virtual_network.vnet1.name
# }



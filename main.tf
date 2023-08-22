



#module "aws_base_ubuntu" {
#  source = "./modules/aws_base_ubuntu"
#}

#module "aws_base_ms2022" {
#  source = "./modules/aws_base_ms2022" 
#}




module "azu_base_ubuntu_region1" {
  source           =   "./modules/azu_base_ubuntu_region1"
  region1          =   "${var.region1}" 
  rg1_name         =   "${var.base}-${var.cloud1}-${var.region1}-${var.app1}-rg"
  vnet1_name       =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-${var.app1}"
  vnet1_cidr       =   var.ubu_region1_vnet1_cidr
  vnet1_igw_name   =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-igw"
  vnet1_sub1_name  =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1"
  vnet1_sub1_cidr  =   var.ubu_region1_vnet1_sub1_cidr
  nsg1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-${var.app1}"
  pip1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app1}-pip1"
  nic1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app1}-nic1"
  vm1_name         =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app1}"
  userdata1        =   "file('userdata_ubu_nginx.sh')"
}


module "azu_base_ms2022_region1" {
  source = "./modules/azu_base_ms2022_region1"
  region1          =   "${var.region1}" 
  rg1_name         =   "${var.base}-${var.cloud1}-${var.region1}-${var.app2}-rg"
  vnet1_name       =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-${var.app2}"
  vnet1_cidr       =   "10.128.4.0/22"
  vnet1_igw_name   =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-igw"
  vnet1_sub1_name  =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1"
  vnet1_sub1_cidr  =   "10.128.4.0/24"
  nsg1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-${var.app2}"
  pip1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app2}-pip1"
  vm1_nic1_name    =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app2}-nic1"
  vm1_name         =   "${var.base}-vm1"
  userdata1        =   "file('userdata_ms2022_iis.psl')"
  sshkey1_name     =   "${var.base}-${var.cloud1}-${var.region1}-${var.app2}-sshkey1"
  vm1_nic1_privip  =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app2}-nic1-privip"
}

# module "azu_base_ubuntu_region2" {
#   source           =   "./modules/azu_base_ubuntu_region2"
#   region2          =   "${var.region2}" 
#   rg1_name         =   "${var.base}-${var.cloud1}-${var.region2}-${var.app1}-rg"
#   vnet1_name       =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-${var.app1}"
#   vnet1_cidr       =   "10.132.0.0/22"
#   vnet1_igw_name   =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-igw"
#   vnet1_sub1_name  =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1"
#   vnet1_sub1_cidr  =   "10.132.0.0/24"
#   nsg1_name        =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-${var.app1}"
#   pip1_name        =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app1}-pip1"
#   nic1_name        =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app1}-nic1"
#   vm1_name         =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app1}"
#   userdata1        =   "file('userdata_ubu_nginx.sh')"
# }


# module "azu_base_ms2022_region2" {
#   source = "./modules/azu_base_ms2022_region2"
#   region2          =   "${var.region2}" 
#   rg1_name         =   "${var.base}-${var.cloud1}-${var.region2}-${var.app2}-rg"
#   vnet1_name       =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-${var.app2}"
#   vnet1_cidr       =   "10.132.4.0/22"
#   vnet1_igw_name   =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-igw"
#   vnet1_sub1_name  =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1"
#   vnet1_sub1_cidr  =   "10.132.4.0/24"
#   nsg1_name        =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-${var.app2}"
#   pip1_name        =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app2}-pip1"
#   vm1_nic1_name    =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app2}-nic1"
#   vm1_name         =   "${var.base}-vm1"
#   userdata1        =   "file('userdata_ms2022_iis.psl')"
#   sshkey1_name     =   "${var.base}-${var.cloud1}-${var.region2}-${var.app2}-sshkey1"
#   vm1_nic1_privip  =   "${var.base}-${var.cloud1}-${var.region2}-vnet1-sub1-vm1-${var.app2}-nic1-privip"
# }

module "azu_branch1_region1" {
  source           =   "./modules/azu_branch1_region1"
  region1          =   "${var.region1}" 
  rg1_name         =   "${var.base}-${var.cloud1}-${var.region1}-${var.app4}-rg"
  vnet1_name       =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-${var.app4}"
  vnet1_cidr       =   var.azu_region1_branch1_vnet1_cidr
  vnet1_igw_name   =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-igw"
  vnet1_sub1_name  =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1"
  vnet1_sub1_cidr  =   var.azu_region1_branch1_vnet1_sub1_cidr
  nsg1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-${var.app4}"
  pip1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app4}-pip1"
  nic1_name        =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app4}-nic1"
  vm1_name         =   "${var.base}-${var.cloud1}-${var.region1}-vnet1-sub1-vm1-${var.app4}"
  userdata1        =   "file('userdata_ubu_nginx.sh')"
}


#module "gcp_base_ubuntu" {
#  source = "./modules/gcp_base_ubuntu"
#}


#module "gcp_base_ms2022" {
#  source = "./modules/gcp_base_ms2022"
#}

module "azu_base_transit_vnet_region1" {
  source  = "./modules/azu_base_transit_vnet_region1"
  region = "${var.region1}"
  transit_rg_name             = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-rg"
  transit_vnet_name           = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-txvnet1"
  transit_vnet_id             = module.azu_base_transit_vnet_region1.azu_base_transit_vnet_vnet1_id
  transit_vnet_sub1_name      = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-vnet1-sub1"
  transit_vnet_cidr           = "10.128.8.0/22"  
  transit_vnet_sub1_cidr      = "10.128.8.0/24"
  transit_vnet_gw_sub1_name   = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-vnet1-gwsub1"
  transit_vnet_gw_sub1_cidr   = var.transit_vnet_gw_sub1_cidr
  transit_vnet_gw1_pip        = "${var.base}-${var.cloud1}-${var.region1}-${var.app3}-pip1"
  transit_vnet_local1gw1_pip  = module.azu_branch1_region1.azu_branch1_router1_pip1
  transit_vnet_local1gw1_cidr = var.azu_region1_transit_local1gw_cidr
  depends_on_local1_pip1      = module.azu_branch1_region1.azu_branch1_router1_pip1
  rg1_name                    = "${var.base}-${var.cloud1}-${var.region1}-${var.app1}-rg"
  rg2_name                    = "${var.base}-${var.cloud1}-${var.region1}-${var.app2}-rg"
  vnet_peering1a_name         = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-peer1a"
  vnet_peering1b_name         = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-peer1b"
  vnet_peering2a_name         = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-peer2a"
  vnet_peering2b_name         = "${var.base}-${var.cloud1}-${var.app3}-${var.region1}-peer2b"
  network1_id                 = module.azu_base_ubuntu_region1.azu_base_ubuntu_vnet1_id
  network2_id                 = module.azu_base_ms2022_region1.azu_base_ms2022_vnet1_id
  network1_name               = module.azu_base_ubuntu_region1.azu_base_ubuntu_vnet1_name
  network2_name               = module.azu_base_ms2022_region1.azu_base_ms2022_vnet1_name
  allow_forwarded_traffic     = true
  allow_gateway_transit_hub   = true
  use_remote_gateways_hub     = false
  allow_gateway_transit_spoke = false
  use_remote_gateways_spoke   = true
}



# module "azu_base_transit_vnet_region2" {
#   source  = "./modules/azu_base_transit_vnet_region2"
#   region2 = "${var.region2}"
#   transit_rg_name         = "${var.base}-${var.cloud1}-${var.app3}${var.region2}-rg"
#   transit_vnet_name       = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-txvnet1"
#   transit_vnet_id         = module.azu_base_transit_vnet_region2.azu_base_transit_vnet_vnet1_id
#   transit_vnet_sub1_name  = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-vnet1-sub1"
#   transit_vnet_cidr       = "10.132.8.0/22"  
#   transit_vnet_sub1_cidr  = "10.132.8.0/24"
#   rg1_name                = "${var.base}-${var.cloud1}-${var.region2}-${var.app1}-rg"
#   rg2_name                = "${var.base}-${var.cloud1}-${var.region2}-${var.app2}-rg"
#   vnet_peering1a_name      = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-peer1a"
#   vnet_peering1b_name      = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-peer1b"
#   vnet_peering2a_name      = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-peer2a"
#   vnet_peering2b_name      = "${var.base}-${var.cloud1}-${var.app3}-${var.region2}-peer2b"
#   network1_id             = module.azu_base_ubuntu_region2.azu_base_ubuntu_vnet1_id
#   network2_id             = module.azu_base_ms2022_region2.azu_base_ms2022_vnet1_id
#   network1_name           = module.azu_base_ubuntu_region2.azu_base_ubuntu_vnet1_name
#   network2_name           = module.azu_base_ms2022_region1.azu_base_ms2022_vnet1_name
#   allow_forwarded_traffic = true
#   allow_gateway_transit   = false
#   use_remote_gateways     = false 
# }




# module "azu_vwan_2vhub" {
#   source = "./modules/azu_vwan_2vhub"
#   remote_virtual_network1_id = module.azu_base_ubuntu.azu_vnet1_id
#  remote_virtual_network2_id = module.azu_base_ms2022.azu_base_ms2022_vnet_id
#}





# OUTPUT
#  output "aws_instance1_ms2022_public_dns" {
#    value = module.aws_base_ms2022.aws_instance_public_dns
#  }    


# OUTPUT
# output "aws_instance1_ubuntu_public_dns" {
#   value = module.aws_base_ubuntu.aws_instance_public_dns
# }

# OUTPUT
# output "azu_base_ubuntu_region1_pip1" {
#   value = module.azu_base_ubuntu.azurerm_public_ip.pip1.ip_address
# }

# OUTPUT
# output "azu_base_ms2022_region1_pip1" {
#   value = module.azu_base_ms2022.azu_base_ms2022_pip1
# }

# OUTPUT
# output "azu_vnet1_id" {
#   value = module.azu_base_ubuntu.azu_vnet1_id
# }
# output "azu_vnet2_id" {
#   value = module.azu_base_ms2022.azu_base_ms2022_vnet_id
# }

# OUTPUT





#output "gcp_base_ubuntu_pip1" {
#  value = module.gcp_base_ubuntu.azurerm_public_ip.pip1.ip_address
#}


variable "rg1_name" {
  type    = string
}

variable "region1" {
  type    = string
}


variable "vnet1_name" {
  type    = string
}

variable "vnet1_cidr" {
  type    = string
}

variable "vnet1_igw_name" {
  type    = string
}

variable "vnet1_sub1_name" {
  type    = string
}

variable "vnet1_sub1_cidr" {
  type    = string
}

variable "nsg1_name" {
    type = string
}

variable "pip1_name" {
  type    = string
}

variable "nic1_name" {
  type    = string
}

variable "userdata1" {
#  default = "file('userdata_ubu_nginx.sh')"
}

variable "vm1_name" {
  type    = string
}











variable "sshkey1_name" {
  type    = string
  default = "aws_base_ubuntu_keypair"
}


variable "key_pair1_file_name" {
  type    = string
  default = "aws_base_ubuntu_key-pair1.pem"
}






variable "vnet1_vm1_nic1_name" {
  type    = string
  default = "azu-uswe1-ubuntu-vnet1-vm1-nic1"
}

variable "vnet1_vm1_nic1_privip" {
  type    = string
  default = "10.128.0.101"
}



variable "test" {
  type=string
  default = "test"
}

#variable "testing" {
#  type=string
#  default = format(var.test,"ing")
#}
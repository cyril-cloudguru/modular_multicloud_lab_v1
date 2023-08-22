
variable "rg1_name" {
  type    = string
  default = "azu-vwan_2vhub-rg1"
}

variable "region1" {
  type    = string
  default = "westus"
}


variable "region2" {
  type    = string
  default = "eastus"
}


variable "vwan1_name" {
  type    = string
  default = "azu-vwan1"
}

variable "vhub1_name" {
  type    = string
  default = "azu-vhub1-uswe1"
}

variable "vhub1_cidr" {
  type    = string
  default = "10.240.0.0/24"
}

variable "vhub2_name" {
  type    = string
  default = "azu-uswe1-vhub1"
}

variable "vhub2_cidr" {
  type    = string
  default = "10.241.0.0/24"
}


variable "remote_virtual_network1_id" {
}

#variable "remote_virtual_network2_id" {
#}

variable "vhubconn1_name" {
  type    = string
  default = "azu-vhub1-uswe1-vnet1"
}

variable "vhubconn2_name" {
  type    = string
  default = "azu-vhub1-uswe1-vnet2"
}







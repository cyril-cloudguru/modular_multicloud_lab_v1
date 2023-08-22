variable "region1" {
  type    = string
  default = "westus"
}

variable "region2" {
  type    = string
  default = "eastus"
}

variable "base" {
  type    = string
  default = "demo"
}

variable "app1" {
  type    = string
  default = "ubu-ngnx"
}

variable "app2" {
  type    = string
  default = "ms2022-iis"
}

variable "app3" {
  type    = string
  default = "transit_vnet"
}

variable "app4" {
  type    = string
  default = "branch1"
}

variable "cloud1" {
  type    = string
  default = "azu"
}

variable "cloud2" {
  type    = string
  default = "aws"
}


variable "ubu_region1_vnet1_cidr" {
  type    = string
  default = "10.128.0.0/22"
}

variable "ubu_region1_vnet1_sub1_cidr" {
  type    = string
  default = "10.128.0.0/24"
}

variable "transit_vnet_gw_sub1_cidr" {
  type = string
  default = "10.128.11.0/24"
}

variable "azu_region1_branch1_vnet1_cidr" {
  type    = string
  default = "10.2.0.0/22"
}

variable "azu_region1_branch1_vnet1_sub1_cidr" {
  type    = string
  default = "10.2.0.0/24"
}

variable "azu_region1_transit_local1gw_cidr" {
  type    = list
  default = ["10.2.0.0/24"]
}


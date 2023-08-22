variable "project1_name" {
  type    = string
  default = "gcp-base-ununtu"
}


variable "region1" {
  type    = string
  default = "us-west1"
}

variable "vpc1_name" {
  type    = string
  default = "gcp-base-ubuntu-vpc1"
}

variable "subnet1_name" {
  type    = string
  default = "gcp-base-ubuntu-vpc1-sub1"
}

variable "cidr1" {
  type    = string
  default = "10.192.0.0/24"
}

variable "privip1" {
  type    = string
  default = "10.192.0.101/24"
}

variable "vm1_name" {
  type    = string
  default = "gcp-base-ubuntu-vpc1-sub1-vm1"
}
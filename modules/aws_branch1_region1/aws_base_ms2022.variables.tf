variable "region" {
  type    = string
  default = "us-west-1"
}


variable "vpc1-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1"
}

variable "vpc1-cidr" {
  type    = string
  default = "10.128.4.0/22"
}

variable "vpc1-igw-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1-igw"
}

variable "vpc1-sub1-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1-sub1"
}

variable "vpc1-sub1-cidr" {
  type    = string
  default = "10.128.4.0/24"
}

variable "sshkey1-name" {
  type    = string
  default = "pubkey1"
}

variable "vpc1-vm1-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1-vm1"
}


variable "vpc1-vm1-ami" {
  type    = string
  default = "ami-087ae4671c2788b6c"
}

variable "vpc1-vm1-userdata" {
  default = "file('userdata_ubu_nginx.tpl')"

}


variable "vpc1-vm1-nic1-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1-vm1-nic1"
}

variable "vpc1-vm1-nic1-privip" {
  type    = string
  default = "10.128.4.101"
}

variable "vpc1-vm1-nic1-eip1-name" {
  type    = string
  default = "cg-uswe1-ms2022-vpc1-vm1-nic1-eip1"
}


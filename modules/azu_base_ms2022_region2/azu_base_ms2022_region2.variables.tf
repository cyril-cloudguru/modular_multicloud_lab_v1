
variable "rg1_name" {
  type    = string
}

variable "region2" {
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

variable "vnet1_sub1_cidr" {
  type    = string
}

variable "vnet1_sub1_name" {
  type    = string
}

variable "nsg1_name" {
    type = string
}

variable "pip1_name" {
  type    = string
}

variable "userdata1" {
}

variable "vm1_name" {
  type    = string
}








variable "sshkey1_name" {
  type    = string
}


variable "key_pair1_file_name" {
  type    = string
  default = "aws-base-ms2022-key-pair1.pem"
}






variable "vm1_nic1_name" {
  type    = string
}

variable "vm1_nic1_privip" {
  type    = string
}




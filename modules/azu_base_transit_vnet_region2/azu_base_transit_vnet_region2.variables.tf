variable "transit_rg_name" {
  description = "The name of the resource group for the virtual network peering."
  type        = string
}

variable "rg1_name" {
  description = "The name of the resource group for the virtual network peering."
  type        = string
}

variable "rg2_name" {
  description = "The name of the resource group for the virtual network peering."
  type        = string
}


variable "region2" {
  type = string
}


variable "transit_vnet_name" {
  type = string
}

variable "transit_vnet_id" {
  type = string
}

variable "transit_vnet_cidr" {
  type = string
}


variable "transit_vnet_sub1_cidr" {
  type = string
}

variable "transit_vnet_sub1_name" {
  type = string
}


variable "vnet_peering1a_name" {
  description = "The name of the virtual network peering."
  type        = string
}

variable "vnet_peering1b_name" {
  description = "The name of the virtual network peering."
  type        = string
}

variable "vnet_peering2a_name" {
  description = "The name of the virtual network peering."
  type        = string
}

variable "vnet_peering2b_name" {
  description = "The name of the virtual network peering."
  type        = string
}

variable "network1_id" {
  description = "The ID of the first virtual network."
  type        = string
}

variable "network1_name" {
  description = "The ID of the first virtual network."
  type        = string
}

variable "network2_id" {
  description = "The ID of the second virtual network."
  type        = string
}

variable "network2_name" {
  description = "The ID of the first virtual network."
  type        = string
}

variable "allow_forwarded_traffic" {
  description = "Whether to allow forwarded traffic."
  type        = bool
}
variable "allow_gateway_transit" {
  description = "Whether to allow gateway transit."
  type        = bool
}
variable "use_remote_gateways" {
  description = "Whether to use remote gateways."
  type        = bool
}





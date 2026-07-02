variable "vnetname" {

  description = "Virtual Network Name"

  type = string

}

variable "location" {

  description = "Azure Location"

  type = string

}

variable "rgname" {

  description = "Resource Group Name"

  type = string

}

variable "address_space" {

  description = "Address Space"

  type = list(string)

}

variable "dns_servers" {

  description = "Custom DNS"

  type = list(string)

  default = []

}

variable "tags" {

  type = map(string)

  default = {}

}
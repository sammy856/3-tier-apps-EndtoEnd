variable "nic_name" {

  type = string

}

variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "subnet_id" {

  type = string

}

variable "ip_configuration_name" {

  type = string

}

variable "private_ip_allocation" {

  type = string

  default = "Dynamic"

}

variable "private_ip" {

  type = string

  default = null

}

variable "public_ip_id" {

  type = string

  default = null

}

variable "tags" {

  type = map(string)

  default = {}

}
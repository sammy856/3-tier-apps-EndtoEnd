

variable "location" {

  type = string

}

variable "resource_group_name" {

  type = string

}

variable "subnet_id" {

  type = string

}


variable "lvm_name" {

  type = string

}

variable "vm_size" {

  type = string

}

variable "admin_username" {

  type = string

}

variable "admin_password" {

  type = string

}

variable "user_assigned_identity_ids" {
  type    = list(string)
  default = []
}

variable "ssh_public_key" {
  type    = string
  default = ""
}

variable "create_public_ip" {
  type    = bool
  default = false
}


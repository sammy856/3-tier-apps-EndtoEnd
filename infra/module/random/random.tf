resource "random_password" "sqladminpassword" {
  length           = 16
  special          = true
  override_special = "!@#$%&*()-_=+[]{}<>:?"
}

variable "sql_admin_password_length" {
  type        = number
  description = "Length of SQL admin password"
  default     = 16
}

variable "sql_admin_password_special" {
  type        = bool
  description = "Whether to include special characters"
  default     = true
}

variable "sql_admin_password_override_special" {
  type        = string
  description = "Allowed special characters"
  default     = "!@#$%&*()-_=+[]{}<>:?"
}
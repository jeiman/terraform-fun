### VARIABLES

variable "env_name" {
  description = "Name of Environment"
  default     = "tf-demo"
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "vm_admin_username" {
  description = "Username for the Administrator account"
  default     = "fancyname"
}

variable "vm_admin_password" {
  description = "Password for the Administrator account"
}

variable "vsts_account" {}

variable "vsts_access_token" {}

variable "vstsagent_username" {
  default = "vstsdeployer"
}

variable "vstsagent_password" {}

# EOF #


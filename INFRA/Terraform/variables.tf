variable "resource_group_location" {
  type        = string
  default     = "southafricanorth"
  description = "Location of the resource group."
}

variable "servers" {
  type = set(string)
  default = [
    "jenkins",
    "nexus"
  ]
}

variable "dest_port" {
  type = map
  default = {
    "jenkins" = "8080"
    "nexus" = "8081"
  }
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "region" {
  type    = string
  default = "North Europe"
}

variable "file_path" {
  type    = string
  default = "./sample.txt"
}

//you need to export as a global env variable
//export TF_VAR_subscription_id="your_data"
variable "subscription_id" {}
variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}

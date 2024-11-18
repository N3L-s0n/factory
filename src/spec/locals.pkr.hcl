variable "client_id" {
    type = string
    sensitive = true
}

variable "client_secret" {
    type = string
    sensitive = true
}

variable "registry_name" {
    type = string
    default = "containers-on-ubuntu"
}

locals {
    provider = "virtualbox"
    architecture =  "amd64"
    version = "0.0.1"
}

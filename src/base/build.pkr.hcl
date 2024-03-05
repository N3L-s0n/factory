variable "password" {
    type = string
    sensitive = true
} 

build {
    sources = ["sources.virtualbox-iso.ubuntu-12", "sources.virtualbox-iso.ubuntu-18"]
}

variable "username" {
    type = string
    default = "vagrant"
}

variable "password" {
    type = string
    default = "vagrant"
    sensitive = true
} 

build {
    sources = ["sources.virtualbox-iso.ubuntu-12", "sources.virtualbox-iso.ubuntu-18"]

    provisioner "ansible" {
        playbook_file = "${path.root}/../scripts/ansible/vagrant.yml"
        extra_arguments = [ "--extra-vars", "ansible_user=${var.username} ansible_password=${var.password}" ]
        use_proxy = false
    }

    post-processors {
        post-processor "vagrant" {
            keep_input_artifact = false   
            provider_override   = "virtualbox"
            output              = "{{ .BuildName }}-{{ .Provider }}.box"
        }
    }
}

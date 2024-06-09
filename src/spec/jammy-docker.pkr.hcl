variable "cloud_token" {
    type = string
    sensitive = true
}

locals {
    provider = "virtualbox"
    architecture =  "amd64"
    version = "0.0.2"
}

source "vagrant" "ubuntu-jammy64-docker" {
    communicator = "ssh"
    source_path  = "ubuntu/jammy64"
    provider     = "${local.provider}"
    output_dir   = "./ubuntu-jammy64-docker-output"
}

build {
    sources = ["source.vagrant.ubuntu-jammy64-docker"]

    provisioner "shell" {
        inline = [
            "sudo apt-add-repository ppa:ansible/ansible",
            "sudo apt update",
            "sudo apt install -y ansible"
        ]
    }

    provisioner "ansible-local" {
        playbook_file = "../scripts/ansible/docker.yml"
    }

    post-processor "shell-local" {
        environment_vars = [
            "BUILD_NAME=${source.name}",
            "CLOUD_TOKEN=${var.cloud_token}"
        ]
        scripts = [
            "./create-box.sh"
        ] 
    }

    post-processor "vagrant-cloud" {
        access_token = "${var.cloud_token}"
        box_tag = "bynelson/${ source.name }"
        version = "${local.version}"
        architecture = "${local.architecture}"
        keep_input_artifact = false   
    }
}

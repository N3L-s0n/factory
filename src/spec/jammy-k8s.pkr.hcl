# Builds an ubuntu jammy machine with docker and kubernets on top

locals {
    ubuntu-jammy64-k8s-dir = "./ubuntu-jammy64-k8s-output"
}

source "vagrant" "ubuntu-jammy64-k8s" {
    communicator = "ssh"
    source_path  = "ubuntu/jammy64"
    provider     = "${local.provider}"
    output_dir   = "${local.ubuntu-jammy64-k8s-dir}"
    skip_add     = true
}

build {
    sources = ["source.vagrant.ubuntu-jammy64-k8s"]

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

    provisioner "ansible-local" {
        playbook_file = "../scripts/ansible/kubernetes.yml"
    }

    post-processor "vagrant-registry" {
        client_id = "${ var.client_id }"
        client_secret = "${ var.client_secret }"
        box_tag = "${ var.registry_name }/${ source.name }"
        version = "${ local.version }"
        architecture = "${ local.architecture }"
        keep_input_artifact = false   
    }

    # Cleanup
    post-processor "shell-local" {
        inline = ["rm -rf ${local.ubuntu-jammy64-k8s-dir}"]
    }
}

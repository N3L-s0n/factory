source "vagrant" "base" {
    communicator = "ssh"
    source_path  = "ubuntu/jammy64"
    provider     = "virtualbox"
}

build {
    sources = ["source.vagrant.base"]

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
}

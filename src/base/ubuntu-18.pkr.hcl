source "virtualbox-iso" "ubuntu-18" {

    guest_os_type = "Ubuntu_64"
    iso_url = "http://cdimage.ubuntu.com/ubuntu/releases/18.04/release/ubuntu-18.04.6-server-amd64.iso"

    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/ubuntu-12/preseed.pkrtpl.hcl", { 
                password = var.password,
                username = var.username
            }
        )
    }

    boot_command = [
        "<esc><wait>",
        "<esc><wait>",
        "<enter><wait>",
        "/install/vmlinuz<wait>",
        " initrd=/install/initrd.gz",
        " auto-install/enable=true",
        " debconf/priority=critical",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<wait>",
        " -- <wait>",
        "<enter><wait>"
    ]

    iso_checksum = "sha256:f5cbb8104348f0097a8e513b10173a07dbc6684595e331cb06f93f385d0aecf6"

    ssh_username = "${var.username}"
    ssh_password = "${var.password}"
    ssh_timeout = "60m"

    shutdown_command = "echo '${var.password}' | sudo -S shutdown -P now"

    vboxmanage = [
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
    ]
}

variable "password" {
    type = string
    sensitive = true
} 

source "virtualbox-iso" "ubuntu-12" {

    guest_os_type = "Ubuntu_64"
    iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"

    http_content = {
        "/preseed_2.cfg" = templatefile("${path.root}/ubuntu-12/preseed.pkrtpl.hcl", 
            { password = var.password}
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
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed_2.cfg<wait>",
        " -- <wait>",
        "<enter><wait>"
    ]

    iso_checksum = "md5:769474248a3897f4865817446f9a4a53"

    ssh_username = "packer"
    ssh_password = "${var.password}"
    ssh_timeout = "60m"

    shutdown_command = "echo '${var.password}' | sudo -S shutdown -P now"

    vboxmanage = [
        ["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"],
    ]
}
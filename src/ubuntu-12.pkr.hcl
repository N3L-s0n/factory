source "virtualbox-iso" "ubuntu-12" {

    guest_os_type = "Ubuntu_64"
    iso_url = "http://releases.ubuntu.com/12.04/ubuntu-12.04.5-server-amd64.iso"

    http_content = {
        "/preseed.cfg" = templatefile("${path.root}/ubuntu-12/preseed.pkrtpl.hcl", {})
    }

    boot_command = [
        "<esc><esc><enter><wait>",
        "/install/vmlinuz noapic ",
        "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
        "initrd=/install/initrd.gz -- <enter>"
    ]

    iso_checksum = "md5:769474248a3897f4865817446f9a4a53"
    ssh_username = "packer"    
    ssh_password = "packer"
    ssh_timeout = "10m"

    shutdown_command = "sudo -S shutdown -P now"
}
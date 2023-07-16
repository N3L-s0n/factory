# LOCALIZATION
# Set installer's locale
d-i debian-installer/locale string en_US.UTF-8

# KEYBOARD
# Set keyboard to US
d-i console-setup/ask_detect boolean false
d-i console-setup/layoutcode string us
d-i keyboard-configuration/xkb-keymap select us

# NETWORK
d-i netcfg/choose_interface select auto
d-i netcfg/link_wait_timeout string 10
d-i netcfg/dhcp_timeout string 10
d-i netcfg/dhcpv6_timeout string 1

# Set default names
d-i netcfg/get_hostname string packer-host
d-i netcfg/get_domain string packer-domain

d-i netcfg/wireless_wep string

# Mirror
d-i mirror/http/mirror select CC.archive.ubuntu.com

# Suite to install.
d-i mirror/suite string squeeze

# Clock and time zone
d-i clock-setup/utc boolean false
d-i time/zone  string US/Eastern

# NTP do not use
d-i clock/setup/ntp boolean false

# Partition
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string lvm
d-i partman-auto/choose_recipe select atomic

d-i partman-lvm/device_remove_lvm boolean true
d-i partman-md/device_remove_md boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true

d-i partman-md/confirm boolean true
d-i partman/default_filesystem string ext4

d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

# Installation
d-i base-installer/install-recommends boolean false
d-i base-installer/kernel/image string linux-generic

# Configure root
d-i passwd/root-login boolean true
d-i passwd/root-password password packer
d-i passwd/root-password-again password packer

# Set user password
d-i passwd/user-fullname string packer
d-i passwd/username string packer

d-i user-setup/allow-password-weak boolean true
d-i passwd/user-password password packer
d-i passwd/user-password-again password packer
d-i passwd/user-default-groups string audio cdrom video admin sudo

# Apps
d-i apt-setup/restricted boolean true
d-i apt-setup/universe boolean true

### Package selection
tasksel tasksel/first multiselect standard

# Policy for applying updates
d-i pkgsel/update-policy select unattended-upgrades

# Add SSH
d-i pkgsel/include string openssh-server

# Reboot after finishing the installation
d-i finish-install/reboot_in_progress note
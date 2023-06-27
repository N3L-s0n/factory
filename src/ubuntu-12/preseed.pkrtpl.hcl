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
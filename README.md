# Factory
This repository hosts golden images for VMware's Workstation and Oracle's Virtualbox

# Images
List of images configured

## Oracle Virtualbox 
- Ubuntu Server 12

# Build
To execute the builds then Packer must be installed
Move to the src directory and execute the build passing a password variable to configure your images

```sh
cd src
packer build -var 'password=${your_password} .
```

# Authors
- Nelson Alvarez
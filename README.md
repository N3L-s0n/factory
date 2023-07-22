# Factory
This repository hosts golden images for VMware's Workstation and Oracle's Virtualbox

# Images
List of images configured

## Oracle Virtualbox 
- Ubuntu Server 12: `virtualbox-iso.ubuntu-12`
- Ubuntu Server 18: `virtualbox-iso.ubuntu-18`

# Build
To execute the builds then Packer must be installed.
Move to the src directory and execute the build passing a password variable to configure your images.

> Note: Change the value of `${variable}` with your own values.

**Running all builds**
```sh
cd src
packer build -var 'password=${your_password}' .
```

**Running one build**
```sh
cd src
packer build -only='${source-name}' -var 'password=${your_password}' .
```

> Note: An example of a valid `source-name` is `virtualbox-iso.ubuntu-18`.

After the build is executed an output folder will be created with your image files to import on the hypervisor and create your virtual machine.

# Authors
- Nelson Alvarez

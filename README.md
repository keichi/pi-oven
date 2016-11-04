# pi-oven

[![Code Climate](https://codeclimate.com/github/keichi/pi-oven/badges/gpa.svg)](https://codeclimate.com/github/keichi/pi-oven)

Automated provisioning of RaspberryPi disk images

## Prerequisites

- CentOS 7 or Fedora 24+ (might work on other Linux distros as well)
- Statically linked QEMU user mode emulator for ARM binaries

## Installation

### Install pi-oven

```
$ curl -O https://raw.githubusercontent.com/keichi/pi-oven/master/oven
$ sudo install oven /usr/bin
```

### Install QEMU

Please note that pi-oven requires a statically linked QEMU with user mode
emulation for ARM binaries. If it's available from your package manager:

```
$ dnf install qemu-user-static
```

Alternatively, you can download it from this repository.

```
$ curl -O https://raw.githubusercontent.com/keichi/pi-oven/master/oven
$ sudo install qemu-arm-static /usr/bin
```

## Usage

Oven is an automation tool for modifying existing RaspberryPi disk images to
match your needs.

```
$ sudo oven [options] src [dst]
```

If `dst` is specified, `src` will not be overwritten and the new disk image
will be written to `dst`. Note that pi-oven requires root privilege because it
uses loop mounting and chroot internally.

Available options:

- -r, --resize [size in MB]: Resize base image before provisioning
- -s, --script [path to shell script]: Shell script for provisioning
- -i, --interactive: Interactive mode
- --partnum [1-4]: Partition number of the root partition
- --qemu [path to qemu]: Path to qemu-arm-static
- --version: Print version information
- -h, --help: Show usage

### Examples

Use `./raspbian-jessie-lite.img` as base image. Resize image to 2000MB and
provision image by running `./foo.sh`. Save resulting image to `./foo.img`.

```
$ sudo oven -r 2000 -s ./foo.sh ./raspbian-jessie-lite.img ./foo.img
```

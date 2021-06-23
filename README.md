# pi-oven

[![Code Climate](https://codeclimate.com/github/keichi/pi-oven/badges/gpa.svg)](https://codeclimate.com/github/keichi/pi-oven)

Customize RaspberryPi disk images on x86_64

## Prerequisites

- Ubuntu 20.04
- Statically linked QEMU user mode emulator for armhf/aarch64
- Binfmt configuration for armhf/aarch64
- parted and kpartx

## Installation

### Install dependencies

```
$ sudo apt install -y qemu-user-static binfmt-support parted kpartx
```

### Install pi-oven

```
$ curl -O https://raw.githubusercontent.com/keichi/pi-oven/master/oven
$ sudo install oven /usr/bin
```

## Usage

_Oven_ is a simple yet flexible tool for customizing RaspberryPi disk images to
match your needs.

```
$ sudo oven [options] src [dst]
```

By default, oven modifies and overwrites the disk image at `src`. If `dst` is
specified, `src` is first copied to `dst` and then modified. Note that oven
requires root privilege because it internally uses loop mounts and chroot.

Available options are:

- `-r`, `--resize SIZE`: Resize the root file system before provisioning
- `-s`, `--script PATH`: Path to a shell script for customization
- `-i`, `--interactive`: Start an interactive shell for customization
- `--bootpart [1-4]`: Partition number of the boot partition (default=1)
- `--rootpart [1-4]`: Partition number of the root partition (default=2)
- `-v`, `--version`: Print version information
- `-h`, `--help`: Show usage

### Examples

The following command will:

1. Use `./raspbian-jessie-lite.img` as a base image.
2. Resize the image to 2000 MB.
3. Customize the image by running `./foo.sh`.
4. Save the resulting image to `./foo.img`.

```
$ sudo oven -r 2000 -s ./foo.sh ./raspbian-jessie-lite.img ./foo.img
```

## Troubleshooting

- If DNS resolution fails, check if `/etc/resolv.conf` exists within the disk
  image and contains a valid configuration.
  ```
  nameserver 8.8.8.8
  ```
- If kernel update fails on a Ubuntu image with the following error:
  ```
  Failed to create symlink to vmlinuz-5.4.0-1038-raspi: Operation not permitted at /usr/bin/linux-update-symlinks line 64.
  ```
  It's likely because of [this](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1318951) bug in Ubuntu. Adding the following lines to `/etc/kernel-img.conf` should fix the issue.
  ```
  do_symlinks = No
  no_symlinks = Yes
  ```
- If you encounter the error "no space left on device" when installing
  packages, resize the disk image using the `-r` option.

#!/usr/bin/env bash
#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

set -e
[ $# -eq 6 ] || {
    echo "SYNTAX: $0 <file> <u-boot image> <bootfs image> <rootfs image> <bootfs size> <rootfs size>"
    exit 1
}

OUTPUT="$1"
UBOOT="$2"
BOOTFS="$3"
ROOTFS="$4"
BOOTFSSIZE="$5"
ROOTFSSIZE="$6"

head=255
sect=63

#echo 0 > /sys/block/mmcblk0boot0/force_ro
#dd of=/dev/mmcblk0boot0 bs=1  seek=0 if=/tmp/bpi-r2-preloader-mmc.bin
#dd of=/dev/mmcblk0boot0 bs=1k  seek=320 if=/tmp/7623n-bananapi-bpi-r2-uboot-mediatek.bin
#zcat /tmp/openwrt-mediatek-mt7623-7623n-bananapi-bpi-r2-ext4-mmc.img.gz | dd of=/dev/mmcblk0 bs=512 conv=notrunc
#sync
[ -e "${OUTPUT}" ] && rm "${OUTPUT}"

set `ptgen -o $OUTPUT -h $head -s $sect -l 1024 -t c -p ${BOOTFSSIZE}M -t 83 -p ${ROOTFSSIZE}M -a 0`

BOOT_OFFSET="$(($1 / 512))"
BOOT_SIZE="$(($2 / 512))"
ROOTFS_OFFSET="$(($3 / 512))"
ROOTFS_SIZE="$(($4 / 512))"

UBOOT_OFFSET=320       # 320KB

echo dd bs=1024 if="${UBOOT}"     of="${OUTPUT}" seek="${UBOOT_OFFSET}"     conv=notrunc
dd bs=1024 if="${UBOOT}"     of="${OUTPUT}" seek="${UBOOT_OFFSET}"     conv=notrunc
echo dd bs=512  if="${BOOTFS}"    of="${OUTPUT}" seek="${BOOT_OFFSET}"      conv=notrunc
dd bs=512  if="${BOOTFS}"    of="${OUTPUT}" seek="${BOOT_OFFSET}"      conv=notrunc
echo dd bs=512  if="${ROOTFS}"    of="${OUTPUT}" seek="${ROOTFS_OFFSET}"    conv=notrunc
dd bs=512  if="${ROOTFS}"    of="${OUTPUT}" seek="${ROOTFS_OFFSET}"    conv=notrunc

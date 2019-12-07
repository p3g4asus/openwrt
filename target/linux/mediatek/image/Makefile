#
# Copyright (C) 2012-2015 OpenWrt.org
# Copyright (C) 2016-2017 LEDE project
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_MEDIATEK_SD_BOOT_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

# for arm
KERNEL_LOADADDR := 0x80008000

define Build/mediatek-sdcard
        rm -f $@.boot
        mkfs.fat $@.boot -C $(FAT32_BLOCKS)
        mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uEnv.txt ::uEnv.txt
        mcopy -i $@.boot $(IMAGE_KERNEL) ::uImage
        rm -f /tmp/img_sdcard.img
        mkdir -p /tmp/img_sdcard_d
        dd if=/dev/zero of=/tmp/img_sdcard.img bs=1M count=$(CONFIG_MEDIATEK_MMC_ROOT_PARTSIZE)
        mkfs.ext4 /tmp/img_sdcard.img
        sudo mount -o loop,rw,sync /tmp/img_sdcard.img /tmp/img_sdcard_d
        sudo cp -Rfv --preserve=mode,timestamps,links "$(BUILD_DIR)/root-mediatek/." /tmp/img_sdcard_d/
        sudo umount /tmp/img_sdcard_d
        ./gen_mediatek_sdcard_img.sh $@ \
                $(STAGING_DIR_IMAGE)/bpi-r2-preloader.bin \
                $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uboot-mediatek.bin \
                $@.boot \
                /tmp/img_sdcard.img \
                $(CONFIG_MEDIATEK_SD_BOOT_PARTSIZE) \
                $(CONFIG_MEDIATEK_MMC_ROOT_PARTSIZE)
        rm -f $@.boot
        rm -f /tmp/img_sdcard.img

endef

define Build/mediatek-mmc
        rm -f $@.boot
        mkfs.fat $@.boot -C $(FAT32_BLOCKS)
        mcopy -i $@.boot $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uEnv.txt ::uEnv.txt
        mcopy -i $@.boot $(IMAGE_KERNEL) ::uImage
        rm -f /tmp/img_mmc.img
        mkdir -p /tmp/img_mmc_d
        dd if=/dev/zero of=/tmp/img_mmc.img bs=1M count=$(CONFIG_MEDIATEK_MMC_ROOT_PARTSIZE)
        mkfs.ext4 /tmp/img_mmc.img
        sudo mount -o loop,rw,sync /tmp/img_mmc.img /tmp/img_mmc_d
        sudo cp -Rfv --preserve=mode,timestamps,links "$(BUILD_DIR)/root-mediatek/." /tmp/img_mmc_d/
        sudo umount /tmp/img_mmc_d
        ./gen_mediatek_mmc_img.sh $@ \
                $(STAGING_DIR_IMAGE)/$(DEVICE_NAME)-uboot-mediatek.bin \
                $@.boot \
                /tmp/img_mmc.img \
                $(CONFIG_MEDIATEK_SD_BOOT_PARTSIZE) \
                $(CONFIG_MEDIATEK_MMC_ROOT_PARTSIZE)
        rm -f $@.boot
        rm -f /tmp/img_mmc.img

endef

# for arm64
ifeq ($(SUBTARGET),mt7622)
KERNEL_LOADADDR = 0x41080000
endif

# default all platform image(fit) build 
define Device/Default
  PROFILES = Default $$(DEVICE_NAME)
  KERNEL_NAME := zImage
  FILESYSTEMS := squashfs
  DEVICE_DTS_DIR := $(DTS_DIR)
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata 
ifeq ($(SUBTARGET),mt7623)
  DEVICE_VARS := MEDIATEK_UBOOT
  KERNEL_NAME := zImage
  KERNEL := kernel-bin | append-dtb | uImage none
  KERNEL_INITRAMFS := kernel-bin | append-dtb | uImage none
  FILESYSTEMS += ext4
  IMAGES := sysupgrade.tar sdcard.img.gz mmc.img.gz
  IMAGE/sysupgrade.tar := sysupgrade-tar | append-metadata
  IMAGE/sdcard.img.gz := mediatek-sdcard | gzip | append-metadata
  IMAGE/mmc.img.gz := mediatek-mmc | gzip | append-metadata
endif
ifeq ($(SUBTARGET),mt7622)
  KERNEL_NAME := Image
  KERNEL = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS = kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
endif
endef

ifeq ($(SUBTARGET),mt7622)
include mt7622.mk
endif

ifeq ($(SUBTARGET),mt7623)
include mt7623.mk
endif

$(eval $(call BuildImage))


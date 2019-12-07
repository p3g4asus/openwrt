#
# Copyright (C) 2017 Chris Blake <chrisrblake93@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/kernel.mk

PKG_NAME:=mtk-stp
PKG_RELEASE:=1

PKG_MAINTAINER:=P3g4asus
PKG_LICENSE:=GPL-2.0

include $(INCLUDE_DIR)/package.mk

define KernelPackage/mtk-stp
  SUBMENU:=Wireless Drivers
  TITLE:= Wireless BT MTK
  DEPENDS:= @TARGET_mediatek +kmod-bluetooth +kmod-cfg80211
  FILES:=$(LINUX_DIR)/drivers/misc/mediatek/connectivity/common/conn_soc/linux/pub/stp_chrdev_bt.ko
  KCONFIG:=
endef

define KernelPackage/mtk-stp/description
  Wireless BT MTK
endef


define Build/Compile
	 true
endef

$(eval $(call KernelPackage,mtk-stp))

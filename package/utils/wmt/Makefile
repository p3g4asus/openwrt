#
# Copyright (C) 2015 Rafał Miłecki <zajec5@gmail.com>
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wmt
PKG_RELEASE:=3


include $(INCLUDE_DIR)/package.mk

define Package/wmt
  SECTION:=utils
  CATEGORY:=Base system
  TITLE:=Utility for configuring wmt driver
  DEPENDS:=@TARGET_mediatek
endef

define Package/wmt/description
 This package contains an utility for configuring wmt driver
endef

define Build/Compile
	$(MAKE) -C $(PKG_BUILD_DIR)/src \
		CC="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -Wall"
endef

WMT_FW_0:=ROMv2_lm_patch_1_0_hdr.bin
WMT_FW_1:=ROMv2_lm_patch_1_1_hdr.bin
WMT_FW_2:=WIFI_RAM_CODE_7623
WMT_NVRAM_FW:=WIFI
WMT_SOC:=WMT_SOC.cfg
WMT_HOSTAPD:=hostapd_ap0.conf

define Package/wmt/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_DIR) $(1)/etc/firmware/nvram
	$(INSTALL_DIR) $(1)/etc/hostapd
	$(INSTALL_DIR) $(1)/system/etc/firmware/nvram
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/wifi.sh $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/stp_uart_launcher $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/wmt_loader $(1)/usr/bin/
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/src/wmt_loopback $(1)/usr/bin/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_0) $(1)/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_1) $(1)/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_2) $(1)/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/config/$(WMT_SOC) $(1)/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/config/$(WMT_HOSTAPD) $(1)/etc/hostapd/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/nvram/$(WMT_NVRAM_FW) $(1)/etc/firmware/nvram/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_0) $(1)/system/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_1) $(1)/system/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/$(WMT_FW_2) $(1)/system/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/config/$(WMT_SOC) $(1)/system/etc/firmware/
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/firmware/nvram/$(WMT_NVRAM_FW) $(1)/system/etc/firmware/nvram/
endef

$(eval $(call BuildPackage,wmt))

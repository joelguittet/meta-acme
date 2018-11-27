DESCRIPTION = "Package group WiFi"
LICENSE = "MIT"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS_${PN} = " \
  packagegroup-base-wifi \
  linux-firmware-ralink \
  dhcp-client \
  crda \
"

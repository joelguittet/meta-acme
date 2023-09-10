DESCRIPTION = "Package group WiFi"
LICENSE = "MIT"
PACKAGE_ARCH = "${MACHINE_ARCH}"

inherit packagegroup

RDEPENDS:${PN} = " \
  packagegroup-base-wifi \
  linux-firmware-ralink \
  dhcpcd \
  crda \
"

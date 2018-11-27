#@TYPE: Machine
#@NAME: Arietta include
#@DESCRIPTION: Machine configuration for ACME Systems Arietta-G25 boards

require conf/machine/include/tune-arm926ejs.inc

PREFERRED_PROVIDER_virtual/kernel ?= "linux-at91"
PREFERRED_PROVIDER_virtual/bootloader ?= "u-boot-at91"

MACHINE_FEATURES = "usbgadget usbhost"

SERIAL_CONSOLES = "115200;ttyS0 115200;ttyGS0"

KERNEL_DEVICETREE = "at91-ariettag25.dtb"

AT91BOOTSTRAP_MACHINE = "at91sam9x5ek"
AT91BOOTSTRAP_TARGET = "at91sam9x5eksd_uboot_defconfig"
AT91BOOTSTRAP_LOAD = "sdboot-uboot"

UBOOT_MACHINE = "at91sam9x5ek_mmc_defconfig"

IMAGE_INSTALL_append = " kernel-modules"
EXTRA_IMAGEDEPENDS += "u-boot-at91 at91bootstrap"

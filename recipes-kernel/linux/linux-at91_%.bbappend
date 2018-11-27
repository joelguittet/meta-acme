# Customization of linux-at91

# Declare more compatible machines
COMPATIBLE_MACHINE .= "|arietta-g25|arietta-g25-256"

# Files directory
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Sources
SRC_URI_append = " \
    file://defconfig \
"

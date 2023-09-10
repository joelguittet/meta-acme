# Customization of u-boot-at91

# Declare more compatible machines
COMPATIBLE_MACHINE .= "|arietta-g25|arietta-g25-256"

# Files directory
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

# Sources
SRC_URI:append:arietta-g25 = " \
    file://uboot-env-arietta-g25.txt \
"
SRC_URI:append:arietta-g25-256 = " \
    file://uboot-env-arietta-g25-256.txt \
"

# Compile
do_compile:append:arietta-g25() {
    # u-boot environments
    ${S}/tools/mkenvimage -s 0x4000 -o ${S}/uboot.env ${WORKDIR}/uboot-env-arietta-g25.txt
}
do_compile:append:arietta-g25-256() {
    # u-boot environments
    ${S}/tools/mkenvimage -s 0x4000 -o ${S}/uboot.env ${WORKDIR}/uboot-env-arietta-g25-256.txt
}

# Deploy
do_deploy:append() {
    # u-boot environments
    install ${S}/uboot.env ${DEPLOYDIR}/uboot.env
}

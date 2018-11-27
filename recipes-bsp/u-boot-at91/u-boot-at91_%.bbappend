# Customization of u-boot-at91

# Declare more compatible machines
COMPATIBLE_MACHINE .= "|arietta-g25|arietta-g25-256"

# Files directory
FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

# Sources
SRC_URI_append_arietta-g25 = " \
    file://uboot-env-arietta-g25.txt \
"
SRC_URI_append_arietta-g25-256 = " \
    file://uboot-env-arietta-g25-256.txt \
"

# Compile
do_compile_append_arietta-g25() {
    # u-boot environments
    ${S}/tools/mkenvimage -s 0x4000 -o ${S}/uboot.env ${WORKDIR}/uboot-env-arietta-g25.txt
}
do_compile_append_arietta-g25-256() {
    # u-boot environments
    ${S}/tools/mkenvimage -s 0x4000 -o ${S}/uboot.env ${WORKDIR}/uboot-env-arietta-g25-256.txt
}

# Deploy
do_deploy_append() {
    # u-boot environments
    install ${S}/uboot.env ${DEPLOYDIR}/uboot.env
}

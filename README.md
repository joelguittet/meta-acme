meta-acme
==

Acme Systems Yocto meta layer.

This layer contains kernel, u-boot, bootstrap and image recipes to flash the Acme Systems boards.

This layer depends on the additional mandatory layers:
* meta-poky
* meta-yocto-bsp
* meta-openembedded/meta-oe
* meta-openembedded/meta-python
* meta-openembedded/meta-networking
* meta-atmel

Examples to use this layer are available in my Github at https://github.com/myfreescalewebpage/meta-acme-examples.


Philosophy of this meta layer
--

The main positions of this meta layer are the following:
* A single meta layer for all Acme Systems boards. Today, Arietta-G25 and Arietta-G25-256 are supported.
* The same baseline for all boards: same boostrap version (3.8.11), the same u-boot version (2017.03), the same kernel version (4.9), the same default kernel configuration. Only the specificities of the hardware differ (device tree).
* A step by step tutorial to help you building and flashing your first Acme Systems board (see chapter Using just below).
* Some simple tools to flash the boards (a single script to launch).

The whishes of the meta layer is to provide the most important abstraction to the hardware. Following the design rules described above, many applications can be executed on Arietta-G25 or Arietta-G25-256 without to worry about the hardware version used in you final design.

Moreover, the meta layer is improved thinking to the impacts on your own meta layer and trying to reduce them to the minimum.


Images
--

The following images are available:
* acme-image-minimal: the minimal image which is used to get the hardware running. Images all require this image.

The wanted image is chosen during the build with bitbake command.

New images created in other layers should at least require acme-image-minimal. 


Package groups
--

The following package groups are available:
* acme-packagegroup-wifi: to build images with WiFi tools to connect to an external network.
* acme-packagegroup-wifi-hotspot: to build images with WiFi tools to create an hotspot.

Package groups are included in wanted images.


Using
--

The following tutorial is useful to start building your own Yocto project and loading Acme Systems board. The development machine is running Ubuntu 16.04.

**_1- Install System Dependencies (once)_**

	sudo apt-get update && sudo apt-get upgrade
	sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib build-essential chrpath socat libsdl1.2-dev xterm lzop u-boot-tools git build-essential curl libusb-1.0-0-dev python-pip minicom libncurses5-dev
	sudo pip install --upgrade pip && sudo pip install pyserial

**_2- Get sources and flashing tools (once)_**

Clone sources:

	git clone --branch rocko git://git.yoctoproject.org/poky.git ~/yocto/poky
	git clone --branch rocko git://git.openembedded.org/meta-openembedded ~/yocto/meta-openembedded
	git clone --branch rocko https://github.com/linux4sam/meta-atmel ~/yocto/meta-atmel
	git clone https://github.com/myfreescalewebpage/meta-acme.git ~/yocto/meta-acme

Get Acme Systems tools:

	git clone https://github.com/myfreescalewebpage/acme-tools ~/yocto/acme-tools

Create images directory:

	mkdir -p ~/yocto/images

**_3- Configure build (once)_**

Setup environnement:

	cd ~/yocto
	source poky/oe-init-build-env

Add layers to the configuration file ~/yocto/build/conf/bblayers.conf:

	BBLAYERS ?= " \
	  ${TOPDIR}/../poky/meta \
	  ${TOPDIR}/../poky/meta-poky \
	  ${TOPDIR}/../poky/meta-yocto-bsp \
	  ${TOPDIR}/../meta-openembedded/meta-oe \
	  ${TOPDIR}/../meta-openembedded/meta-python \
	  ${TOPDIR}/../meta-openembedded/meta-networking \
	  ${TOPDIR}/../meta-atmel \
	  ${TOPDIR}/../meta-acme \
	"

Set machine in the configuration file ~/yocto/build/conf/local.conf:

	MACHINE ??= "arietta-g25"

Or:

	MACHINE ??= "arietta-g25-256"

Depending of the expected target.

**_4- Restore environnement (when restarting the development machine)_**

Restore environnement:

        cd ~/yocto
        source poky/oe-init-build-env

**_5- Build_**

Build minimal image:

	cd ~/yocto/build
	bitbake acme-image-minimal

**_6- Flash target_**

### Arietta-G25

Copy files in the images directory (replace acme-image-minimal-arietta-g25.tar.gz by the wanted rootfs if you have build another image):

	cp ~/yocto/build/tmp/deploy/images/arietta-g25/BOOT.BIN ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/u-boot.BIN ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/uboot.env ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/at91-ariettag25.dtb ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/zImage ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/acme-image-minimal-arietta-g25.tar.gz ~/yocto/images/rootfs.tar.gz
	cp ~/yocto/build/tmp/deploy/images/arietta-g25/modules-arietta-g25.tgz ~/yocto/images/modules.tar.gz

Then insert the SD card on your computer and flash the target (replace sdb by the right SD card drive name if you have another one, you can check it running 'dmesg' after inserting the SD card):

	cd ~/yocto/acme-tools/
	sudo ./acme-flash-arietta.sh sdb ~/yocto/images

At the end of the flashing procedure, install the SD card on the target and boot. The console is available on debug pins of the board and another one is also available throw the USB OTG cable (you should see a new tty device when connecting Arietta-G25 to your computer). Speed is 115200 for both consoles. Login is 'root' with no password.

### Arietta-G25-256

Copy files in the images directory (replace acme-image-minimal-arietta-g25-256.tar.gz by the wanted rootfs if you have build another image):

	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/BOOT.BIN ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/u-boot.bin ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/uboot.env ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/at91-ariettag25.dtb ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/zImage ~/yocto/images
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/acme-image-minimal-arietta-g25-256.tar.gz ~/yocto/images/rootfs.tar.gz
	cp ~/yocto/build/tmp/deploy/images/arietta-g25-256/modules-arietta-g25-256.tgz ~/yocto/images/modules.tar.gz

Then insert the SD card on your computer and flash the target (replace sdb by the right SD card drive name if you have another one, you can check it running 'dmesg' after inserting the SD card):

	cd ~/yocto/acme-tools/
	sudo ./acme-flash-arietta.sh sdb ~/yocto/images

At the end of the flashing procedure, install the SD card on the target and boot. The console is available on debug pins of the board and another one is also available throw the USB OTG cable (you should see a new tty device when connecting Arietta-G25-256 to your computer). Speed is 115200 for both consoles. Login is 'root' with no password.


Contributing
--

All contributions are welcome :-)

Particularly, I'm looking to integrate other Acme Systems boards in the layer and you can contact me if you are interested and if you are able to lend me a board few days to perform integration and testing.

Use Github Issues to report anomalies or to propose enhancements (labels are available to clearly identify what you are writing) and Pull Requests to submit modifications.


References
--

* https://www.acmesystems.it/

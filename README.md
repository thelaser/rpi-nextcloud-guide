# Nextcloud in a Raspberry

In this guide we will see how to setup Nextcloud in a RaspberryPi, setting up a free domain for it.

## Getting the necessary files and installing dependencies

Let's first install all that we will need for this guide:

SLOW(latest):
```
		sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip [[[qemu qemu-kvm qemu-system-armi]]] make git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev gcc

```

FAST(older version):
```
		sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip qemu qemu-kvm qemu-system-arm

```



First we will get the latest Raspbian version from the official sources and setup the appropriate environment: 
```	
		mkdir rpi
		wget https://downloads.raspberrypi.org/raspbian_lite_latest -O raspbian.zip 
		unzip raspbian.zip
		rm raspbian.zip
```

Now, to avoid us hassling with SD cards and all for now, we will prepare the image to be installed in the Raspberry from our own computer,  
this way we will be able to store the prepared image easily once it is ready.

To do this, we will use QEMU, to emulate a Raspberry in our own computer, and we will setup the image.


## Using QEMU

We already installed QEMU in the beginning of this guide, so we can go ahead and use it:

```
		git clone git://git.qemu-project.org/qemu.git
		cd qemu
		./configure
		make

```

```
		qemu-img convert -f raw -O qcow2 YYYY-MM-DD-raspbian-VERSION-lite.img raspbian-lite.qcow2


```

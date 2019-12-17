# Nextcloud in a Raspberry

In this guide we will see how to setup Nextcloud in a RaspberryPi, setting up a free domain for it.

## Getting the necessary files and installing dependencies

Let's first install all that we will need for this guide:

SLOW(latest):
```
sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip make git libglib2.0-dev libfdt-dev libpixman-1-dev zlib1g-dev gcc

```

FAST(older version):
```
sudo apt update && sudo apt upgrade -y && sudo apt install -y unzip qemu qemu-kvm qemu-system-arm
git clone git://git.qemu-project.org/qemu.git
cd qemu
./configure
make
make install

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

We already installed QEMU in the beginning of this guide, so we can go ahead and use it.

Before though, we will have to get the kernel to be used for the emulation. We will do this by cloning a Git repo:
```
git clone https://github.com/dhruvvyas90/qemu-rpi-kernel

```
Once we have the kernels, let's run QEMU:

```
# Let's add some extra space to the image
qemu-img resize YYYY-MM-DD-raspbian-buster-lite.img +1G

# Now let us emulate
qemu-system-arm \
  -M versatilepb \
  -cpu arm1176 \
  -m 256 \
  -hda /full/path/to/YYYY-MM-DD-raspbian-buster-lite.img \
  -net nic \
  -net user,hostfwd=tcp::5022-:22 \
  -kernel /full/path/to/kernel-qemu-4.19.50-buster \
  -append 'root=/dev/sda2 panic=1 rw' \
  -dtb /full/path/to/versatile-pb.dtb \
  -no-reboot \
  -display none \
  -serial mon:stdio
```


After running these commands, the shell where the last command was run will block, and in it, the Raspberry will be running. If you want to keep using the shell from your host
I recommend using tmux or screen.

Now, to log into the RPI we can use `user: pi` and `password: raspberry`.

Once inside we will be logging in as root by running `sudo su` and start configuring stuff around.

The first thing we are going to do is resize the disk so we can use the extra space we added to the image, to install stuff:

```
# make sure you are running this as root
fdisk /dev/sda2

# check which partitions exist
p
# the command above outputs the partitions, check the start and end for the sda1 partition, and afterwards delete sda2
d
2
# now we will recreate the partition, but using all of the actual free space in the partition
n
p
2
<end_of_sda1 + 1>
<use default as it should be end of disk>
# finally we will write changes to disk
w

# we will restart now the qemu 
shutdown now
./command

# now log in and do sudo su and then resize disk
resize2fs /dev/sda2

# should say something like "The filesystem on /dev/sda2 is now xxxxxxx blocks long." this is good. Check that the mountpoint / is now bigger
df -h

```

Now let's get some installing done:

```
add-apt-repository ppa:ondrej/php
apt update && apt upgrade
# this might take a while so grab a coffee or something

# Install nginx, php7.3 and mariadb. The full stack. 
apt install software-properties-common nginx php7.3-fpm php7.3-common php7.3-mysql php7.3-xml php7.3-xmlrpc php7.3-curl php7.3-gd php7.3-imagick php7.3-cli php7.3-dev php7.3-imap php7.3-mbstring php7.3-opcache php7.3-soap php7.3-zip unzip mariadb-server mariadb-client -y

```

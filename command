# this command should be run as root as it will use protected ports

qemu-system-arm \
  -M versatilepb \
  -cpu arm1176 \
  -m 256 \
  -hda /home/paugarcia/rpi/testoftest.img \
  -net user,hostfwd=tcp::2222-:22,hostfwd=tcp::80-:80,hostfwd=tcp::443-:443 \
  -net nic \
  -kernel /home/paugarcia/rpi/qemu-rpi-kernel/kernel-qemu-4.19.50-buster \
  -append 'root=/dev/sda2 panic=1 rw' \
  -dtb /home/paugarcia/rpi/qemu-rpi-kernel/versatile-pb.dtb \
  -no-reboot \
  -display none \
  -serial mon:stdio  

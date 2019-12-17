qemu-system-arm \
  -M versatilepb \
  -cpu arm1176 \
  -m 256 \
  -hda /home/paugarcia/rpi/testoftest.img \
  -net nic \
  -net user,hostfwd=tcp::5022-:22 \
  -kernel /home/paugarcia/rpi/qemu-rpi-kernel/kernel-qemu-4.19.50-buster \
  -append 'root=/dev/sda2 panic=1 rw' \
  -dtb /home/paugarcia/rpi/qemu-rpi-kernel/versatile-pb.dtb \
  -no-reboot \
  -display none \
  -serial mon:stdio  
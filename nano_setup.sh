#!/usr/bin/env bash
#initial setup - choose autologin otherwise it will cause problems later with lxdm:

apt-get purge -y libreoffice*
apt-get clean
apt-get install -y python3-pip
apt-get install -y tesseract-ocr
yes | pip3 install  flask 
yes | pip3 install  --upgrade pip
yes | pip3 install  --upgrade Pillow
yes | pip3 install pytesseract 
yes | pip3 install pyttsx3
apt-get install -y libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev liblapack-dev libblas-dev gfortran
yes | pip3 install -U pip testresources setuptools==49.6.0
yes | pip3 install -U numpy==1.16.1 future==0.18.2 mock==3.0.5 h5py==2.10.0 keras_preprocessing==1.1.1 keras_applications==1.0.8 gast==0.2.2 futures protobuf pybind11
yes | pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==2.3.1+nv20.11
yes | pip3 install --upgrade tensorflow-hub
apt install -y nodejs npm
yes | pip3 install jupyter jupyterlab 

#these dont work anyway so why bother, you can try to find nodejs >= 10.0.0; i dont use jupyter lab so i dont care:
#####sudo jupyter labextension install  @jupyter-widgets/jupyterlab-manager
#####sudo jupyter labextension install  @jupyterlab/statusbar

jupyter lab --generate-config
#manually run this line of code to make a password:
#####jupyter notebook password

#to start jupyter to braodcast to other computers:
#protip get ip address using:
#$ifconfig
#$jupyter notebook --ip=*

#save ram by removing unity gui
apt remove -y --purge ubuntu-desktop
#Install lxdm display manager. It may prompt a dialog to choose a display manager. Choose lxdm
apt install -y lxdm
#you will get a prompt here
apt remove --purge gdm3
apt install -y lxde
apt install -y lubuntu-desktop
apt install -y --reinstall lxdm

#root on usb install
git clone https://github.com/JetsonHacksNano/rootOnUSB
cd rootOnUSB
./addUSBToInitramfs.sh

#shutdown and reboot with a monitor connected:
#next use the disk manager/disks tool in the gui to deal with wiping the drive via format (yes all 0's is recommended) then create a partition and format as ext4 then mount.....

#run shell to copy over crap
#cd rootOnUSB

#will give line to add to modify boot file....
#./copyRootToUSB.sh -p /dev/sda1

#boot file to change is at: '/boot/extlinux/extlinux.conf
#modify boot file
#run
#./diskUUID.sh


# change APPEND line to the output from ./diskUUID.sh
###!!!!!!Do not delete line below which shows:
#  console=ttyS0, 115200n8 console=tty0 fbcon=map:0 net.ifnames=0
# if you do then expect issues
# only one line is changed here should be like: 
#APPEND ${cbootargs} root=UUID=0e437280-bea0-42a2-967f-a240dd3075eb rootwait rootfstype=ext4
#APPEND ${cbootargs} root=LABEL=JetsonNanoSSD500 rootwait rootfstype=ext4
#APPEND ${cbootargs} root=/dev/sda1 rootwait rootfstype=ext4
###!!!!!!Do not delete line below which shows:
#console=ttyS0, 115200n8 console=tty0 fbcon=map:0 net.ifnames=0
#if you do then expect issuesquiet 

#change INITRD line to:
#INITRD /boot/initrd-xusb.img

#reboot and it should boot and use the usb drive as the root drive.




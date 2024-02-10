

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y libfuse3-dev fuse3 blobfuse2

sudo mkdir -p /mnt/ramdisk
sudo mount -t tmpfs -o size=32g tmpfs /mnt/ramdisk
sudo mkdir -p /mnt/ramdisk/blobfuse2tmp
sudo chown ${USER} /mnt/ramdisk/blobfuse2tmp

mkdir -p ./datasets
blobfuse2 mount ./datasets --config-file=./azure-utilities/configs/azblob-config.yaml

rm packages-microsoft-prod.deb

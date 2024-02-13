# RUN One Line at a time

lsblk -o NAME,HCTL,SIZE,MOUNTPOINT | grep -i "sd"
sudo parted /dev/sdc --script mklabel gpt mkpart xfspart xfs 0% 100%
sudo mkfs.xfs /dev/sdc1
sudo partprobe /dev/sdc1

sudo mkdir /datadrive
sudo mount /dev/sdc1 /datadrive

echo '/dev/sdc1 /datadrive xfs defaults 0 0' | sudo tee -a /etc/fstab

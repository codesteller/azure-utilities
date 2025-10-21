#!/bin/bash

cwd=$(pwd)
cmake_version=3.30.0
cuda_version=12-5

# Backup bashrc
cp ~/.bashrc ~/.bashrc.bak

sudo apt update && sudo apt upgrade -y

# Install basic packages
sudo apt install -y build-essential cmake git unzip pkg-config wget \
    software-properties-common neovim neofetch btop htop curl tmux

# Install NVIDIA drivers and CUDA
sudo apt install -y ubuntu-drivers-common
sudo ubuntu-drivers install
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo apt install -y ./cuda-keyring_1.1-1_all.deb
sudo apt update
sudo apt -y install cuda-toolkit-${cuda_version}

# Install Docker with NVIDIA support
# Uncomment Below line for 22.04
# curl https://raw.githubusercontent.com/codesteller/utility-scripts/master/docker-setup-jammy-nv.sh | bash 

# Uncomment Below line for 24.04
curl https://raw.githubusercontent.com/codesteller/utility-scripts/refs/heads/noble/install_docker.sh | bash 

# Install ROS Humble
# curl https://raw.githubusercontent.com/codesteller/utility-scripts/master/install-ros-humble-jammy.sh | bash 

# Install NGC
mkdir -p ~/Apsoft/nvidia
cd ~/Apsoft/nvidia/
wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_linux.zip && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc
echo "export PATH=\"\$PATH:$(pwd)/ngc-cli\"" >> ~/.bashrc && source ~/.bashrc
ngc config set

# Install CMAKE Version
# Download and Install CMake
wget https://github.com/Kitware/CMake/releases/download/v${cmake_version}/cmake-${cmake_version}-linux-x86_64.tar.gz
tar -xvf cmake-${cmake_version}-linux-x86_64.tar.gz
mkdir cmake && mv cmake-${cmake_version}-linux-x86_64 cmake/${cmake_version}
sudo mv -f cmake /opt/
echo 'export cmake_version=3.30.0' >> ~/.bashrc 
echo 'export PATH=/opt/cmake/${cmake_version}/bin:$PATH' >> ~/.bashrc 

# Install cuDNN
cd ~/Apsoft/nvidia/
wget https://developer.download.nvidia.com/compute/redist/cudnn/v8.8.0/local_installers/12.0/cudnn-local-repo-ubuntu2204-8.8.0.121_1.0-1_amd64.deb 
sudo apt-get install zlib1g
sudo apt install -y ./cudnn-local-repo-ubuntu2204-8.8.0.121_1.0-1_amd64.deb
sudo cp /var/cudnn-local-repo-*/cudnn-local-*-keyring.gpg /usr/share/keyrings/
sudo chown -Rv _apt:root /var/cache/apt/archives/partial/
sudo chmod -Rv 700 /var/cache/apt/archives/partial/
sudo apt update

## Install Python Miniforge
# wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
# bash Miniforge3-$(uname)-$(uname -m).sh -b -p "${HOME}/Apsoft/miniforge3"
### Add path to bashrc
#echo "function env_conda()  {" | tee -a ~/.bashrc > /dev/null
#echo '    source "${HOME}/Apsoft/miniforge3/etc/profile.d/conda.sh"' | tee -a ~/.bashrc > /dev/null
#echo '    source "${HOME}/Apsoft/miniforge3/etc/profile.d/mamba.sh"' | tee -a ~/.bashrc > /dev/null
#echo '    mamba activate' | tee -a ~/.bashrc > /dev/null
#echo '} ' | tee -a ~/.bashrc > /dev/null

# Install uvicorn
curl -LsSf https://astral.sh/uv/install.sh | sh

# Install OpenCV
curl https://raw.githubusercontent.com/codesteller/utility-scripts/master/install-opencv-jammy.sh | bash




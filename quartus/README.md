## Installations with Quartus

We are using Quartus version 23.3

* **Option 1 (Manual Setup)** involves pulling a standard Intel oneAPI base image and then executing a series of shell commands inside the running container. This hands-on process guides you through adding the Intel `apt` repository and installing the necessary `intel-oneapi-base-toolkit` and `intel-oneapi-compiler-fpga` packages, followed by cloning the oneAPI samples repository. This method is transparent and allows for customisation at each step.

* **Option 2 (Automated Setup)** uses the provided `Dockerfile` to build a custom, pre-configured image with a single command. This is the recommended approach for quickly generating a ready-to-use development environment, as it automates all the installation and configuration steps detailed in the first option.

Regardless of the chosen method, the final outcome is a fully configured Docker container ready for development. Both options include a command to mount a local project directory into the container, ensuring that your work is preserved across sessions.

## Initial Setup:
```bash
# 1. Install Docker (if not already installed)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# 2. Clone the repository
git clone https://github.com/thomas-dsl-johnson/FOOD.git
```

## Option 1 - From Terminal: 

```bash
# 1. Setting up container
cd FOOD/quartus
# Pull 2025.0 oneAPI image
sudo docker pull intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04
# Start container (replace <container_name> with a suitable name)
sudo docker run --name <container_name> -it -v ./container_assets:/workspace intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04 /bin/bash

# 2. Setup within container - ensure the basekit is installed, install the fpga add-on
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
apt update
apt install intel-oneapi-base-toolkit-2025.0
apt install intel-oneapi-compiler-fpga-2025.0

# 3. Clone the samples repository
git clone -b master https://github.com/oneapi-src/oneAPI-samples.git
source /opt/intel/oneapi/setvars.sh

# 4. Set up quartus
wget -c https://downloads.intel.com/akdlm/software/acdsinst/23.3/104/ib_tar/Quartus-pro-23.3.0.104-linux-complete.tar
tar -xf Quartus-pro-23.3.0.104-linux-complete.tar
./setup_pro.sh 
export QUARTUS_ROOTDIR=/root/intelFPGA_pro/23.3/quartus
export QUARTUS_ROOTDIR_OVERRIDE=/root/intelFPGA_pro/23.3/quartus


# We are done. Exit container.
exit

# In future you can start the container easily
sudo docker start -ai <container_name>
```

## Option 2 - From Dockerfile: 
```bash
# 1. Build from the Dockerfile
cd FOOD/quartus
sudo docker build -t intel-oneapi-fpga-dev-w-quartus:2025-custom .

# 2. Build custom image from Dockerfile
docker build -t intel-oneapi-fpga-dev-w-quartus:2025-custom .

# 3. Run container (replace <container_name> with a suitable name)
sudo docker run --name <container_name> -it -v ./container_assets:/workspace intel-oneapi-fpga-dev-w-quartus:2025-custom

# We are done. Exit container.
exit

# In future you can start the container easily
sudo docker start -ai <container_name>
```

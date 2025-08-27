# 🥙 FOOD - FPGA environment setup On OneAPI with Docker

## Option 1 - From Terminal: 

```bash
# 1. Setting up container
# Install Docker (if not already installed)
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
# Pull 2025.0 oneAPI image
sudo docker pull intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04
# Start container (replace <container_name> with a suitable name)
sudo docker run --name <container_name> -it -v ~/oneapi_fpga_2025:/host_project intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04 /bin/bash

# 2. Setup within container - ensure the basekit is installed, install the fpga add-on
wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
| gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list
apt update
apt install intel-oneapi-base-toolkit-2025.0
apt install intel-oneapi-compiler-fpga-2025.0

# 3. Clone the samples repository
git clone -b master https://github.com/oneapi-src/oneAPI-samples.git
source /opt/intel/oneapi/setvars.sh

# We are done. Exit container.
exit

# In future you can start the container easily
sudo docker start -ai <container_name>
```

## Option 2 - From Dockerfile: 
```bash
# 1. Clone the repository
git clone https://github.com/thomas-dsl-johnson/FOOD.git
cd FOOD

# 2. Build from the Dockerfile
sudo docker build -t intel-oneapi-fpga-dev:2025-custom .

# 3. Run container (replace <container_name> with a suitable name)
sudo docker run --name <container_name> -it -v ~/oneapi_fpga_2025:/workspace intel-oneapi-fpga-dev:2025-custom

# We are done. Exit container.
exit

# In future you can start the container easily
sudo docker start -ai <container_name>
```

## Sources:

Step 1:
* [Intel oneAPI Docker Images](https://hub.docker.com/r/intel/oneapi-basekit)

Step 2:
* [Getting Started with the Intel oneAPI DPC++/C++ Compiler for Intel FPGA Development : website](https://www.intel.com/content/www/us/en/docs/oneapi-fpga-add-on/developer-guide/2025-0/getting-started-with-the-intel-oneapi-dpc-c.html)
* [Installing the Intel® oneAPI FPGA Development Environment : pdf](https://cdrdv2.intel.com/v1/dl/getContent/854477)

## Installations with Quartus

We are using Quartus version 23.3

```bash
# 1. Set up quartus
wget -c https://downloads.intel.com/akdlm/software/acdsinst/23.3/104/ib_tar/Quartus-pro-23.3.0.104-linux-complete.tar
tar -xf Quartus-pro-23.3.0.104-linux-complete.tar
./setup_pro.sh 
export QUARTUS_ROOTDIR=/root/intelFPGA_pro/23.3/quartus
export QUARTUS_ROOTDIR_OVERRIDE=/root/intelFPGA_pro/23.3/quartus

# 2. Source
source /opt/intel/oneapi/setvars.sh --force
```

n.b. Debugging notes
```bash
wget -c https://downloads.intel.com/akdlm/software/acdsinst/24.1/115/ib_tar/Quartus-pro-24.1.0.115-linux-complete.tar
apt-get update
apt-get install libfontconfig1
apt-get install -y locales
locale-gen en_US.UTF-8
export LANG=en_US.UTF-8
apt-get install -y libxext6
```

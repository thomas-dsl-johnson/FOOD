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
source /opt/intel/oneapi/setvars.sh -- force
```

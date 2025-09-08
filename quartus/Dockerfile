# 1. Base Image
# Use the official Intel oneAPI Base Kit image as the foundation.
FROM intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04

# Add labels for metadata (optional but good practice)
LABEL description="Intel oneAPI Base Kit + FPGA Add-on + Quartus Pro 23.3"

# Set environment to non-interactive to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# 2. Install Dependencies & oneAPI Toolkits
# This single RUN command is more efficient: it creates only one image layer.
# It updates, installs dependencies, adds the repo, installs toolkits, and cleans up.
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg ca-certificates git && \
    # Add Intel's GPG key and repository
    wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor > /usr/share/keyrings/oneapi-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" > /etc/apt/sources.list.d/oneAPI.list && \
    # Install the required toolkits
    apt-get update && \
    apt-get install -y intel-oneapi-base-toolkit-2025.0 intel-oneapi-compiler-fpga-2025.0 && \
    # Clean up apt cache to reduce image size
    rm -rf /var/lib/apt/lists/*

# 3. Install Quartus Prime Pro
# This step downloads, extracts, runs the unattended installer, and cleans up in one layer.
RUN wget -q https://downloads.intel.com/akdlm/software/acdsinst/23.3/104/ib_tar/Quartus-pro-23.3.0.104-linux-complete.tar -O Quartus-pro.tar && \
    mkdir quartus_installer && \
    tar -xf Quartus-pro.tar -C quartus_installer --strip-components=1 && \
    cd quartus_installer && \
    # Run the installer in unattended mode to avoid any prompts
    ./setup.sh --mode unattended --accept_eula 1 --installdir /opt/intelFPGA_pro/23.3 && \
    # Clean up the installer files to save space
    cd .. && \
    rm -rf quartus_installer Quartus-pro.tar

# 4. Set Environment Variables & Finalize
# Set environment variables required for Quartus.
ENV QUARTUS_ROOTDIR=/opt/intelFPGA_pro/23.3/quartus
ENV QUARTUS_ROOTDIR_OVERRIDE=/opt/intelFPGA_pro/23.3/quartus

# Clone the oneAPI samples repository.
RUN git clone -b master https://github.com/oneapi-src/oneAPI-samples.git

# IMPORTANT: Configure the shell to automatically source the oneAPI environment script.
# This ensures the compiler and tools are in your PATH when you start an interactive shell.
RUN echo "source /opt/intel/oneapi/setvars.sh" >> /root/.bashrc

# 5. Set Working Directory and Default Command
WORKDIR /workspace
CMD ["/bin/bash"]

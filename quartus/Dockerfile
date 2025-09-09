# Use Intel oneAPI base image as the foundation
FROM intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04

# Set environment to non-interactive to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install oneAPI Toolkits and dependencies in a single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg ca-certificates git && \
    wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearmor > /usr/share/keyrings/oneapi-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" > /etc/apt/sources.list.d/oneAPI.list && \
    apt-get update && \
    apt-get install -y intel-oneapi-base-toolkit-2025.0 intel-oneapi-compiler-fpga-2025.0 && \
    rm -rf /var/lib/apt/lists/*

# 1. Copy the local Quartus tarball into the image
COPY Quartus-pro-23.3.0.104-linux-complete.tar /tmp/Quartus-pro.tar

# 2. Install Quartus from the copied file and clean up
RUN mkdir quartus_installer && \
    tar -xf /tmp/Quartus-pro.tar -C quartus_installer --strip-components=1 && \
    cd quartus_installer && \
    chmod +x setup.sh && \
    ./setup.sh --mode unattended --accept_eula 1 --installdir /opt/intelFPGA_pro/23.3 && \
    cd .. && \
    # Clean up the installer and the copied tarball to keep the image small
    rm -rf quartus_installer /tmp/Quartus-pro.tar
# --- END MODIFIED SECTION ---

# Set permanent environment variables for Quartus
ENV QUARTUS_ROOTDIR=/opt/intelFPGA_pro/23.3/quartus
ENV QUARTUS_ROOTDIR_OVERRIDE=/opt/intelFPGA_pro/23.3/quartus

# Clone samples and configure the shell to auto-source oneAPI environment
RUN git clone -b master https://github.com/oneapi-src/oneAPI-samples.git && \
    echo "source /opt/intel/oneapi/setvars.sh" >> /root/.bashrc

# Set the default working directory and command
WORKDIR /workspace
CMD ["/bin/bash"]

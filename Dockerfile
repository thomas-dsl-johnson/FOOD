# Use Intel oneAPI base image as starting point
FROM intel/oneapi-basekit:2025.0.2-0-devel-ubuntu24.04

# Set environment variables for non-interactive apt installs
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    gnupg \
    git \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Add Intel GPG key
RUN wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB \
    | gpg --dearmor > /usr/share/keyrings/oneapi-archive-keyring.gpg

# Add Intel oneAPI repository
RUN echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" \
    > /etc/apt/sources.list.d/oneAPI.list

# Install Intel oneAPI base toolkit and FPGA compiler
RUN apt-get update && apt-get install -y --no-install-recommends \
    intel-oneapi-base-toolkit-2025.0 \
    intel-oneapi-compiler-fpga-2025.0 \
    && rm -rf /var/lib/apt/lists/*

# Clone oneAPI samples (optional)
RUN git clone -b master https://github.com/oneapi-src/oneAPI-samples.git /opt/oneAPI-samples

# Source oneAPI environment
SHELL ["/bin/bash", "-c"]
RUN echo "source /opt/intel/oneapi/setvars.sh" >> ~/.bashrc

# Set default working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]

# Container Assets

## How it works

* Any file you put in ~/oneapi_fpga_2025 on your host will immediately be visible inside the container at /workspace.
* Any file you create or modify inside /workspace in the container will appear on your host in ~/oneapi_fpga_2025.
* This keeps your work persistent even if the container is deleted, because the data lives on your host.

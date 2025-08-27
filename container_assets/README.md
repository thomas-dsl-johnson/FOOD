# Container Assets

## How it works

* Any file you put in ./container_assets on your host will immediately be visible inside the container at /workspace.
* Any file you create or modify inside /workspace in the container will appear on your host in ./container_assets.
* This keeps your work persistent even if the container is deleted, because the data lives on your host.

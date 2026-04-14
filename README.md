# CUDA Development Container
This repo configures a CUDA enabled python development container. 
If you are unfamiliar with development containers, check out [this page](https://github.com/microsoft/vscode-dev-containers).

## Installation

1. Add repo as submodule
```
git submodule add git@github.com:raphaelschwinger/cuda-python-devcontainer.git .devcontainer
```

2. Set `CUDA_VERSION` and `VARIANT` in `.devcontainer/devcontainer.json` to your desired values. 
   The CUDA and Ubuntu version has to match with image tags found [here](https://hub.docker.com/r/nvidia/cuda).

3. Reopen in container

4. Init [uv](https://docs.astral.sh/uv/) project
```
uv init
```

5. Start installing packages
```
uv add <package>
```

6. Run python in the virtualenv
```
uv run python
```
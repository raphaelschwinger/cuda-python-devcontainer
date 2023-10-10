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

4. Init poetry project
```
poetry init
```

or create your own `pyproject.toml` file.

```toml
[tool.poetry]
name = "pytorch-lightning-devcontainer-example"
version = "0.1.0"
description = ""
authors = ["Raphael Schwinger"]
readme = "README.md"

[tool.poetry.dependencies]
python = "^3.8"
pathlib = "^1.0.1"
argparse = "^1.4.0"
torch = [
    {url = "https://download.pytorch.org/whl/cu117/torch-2.0.1%2Bcu117-cp38-cp38-linux_x86_64.whl", platform = "linux", python = ">=3.8 <3.9"}
]
torchvision = [
    {url = "https://download.pytorch.org/whl/cu117/torchvision-0.15.2%2Bcu117-cp38-cp38-linux_x86_64.whl", platform = "linux", python = ">=3.8 <3.9"}
]
torchaudio = [
    {url = "https://download.pytorch.org/whl/cu117/torchaudio-2.0.2%2Bcu117-cp38-cp38-linux_x86_64.whl", platform = "linux", python = ">=3.8 <3.9"}
]
ipykernel = "^6.25.2"
lightning = "^2.0.8"
jupyter = "^1.0.0"
pillow = "^10.0.0"



[build-system]
requires = ["poetry-core"]
build-backend = "poetry.core.masonry.api"
```
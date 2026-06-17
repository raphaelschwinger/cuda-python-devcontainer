# CUDA Development Container
This repo configures a CUDA enabled python development container. 
If you are unfamiliar with development containers, check out [this page](https://github.com/microsoft/vscode-dev-containers).

## Installation

Choose one of the following ways to add this repo to your project.

### Option A: Git submodule (recommended)

1. Add repo as submodule
```
git submodule add git@github.com:raphaelschwinger/cuda-python-devcontainer.git .devcontainer
```

To update later:
```
git submodule update --remote .devcontainer
```

### Option B: Download into `.devcontainer`

Use this if you do not want a submodule in your project.

**One-time setup** — clone only the files you need:

```
git clone --depth 1 git@github.com:raphaelschwinger/cuda-python-devcontainer.git .devcontainer
```

Or download a snapshot without git history:

```
mkdir -p .devcontainer
curl -L https://github.com/raphaelschwinger/cuda-python-devcontainer/archive/refs/heads/main.tar.gz \
  | tar xz --strip-components=1 -C .devcontainer
```

Add `.devcontainer/` to your project's `.gitignore` if you do not want to track these files.

**Updating from the main repo**

If you used `git clone`, pull the latest changes:

```
cd .devcontainer
git pull
cd ..
```

If you used the tarball download, re-download and extract. Back up any local edits to `devcontainer.json` first (for example `CUDA_VERSION` and `VARIANT`):

```
mv .devcontainer/devcontainer.json /tmp/devcontainer.json.bak
rm -rf .devcontainer
mkdir -p .devcontainer
curl -L https://github.com/raphaelschwinger/cuda-python-devcontainer/archive/refs/heads/main.tar.gz \
  | tar xz --strip-components=1 -C .devcontainer
mv /tmp/devcontainer.json.bak .devcontainer/devcontainer.json
```

### Configure and run

1. Set `CUDA_VERSION` and `VARIANT` in `.devcontainer/devcontainer.json` to your desired values. 
   The CUDA and Ubuntu version has to match with image tags found [here](https://hub.docker.com/r/nvidia/cuda).

2. Reopen in container

3. Init [uv](https://docs.astral.sh/uv/) project
```
uv init
```

4. Start installing packages
```
uv add <package>
```

5. Run python in the virtualenv
```
uv run python
```
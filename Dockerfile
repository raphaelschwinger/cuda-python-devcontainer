
ARG VARIANT="ubuntu22.04" 
ARG CUDA_VERSION="12.4.1"
FROM nvidia/cuda:${CUDA_VERSION}-devel-${VARIANT}

# # set non interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# # install dependencies to build python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcairo2-dev \
    pkg-config \
    python3-dev \
    git \
    curl \
    bash-completion \
    ssh \
    vim \
    tmux \
    htop

# Install uv system-wide
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN UV_INSTALL_DIR=/usr/local/bin sh /uv-installer.sh && rm /uv-installer.sh

# Create a non-root user matching the host UID/GID
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt-get install -y --no-install-recommends sudo \
    && echo "${USERNAME} ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

COPY --chown=${USERNAME}:${USERNAME} config/.tmux.conf /home/${USERNAME}/.tmux.conf

# add your own dependencies here!
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     [your-own-dependencies] \

# set DEBIAN_FRONTEND back to dialog
ARG DEBIAN_FRONTEND=dialog

USER ${USERNAME}


ARG VARIANT="ubuntu22.04" 
ARG CUDA_VERSION="11.7.1"
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

RUN touch ~/.tmux.conf \
    && echo "set -g mouse on" >> ~/.tmux.conf
    && bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"

# install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/root/.local/bin:$PATH"

# add your own dependencies here!
# RUN apt-get update && apt-get install -y --no-install-recommends \
#     [your-own-dependencies] \ 

# set DEBIAN_FRONTEND back to dialog
ARG DEBIAN_FRONTEND=dialog

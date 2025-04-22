
ARG VARIANT="ubuntu22.04" 
ARG CUDA_VERSION="11.7.1"
FROM nvidia/cuda:${CUDA_VERSION}-devel-${VARIANT}

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

# Create the user
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME


# # set non interactive mode
ARG DEBIAN_FRONTEND=noninteractive

# # install dependencies to build python packages
RUN apt-get update && apt-get install -y --no-install-recommends \
zsh \
git \
curl \
wget \
vim \
tmux \
htop \
ffmpeg \
bash-completion \
ssh \
python3-dev \
pkg-config \
libcairo2-dev

COPY config/.tmux.conf /home/$USERNAME/.tmux.conf

USER $USERNAME

RUN curl -sSL https://install.python-poetry.org | python3 -

ENV PATH="/home/$USERNAME/.local/bin:$PATH"

# ZSH stuff (Oh my zsh, plugins, powerlevel10k)
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-/home/$USERNAME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-/home/$USERNAME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    git clone https://github.com/MichaelAquilina/zsh-you-should-use ${ZSH_CUSTOM:-/home/$USERNAME/.oh-my-zsh/custom}/plugins/you-should-use && \
    git clone https://github.com/fdellwing/zsh-bat ${ZSH_CUSTOM:-/home/$USERNAME/.oh-my-zsh/custom}/plugins/zsh-bat && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-/home/$USERNAME/.oh-my-zsh/custom}/themes/powerlevel10k

# Copy custom .zshrc and .p10k.zsh files
COPY config/.zshrc /home/$USERNAME/.zshrc
COPY config/.p10k.zsh /home/$USERNAME/.p10k.zsh
# Change shell to zsh
RUN sudo chsh -s $(which zsh) $USERNAME
# Ensure ownership of copied files
RUN sudo chown -R $USERNAME:$USERNAME /home/$USERNAME

# set DEBIAN_FRONTEND back to dialog
ARG DEBIAN_FRONTEND=dialog
# [Optional] Set the default user. Omit if you want to keep the default as root.

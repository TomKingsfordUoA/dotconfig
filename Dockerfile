# FROM debian:bullseye-slim
# TODO install node in debian rather than deriving from node's base image
FROM node:23-bullseye-slim  

# Core dependencies:
RUN apt update
RUN apt install -y build-essential git gcc g++ gdb
RUN apt install -y wget unzip curl 

RUN apt install -y python3 python3-venv python3-pip

# Install system utilities from python
WORKDIR /root/_ext
RUN mkdir bin
RUN python3 -m venv venv
ENV PATH="$PATH:/root/_ext/venv/bin:/root/_ext/bin"
RUN ./venv/bin/python3 -m pip install uv pwntools
RUN ln -s $(pwd)/venv/bin/uv /bin/uv
RUN ln -s $(pwd)/venv/bin/pwn /bin/pwn

# Install lua rocks (package manager)
WORKDIR /root/_ext/luarocks
# RUN apt install -y lua5.3 liblua5.3-dev
RUN apt install -y lua5.1 liblua5.1-dev  # neovim wants 5.1 in particular
RUN wget https://luarocks.org/releases/luarocks-3.11.1.tar.gz
RUN tar -xzf luarocks-3.11.1.tar.gz
RUN cd luarocks* && ./configure && make && make install
RUN luarocks install luasocket

# Install and upgrade node/nvm/npm:
# RUN apt install -y npm
# RUN npm install -g npm@latest

# Install pyright
RUN npm install -g pyright

# Install ruff
RUN pip install ruff

# Install fzf, ripgrep, etc.
RUN wget https://github.com/junegunn/fzf/releases/download/v0.57.0/fzf-0.57.0-linux_amd64.tar.gz
RUN tar -xzf fzf*.tar.gz
RUN mv fzf /root/_ext/bin
# TODO install ripgrep
# TODO install fd-find 
RUN apt install -y ripgrep fd-find

# Install language servers, linters, etc.
# RUN /root/_ext/venv/bin/pyhon3 -m pip install pyright ruff
RUN pyright  # performs some updates and returns

# Download neovim:
WORKDIR /root/_ext/nvim
RUN wget https://github.com/neovim/neovim/releases/download/v0.10.3/nvim-linux64.tar.gz
RUN tar -xzf nvim-linux64.tar.gz 
RUN ln -s $(pwd)/nvim-linux64/bin/nvim /bin/nvim
# RUN mkdir -p /root/.config/nvim

# # Install lazyvim and perform update
# RUN git clone https://github.com/LazyVim/starter /root/.config/nvim
# # RUN nvim --headless '+Lazy! install' +MasonInstallAll +qall
# # RUN nvim --headless "+Lazy! sync" +qa
# RUN timeout -s SIGINT 20s nvim --headless -V ":Lazy" || true  # hack to start it once and install dependencies
# ADD options.lua /root/.config/nvim/lua/config/options.lua

WORKDIR /root/.config/nvim
ADD ./config /root/.config

#WORKDIR /root/.local
#ADD ./local /root/.local

# Update neovim:
RUN nvim --headless "+Lazy! install" "+Lazy! sync" +qa
RUN nvim --headless "+TSUpdate!" +qa
RUN nvim --headless "+Mason" "+MasonInstall pyright ruff lua-language-server" +qa

# Stop git complaining about ownership:
RUN git config --global --add safe.directory "*"

# Clean up .git repos:
RUN rm -rf $(find ~/.local -name .git)

WORKDIR /root/projects

ENTRYPOINT  ["/bin/bash"]

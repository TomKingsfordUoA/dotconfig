FROM ubuntu:24.10

# Core dependencies:
RUN apt update
RUN apt install -y build-essential git gcc g++ gdb
RUN apt install -y wget unzip fzf curl ripgrep fd-find

RUN apt install -y python3 python3-venv python3-pip 

# Install system utilities from python
WORKDIR /root/_ext
RUN python3 -m venv venv
ENV PATH="$PATH:/root/_ext/venv/bin"
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

# Install language servers, linters, etc.
RUN /root/_ext/venv/bin/python3 -m pip install pyright ruff
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

WORKDIR /root/.local
ADD ./local /root/.local

# Stop git complaining about ownership:
RUN git config --global --add safe.directory "*"

WORKDIR /root/projects

ENTRYPOINT ["/bin/bash"]

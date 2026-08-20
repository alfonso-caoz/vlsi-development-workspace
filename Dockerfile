FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    # iverilog: Event-driven simulator for Verilog, and Verilog testbenches
    iverilog \
    # verilator: Cycle-accurate simulator for Verilog and SystemVerilog, and C++ testbenches
    verilator \
    make \
    g++ \
    libc6-dev \
    # gtkwave: Waveform viewer for digital circuits
    gtkwave \
    # Librelane dependencies 
    python3 \
    python3-pip \
    python3-venv \
    python3-tk \
    docker.io \
    curl \
    git \
    # uvm-verilator - UVM Constrained Randomization dependencies
    z3 \
    libz3-dev \
    # Remove apt cache to reduce image size
    && rm -rf /var/lib/apt/lists/*

# Librelane installation
RUN python3 -m venv /opt/librelane-env \
    && /opt/librelane-env/bin/pip install --upgrade pip setuptools wheel \
    && /opt/librelane-env/bin/pip install --no-cache-dir librelane

ENV PATH="/opt/librelane-env/bin:$PATH"

# uvm-verilator: installation to write SystemVerilog testbenches using UVM methodology with verilator simulator
# .git history not needed, so we fetch only the specific commit to reduce image size
RUN mkdir -p /opt/uvm && cd /opt/uvm \
    && git init . \
    && git remote add origin https://github.com/chipsalliance/uvm-verilator.git \
    && git fetch --depth 1 origin 1eab10a7995c7846dcad7305b995ddb265880433 \
    && git checkout FETCH_HEAD

ENV UVM_HOME="/opt/uvm/src"

# Workspace setup
WORKDIR /vlsi-development-workspace

# Container starts with bash shell
CMD ["/bin/bash"]

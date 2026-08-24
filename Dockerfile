# Ubuntu 26.04 snapshot, no linked to an architecture (https://hub.docker.com/_/ubuntu/tags)
FROM ubuntu:resolute-20260811.1@sha256:2260313b31c8c011cd2eebe728008efac1b3982be73eb71348ea2648d2c0e09b

ENV DEBIAN_FRONTEND=noninteractive

# TOOL PINNED VERSIONS
# Docker-ce-cli installed via official repository added to APT sources list
ARG DOCKER_CE_CLI_VERSION=5:29.7.2-1~ubuntu.26.04~resolute
# Tools installed via APT package manager
ARG APT_SNAPSHOT_DATE=20260824T000000Z # Setup Date: 2026-08-24 T:00:00:00 Z: UTC
# Tools installed via PIP (Python Package Index) in a virtual environment
ARG PIP_VERSION=26.2.1
ARG SETUPTOOLS_VERSION=84.0.0
ARG WHEEL_VERSION=0.48.0
ARG LIBRELANE_VERSION=3.0.10
# Tools installed from source code compilation (git clone, build and install)
ARG IVERILOG_COMMIT=dfeee909ed9f20b4870dd93423156c0170c0e1ff # stable 13.0 (2026-03-01)
ARG VERILATOR_COMMIT=848d926ebd4addacacd294dc84e35d9d4ae8078c # v5.050 (2026-07-01)
ARG UVM_VERILATOR_COMMIT=1eab10a7995c7846dcad7305b995ddb265880433 # uvm-2020-3.2 (2026-08-14)

# Docker prerequisites installation and configuration
RUN apt-get update && apt-get install -y ca-certificates curl --no-install-recommends && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc

# Docker repository added to APT sources list for resolute release (26.04) to install docker-ce-cli package
RUN echo "Types: deb" > /etc/apt/sources.list.d/docker.sources && \
    echo "URIs: https://download.docker.com/linux/ubuntu" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Suites: resolute" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Components: stable" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Architectures: $(dpkg --print-architecture)" >> /etc/apt/sources.list.d/docker.sources && \
    echo "Signed-By: /etc/apt/keyrings/docker.asc" >> /etc/apt/sources.list.d/docker.sources

# APT snapshot, see https://snapshot.ubuntu.com/
RUN echo "APT::Snapshot "${APT_SNAPSHOT_DATE}";" > /etc/apt/apt.conf.d/50snapshot

# Main EDA tools installation
RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-ce-cli=${DOCKER_CE_CLI_VERSION} \
    build-essential cmake gdb nano git autoconf bison flex libfl-dev perl-doc help2man ccache gperf libreadline-dev \
    python3 python3-pip python3-venv python3-tk python3-dev \
    gtkwave libcanberra-gtk3-module \
    z3 libz3-dev \
    && rm -rf /var/lib/apt/lists/*

# GTKWave: Turn off warning: Failed to connect to AT-SPI bus, when running gtkwave in a container
ENV NO_AT_BRIDGE=1

# Icarus Verilog download, build and installation
RUN git clone --depth 1 --revision ${IVERILOG_COMMIT} https://github.com/steveicarus/iverilog.git /tmp/iverilog && \
    cd /tmp/iverilog && \
    sh autoconf.sh && \
    ./configure --prefix=/opt/iverilog && \
    make -j$(nproc) && \
    make install && \
    cd / && rm -rf /tmp/iverilog

ENV PATH="/opt/iverilog/bin:${PATH}"

# Verilator download, build and installation
RUN git clone --depth 1 --revision ${VERILATOR_COMMIT} https://github.com/verilator/verilator.git /tmp/verilator && \
    cd /tmp/verilator && \
    autoconf && \
    ./configure --prefix=/opt/verilator && \
    make -j$(nproc) && \
    make install && \
    cd / && rm -rf /tmp/verilator

ENV PATH="/opt/verilator/bin:${PATH}"

# UVM-Verilator library download
RUN git clone --depth 1 --revision ${UVM_VERILATOR_COMMIT} https://github.com/chipsalliance/uvm-verilator.git /opt/uvm-verilator && \
    rm -rf /opt/uvm-verilator/.git

ENV UVM_HOME="/opt/uvm-verilator"

# Librelane installation
RUN python3 -m venv /opt/librelane-env && \
    /opt/librelane-env/bin/pip install --no-cache-dir --upgrade pip==${PIP_VERSION} setuptools==${SETUPTOOLS_VERSION} wheel==${WHEEL_VERSION} && \
    /opt/librelane-env/bin/pip install --no-cache-dir librelane==${LIBRELANE_VERSION}

ENV PATH="/opt/librelane-env/bin:$PATH"

# Workspace setup
WORKDIR /eda-env-workspace

# Container starts with bash shell
CMD ["/bin/bash"]

FROM ubuntu:resolute-20260811.1@sha256:2260313b31c8c011cd2eebe728008efac1b3982be73eb71348ea2648d2c0e09b

ENV DEBIAN_FRONTEND=noninteractive

# Disable GTKWave in Container warning message "No accessibility bus address found"
ENV NO_AT_BRIDGE=1

# TOOL PINNED VERSIONS
ARG DOCKER_CE_CLI_VERSION=5:29.7.2-1~ubuntu.26.04~resolute          # (2026-08-06)
ARG APT_SNAPSHOT_DATE=20260825T000000Z                              # (2026-08-25 T:00:00:00 Z:UTC)

ARG PIP_VERSION=26.2.1                                              # (2026-08-04)
ARG SETUPTOOLS_VERSION=84.0.0                                       # (2026-08-08)
ARG WHEEL_VERSION=0.48.0                                            # (2026-08-11)
ARG LIBRELANE_VERSION=3.0.11                                        # (2026-08-24)

ARG IVERILOG_COMMIT=dfeee909ed9f20b4870dd93423156c0170c0e1ff        # stable 13.0  (2026-03-01)
ARG VERILATOR_COMMIT=848d926ebd4addacacd294dc84e35d9d4ae8078c       # v5.050       (2026-07-01)
ARG UVM_VERILATOR_COMMIT=1eab10a7995c7846dcad7305b995ddb265880433   # uvm-2020-3.2 (2026-08-14)

# 1- Docker CLI, and APT Snapshot Configuration
RUN apt-get update && apt-get install -y ca-certificates curl --no-install-recommends && \
    install -m 0755 -d /etc/apt/keyrings && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc && \
    chmod a+r /etc/apt/keyrings/docker.asc && \
    echo "Types: deb\nURIs: https://download.docker.com/linux/ubuntu\nSuites: resolute\nComponents: stable\nArchitectures: $(dpkg --print-architecture)\nSigned-By: /etc/apt/keyrings/docker.asc" > /etc/apt/sources.list.d/docker.sources && \
    echo "APT::Snapshot "${APT_SNAPSHOT_DATE}";" > /etc/apt/apt.conf.d/50snapshot

# 2- Main Toolchains and Runtime Dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    docker-ce-cli=${DOCKER_CE_CLI_VERSION} \
    build-essential cmake gdb nano git openssh-client autoconf bison flex libfl-dev perl-doc help2man ccache gperf libreadline-dev \
    python3 python3-pip python3-venv python3-tk python3-dev \
    gtkwave libcanberra-gtk3-module \
    z3 libz3-dev \
    && rm -rf /var/lib/apt/lists/*

# 3- Compile and Install: Icarus Verilog, Verilator, and UVM-Verilator
RUN git clone --depth 1 --revision ${IVERILOG_COMMIT} https://github.com/steveicarus/iverilog.git /tmp/iverilog && \
    cd /tmp/iverilog && sh autoconf.sh && ./configure --prefix=/opt/iverilog && make -j$(nproc) && make install && \
    \
    git clone --depth 1 --revision ${VERILATOR_COMMIT} https://github.com/verilator/verilator.git /tmp/verilator && \
    cd /tmp/verilator && autoconf && ./configure --prefix=/opt/verilator && make -j$(nproc) && make install && \
    \
    git clone --depth 1 --revision ${UVM_VERILATOR_COMMIT} https://github.com/chipsalliance/uvm-verilator.git /opt/uvm-verilator && \
    \
    cd / && rm -rf /tmp/iverilog /tmp/verilator /opt/uvm-verilator/.git

# 4- Python Virtual Environment: Librelane
RUN python3 -m venv /opt/librelane-env && \
    /opt/librelane-env/bin/pip install --no-cache-dir --upgrade pip==${PIP_VERSION} setuptools==${SETUPTOOLS_VERSION} wheel==${WHEEL_VERSION} && \
    /opt/librelane-env/bin/pip install --no-cache-dir librelane==${LIBRELANE_VERSION}

# System Environment Route Configuration
ENV PATH="/opt/iverilog/bin:/opt/verilator/bin:/opt/librelane-env/bin:${PATH}"
ENV UVM_HOME="/opt/uvm-verilator"

WORKDIR /vlsi-development-workspace
CMD ["/bin/bash"]

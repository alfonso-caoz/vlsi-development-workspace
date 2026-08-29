# Project: VLSI Development Workspace

This project is a **monorepo** with different independent **VLSI** subprojects, following an **industry-like workflow**, including an **EDA Environment** for **development** and **testing**.


## Project Management

This is the followed project management process based on **Agile/Scrum Development**, where each subproject is a milestone:

- [Project Management Process: VLSI Development Workspace](https://github.com/users/alfonso-caoz/projects/4)
- [Project Management Notes](./docs/project-management-notes.md)
- [Changelog](CHANGELOG.md)


## Subprojects

- [**Subproject: ASIC Design Pipeline**](/subproject-asic-design-pipeline): `Work In Progress`


## EDA Environment

This project includes an **EDA Environment** (**`eda-env`**) at a **project level**, it is meant to be compatible across all **subprojects**.

This **`eda-env`** has been tested, at this point, from a local/host **Ubuntu 26.04 - Resolute**, but it has been configured to be **multiplatform** considering **Windows** and **Mac**, pending to be tested on.

> [!NOTE]
> The **installation instructions** below are for **GNU/Linux - Ubuntu**, until the **`eda-env`** is tested in other operating systems. Even though, you can follow similarly this process for other operating systems.

### Prerequisites

- [VS Code](https://code.visualstudio.com/download?_exp_download=fb315fc982)
- [Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- Host Docker access to local resources (e.g. monitor to be used by **`eda-env`** tools). Run terminal command:
    ```bash
    xhost +local:docker
    ```

### Implementation

Clone this repository locally:

```bash
git clone https://github.com/alfonso-caoz/vlsi-development-workspace.git
```

There are two different ways to run this environment, **A** and **B**:

#### A. VS Code + Dev Container (Recommended)

- Open **VS Code**
- Click on: `File` / `Open Folder` / `vlsi-development-workspace` (this cloned repository)
- Install from the popped up VS Code extension recommendations: [Dev Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) and [Container Tools](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers)
- Click on the popped up message `Reopen in Container`, or press `Ctrl` + `Shift` + `P` and select `Dev Container: Reopen in Container`.
- Wait for the container to build and run (10 - 15 minutes just the first time building the image)
- Environment ready to use when you see at the lower left corner a blue bar: **`Dev Container: EDA Development Environment`**.
- Close VS Code to close the container.
- Reopen VS Code to resume your work in the container (seconds, because the image is already built).

#### B. Terminal (Optional)

- Open a terminal and go to the cloned repository folder:
    ```bash
    cd vlsi-development-workspace
    ```
- Build the image and run the container (10 - 15 minutes just the first time building the image):
    ```bash
    docker compose -f .devcontainer/compose.yaml run eda-env-compose
    ```
- Environment ready to use when you see the **`eda-env`** terminal:
    ```bash
    root@eda-env:/vlsi-development-workspace#
    ```
- Stop the container with the command (**`eda-env`** terminal):
    ```bash
    exit
    ```
- Re-run the container (seconds, because the image is already built):
    ```bash
    docker compose -f .devcontainer/compose.yaml run eda-env-compose
    ```

> [!WARNING]
> The **local cloned** repository folder **`vlsi-development-workspace`** is **mounted** in the **`eda-env`** container folder **`root@eda-env:/vlsi-development-workspace#`** at a runtime, these local files will appear in the container. **These two spaces are bidirectional**, allowing you to modify files from one path to another. But, **if you keep your work outside these two paths**, **you can lose it when the container is deleted**.

### Environment Tools

#### System Tools

These are the **pinned System Tools** inside the **`eda-env`** at this moment to maintain **replicability**.

<p id="table-note-1"><sub>* Main EDA Tools.</sub></p>

<div align="center">

| System Tool | Repository | Pinned Version | Installation Way | Description |
| ---  | --- | --- | --- | --- |
| [<sup>*</sup>](#table-note-1) [Ubuntu 26.04 - Resolute](https://hub.docker.com/_/ubuntu/tags?name=26.04) | [Docker Hub](https://hub.docker.com/_/ubuntu) | [`resolute-20260811.1`](https://hub.docker.com/layers/library/ubuntu/resolute-20260811.1/images/sha256:2260313b31c8c011cd2eebe728008efac1b3982be73eb71348ea2648d2c0e09b) | Docker Image | Operating System |
| <ul><li>[ca-certificates](https://packages.ubuntu.com/resolute/ca-certificates)</li><li>[curl](https://packages.ubuntu.com/resolute/curl)</li></ul> | <ul><li>[Debian Salsa](https://salsa.debian.org/debian/ca-certificates)</li><li>[Debian Salsa](https://salsa.debian.org/debian/curl)</li></ul> | `latest` every new build | APT: Latest | Web Address Tools |
| [Docker CLI](https://docs.docker.com/engine/) | [Docker Hub](https://hub.docker.com/search?badges=official) | `5:29.7.2-1~ubuntu.26.04~resolute` | APT: Docker Repository | Docker Command Line Interface |
| [APT Package](https://ubuntu.com/server/docs/how-to/software/snapshot-service/) | [Ubuntu Packages](https://packages.ubuntu.com/) | `20260825T000000Z` | APT Snapshot | Ubuntu APT Packages Pinned to a Snapshot |
| [nano](https://packages.ubuntu.com/resolute/nano) | [Debian Salsa](https://salsa.debian.org/debian/nano) | `20260825T000000Z` | APT Snapshot | Terminal Text Editor |
| <ul><li>[git](https://packages.ubuntu.com/resolute/git)</li><li>[openssh-client](https://packages.ubuntu.com/resolute/openssh-client)</li></ul> | <ul><li>[Debian Salsa](https://salsa.debian.org/jrnieder/git)</li><li>[Debian Salsa](https://salsa.debian.org/ssh-team/openssh)</li></ul> | `20260825T000000Z` | APT Snapshot | Git and SSH Tools |
| <ul><li>[autoconf](https://packages.ubuntu.com/resolute/autoconf)</li><li>[bison](https://packages.ubuntu.com/resolute/bison)</li><li>[flex](https://packages.ubuntu.com/resolute/flex)</li><li>[libfl-dev](https://packages.ubuntu.com/resolute/libfl-dev)</li><li>[perl-doc](https://packages.ubuntu.com/resolute/perl-doc)</li><li>[help2man](https://packages.ubuntu.com/resolute/help2man)</li><li>[ccache](https://packages.ubuntu.com/resolute/ccache)</li><li>[gperf](https://packages.ubuntu.com/resolute/gperf)</li><li>[libreadline-dev](https://packages.ubuntu.com/resolute/libreadline-dev)</li></ul> | <ul><li>[Debian Salsa](https://salsa.debian.org/debian/autoconf)</li><li>[Launchpad](https://code.launchpad.net/ubuntu/+source/bison)</li><li>[Debian Salsa](https://salsa.debian.org/srivasta/flex)</li><li>[Debian Salsa](https://salsa.debian.org/srivasta/flex)</li><li>[Debian Salsa](https://salsa.debian.org/perl-team/interpreter/perl)</li><li>[Debian Salsa](https://salsa.debian.org/bod/help2man)</li><li>[Debian Salsa](https://salsa.debian.org/debian/ccache)</li><li>[Debian Salsa](https://salsa.debian.org/debian/gperf)</li><li>[Launchpad](https://code.launchpad.net/ubuntu/+source/readline)</li></ul> | `20260825T000000Z` | APT Snapshot | Build and Runtime Dependencies |
| <ul><li>[build-essential](https://packages.ubuntu.com/resolute/build-essential)</li><li>[cmake](https://packages.ubuntu.com/resolute/cmake)</li><li>[gdb](https://packages.ubuntu.com/resolute/gdb)</li></ul> | <ul><li>[Launchpad](https://code.launchpad.net/ubuntu/+source/build-essential)</li><li>[Debian Salsa](https://salsa.debian.org/cmake-team/cmake)</li><li>[Debian Salsa](https://salsa.debian.org/gdb-team/gdb)</li></ul> | `20260825T000000Z` | APT Snapshot | C/C++ Development Tools |
| <ul><li>[python3](https://packages.ubuntu.com/resolute/python3)</li><li>[python3-venv](https://packages.ubuntu.com/resolute/python3-venv)</li><li>[python3-tk](https://packages.ubuntu.com/resolute/python3-tk)</li><li>[python3-dev](https://packages.ubuntu.com/resolute/python3-dev)</li></ul> | [Debian Salsa](https://salsa.debian.org/cpython-team/python3-defaults) | `20260825T000000Z` | APT Snapshot | Python Development Tools |
| [python3-pip](https://packages.ubuntu.com/resolute/python3-pip) | [Debian Salsa](https://salsa.debian.org/python-team/packages/python-pip) | `20260825T000000Z` | APT Snapshot | PyPI Installer Tool |
| [libcanberra-gtk3-module](https://packages.ubuntu.com/resolute/libcanberra-gtk3-module) | [Debian Salsa](https://salsa.debian.org/gnome-team/libcanberra/tree/ubuntu/latest) | `20260825T000000Z` | APT Snapshot | GTK Wave Dependency |
| [<sup>*</sup>](#table-note-1) [GTK Wave](https://packages.ubuntu.com/resolute/gtkwave) | [Debian Salsa](https://salsa.debian.org/electronics-team/gtkwave) | `20260825T000000Z` | APT Snapshot | Waveform Viewer |
| [<sup>*</sup>](#table-note-1) [Icarus Verilog](https://steveicarus.github.io/iverilog/) | [GitHub](https://github.com/steveicarus/iverilog.git)| `stable 13.0`: [dfeee90](https://github.com/steveicarus/iverilog/commit/dfeee909ed9f20b4870dd93423156c0170c0e1ff) | Source Code | Verilog Compilation System |
| [<sup>*</sup>](#table-note-1) [Verilator](https://verilator.org/guide/latest/) | [GitHub](https://github.com/verilator/verilator.git) | `v5.050`: [848d926](https://github.com/verilator/verilator/commit/848d926ebd4addacacd294dc84e35d9d4ae8078c) | Source Code | Verilog and SystemVerilog Compilation System |
| [<sup>*</sup>](#table-note-1) [UVM Verilator](https://github.com/chipsalliance/uvm-verilator/blob/master/README.md) | [GitHub](https://github.com/chipsalliance/uvm-verilator.git) | `uvm-2020-3.2`: [1eab10a](https://github.com/chipsalliance/uvm-verilator/commit/1eab10a7995c7846dcad7305b995ddb265880433) | Source Code | SystemVerilog UVM Library, Verilator Compatible |
| [<sup>*</sup>](#table-note-1) *Constrained Randomization*  <ul><li>[z3](https://packages.ubuntu.com/resolute/z3)</li><li>[libz3-dev](https://packages.ubuntu.com/resolute/libz3-dev)</li></ul> | [Debian Salsa](https://salsa.debian.org/pkg-llvm-team/z3) | `20260825T000000Z` | APT Snapshot | Constrained Randomization Libraries, Verilator Compatible |
| [pip](https://pip.pypa.io/en/stable/) | [GitHub](https://github.com/pypa/pip) | [`26.2.1`](https://pypi.org/project/pip/26.2.1/) | PyPI | LibreLane Dependency |
| [setuptools](https://setuptools.pypa.io/en/latest/) | [GitHub](https://github.com/pypa/setuptools) | [`84.0.0`](https://pypi.org/project/setuptools/84.0.0/) | PyPI | LibreLane Dependency |
| [wheel](https://wheel.readthedocs.io/en/stable/) | [GitHub](https://github.com/pypa/wheel) | [`0.48.0`](https://pypi.org/project/wheel/0.48.0/) | PyPI | LibreLane Dependency |
| [<sup>*</sup>](#table-note-1) [LibreLane](https://librelane.readthedocs.io/en/stable/) | [GitHub](https://github.com/librelane/librelane) | [`3.0.11`](https://pypi.org/project/librelane/3.0.11/) | PyPI | RTL-to-GDSII Tool, successor to [OpenLane](https://github.com/The-OpenROAD-Project/openlane) |

</div>

#### VS Code Extensions

These are the **pinned VS Code Extensions** inside the **`eda-env`** at this moment. **Installing extensions outside of this list is blocked** within the **`eda-env`** configuration to maintain **replicability** and ensure **security**.

<div align="center">

| VS Code Extension | Pinned Version | Description |
| ---  | --- | --- |
| [Verilog-HDL/SystemVerilog](https://marketplace.visualstudio.com/items?itemName=mshr-h.VerilogHDL) | `1.29.0` | Hardware Description Languages Support |
| <ul><li>[C/C++](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)</li><li>[C/C++ Themes](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-themes)</li><li>[C/C++ DevTools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpp-devtools)</li><li>[CMake Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)</li><li>[Makefile Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools)</li><li>[Native Debug](https://marketplace.visualstudio.com/items?itemName=webfreak.debug)</li><li>[debug-tracker-vscode](https://marketplace.visualstudio.com/items?itemName=mcu-debug.debug-tracker-vscode)</li></ul> | <ul><li>`1.33.8`</li><li>`2.0.0`</li><li>`0.6.18`</li><li>`1.23.52`</li><li>`0.12.17`</li><li>`0.27.0`</li><li>`0.0.15`</li></ul> | C/C++ Development Support |
| <ul><li>[Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)</li><li>[Pylance](https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance)</li></ul> | <ul><li>`2026.4.0`</li><li>`2026.3.1`</li></ul> | Python Development Support |
| <ul><li>[Markdown Preview Github Styling](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-preview-github-styles)</li><li>[Markdown Emoji](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-emoji)</li><li>[Markdown Checkboxes](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-checkbox)</li><li>[Markdown Footnotes](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-footnotes)</li><li>[Markdown Preview for Github Alerts](https://marketplace.visualstudio.com/items?itemName=yahyabatulu.vscode-markdown-alert)</li></ul> | <ul><li>`2.2.0`</li><li>`0.3.1`</li><li>`0.4.0`</li><li>`0.1.1`</li><li>`0.0.4`</li></ul> | Documentation Development Support |
| [Code Spell Checker](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker) | `4.5.6` | Code and Documentation Spell Checking |

</div>

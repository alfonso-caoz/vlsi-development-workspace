# Project: VLSI Development Workspace

This project is a **monorepo** with different independent **VLSI** subprojects, following an **industry-like workflow**, including an **EDA Environment** for **development** and **testing**.


## Project Management

This is the followed project management process based on **Agile/Scrum Development**, where each subproject is a milestone:

- [Project Management Process: VLSI Development Workspace](https://github.com/users/alfonso-caoz/projects/4)
- [Project Management Notes](./docs/project-management-notes.md)
- [Changelog](CHANGELOG.md)


## Subprojects

- [**Subproject: AES-128 Hardware Accelerator**](/subproject-aes-128-hardware-accelerator): `Ongoing`


## EDA Environment

This project includes an **EDA Environment** (**`eda-env`**) at a **project level**, it is meant to be compatible across all **subprojects**.

### Environment Tools

- [System Tools](./docs/eda-environment-tools.md#system-tools)
- [VS Code Extensions](./docs/eda-environment-tools.md#vs-code-extensions)

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
- Environment ready to use when you see a blue bar at the bottom-left corner: **`Dev Container: EDA Development Environment`**.
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

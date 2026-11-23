Project: VLSI Development Workspace
===================================

.. image:: https://img.shields.io/badge/eda--env%3A%20GNU%2FLinux-Ready-green
   :alt: Static Badge
.. image:: https://img.shields.io/badge/subproject--aes128--axi--accelerator-Under%20Development-red
   :alt: Static Badge
.. image:: https://img.shields.io/badge/Docs-Under%20Development-red
   :alt: Static Badge

This project is a **monorepo** with different independent **VLSI** subprojects, following an **industry-like workflow**, including an **EDA Environment** for **development** and **testing**.

- `Project GitHub Repository <https://github.com/alfonso-caoz/vlsi-development-workspace/tree/main>`_

Project Management
------------------

This is the followed project management process based on **Agile/Scrum Development**, where each :ref:`subproject <subprojects>` is a milestone:

- `Project Management Process: VLSI Development Workspace <https://github.com/users/alfonso-caoz/projects/4>`_
- `Project Management Notes <https://github.com/alfonso-caoz/vlsi-development-workspace/blob/main/docs/project-management-notes.md>`_
- `Changelog <https://github.com/alfonso-caoz/vlsi-development-workspace/blob/main/CHANGELOG.md>`_


EDA Environment
---------------

This project includes an **EDA Environment** ( ``eda-env`` ) at a **project level**, it is meant to be compatible across all **subprojects**.

Environment Tools
^^^^^^^^^^^^^^^^^

- `System Tools <https://github.com/alfonso-caoz/vlsi-development-workspace/blob/main/docs/eda-environment-tools.md#system-tools>`_
- `VS Code Extensions <https://github.com/alfonso-caoz/vlsi-development-workspace/blob/main/docs/eda-environment-tools.md#vs-code-extensions>`_

This ``eda-env`` has been tested, at this point, from a local/host **Ubuntu 26.04 - Resolute**, but it has been configured to be **multiplatform** considering **Windows** and **Mac**, pending to be tested on.

.. note::
    The **installation instructions** below are for **GNU/Linux - Ubuntu**, until the ``eda-env`` is tested in other operating systems. Even though, you can follow similarly this process for other operating systems.

Prerequisites
^^^^^^^^^^^^^

- `VS Code <https://code.visualstudio.com/download?_exp_download=fb315fc982>`_
- `Docker Engine on Ubuntu <https://docs.docker.com/engine/install/ubuntu/>`_
- Host Docker access to local resources (e.g. monitor to be used by ``eda-env`` tools). Run terminal command:
    .. code-block:: bash
        
        xhost +local:docker

Implementation
^^^^^^^^^^^^^^

Clone this repository locally:

.. code-block:: bash
    
    git clone https://github.com/alfonso-caoz/vlsi-development-workspace.git


Linux Host User Read/Write/Execute Permission From ``eda-env``
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

New files and folders created from the Docker root of ``eda-env`` cannot be accessed from the Linux Host user (**Linux Hosts Only**). Follow next steps to fix this:

- Open a terminal and go to the cloned repository folder:
    .. code-block:: bash
        
        cd vlsi-development-workspace


- Grant your Linux Host user full access to every future file/folder created by ``eda-env`` (Docker root inherits rwx for ``$USER``):
    .. code-block:: bash
        
        setfacl -R -d -m u:$USER:rwx .

Build And Run The ``eda-env``
"""""""""""""""""""""""""""""

There are two different ways to build and run this environment, **A** and **B**:

A. VS Code + Dev Container (Recommended)
++++++++++++++++++++++++++++++++++++++++

- Open **VS Code**
- Click on: `File` / `Open Folder` / `vlsi-development-workspace` (this cloned repository)
- Install from the popped up VS Code extension recommendations: `Dev Containers <https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers>`_ and `Container Tools <https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-containers>`_
- Click on the popped up message `Reopen in Container`, or press `Ctrl` + `Shift` + `P` and select `Dev Container: Reopen in Container`.
- Wait for the container to build and run (10 - 15 minutes just the first time building the image)
- Environment ready to use when you see a blue bar at the bottom-left corner: ``Dev Container: EDA Development Environment`` .
- Close VS Code to close the container.
- Reopen VS Code to resume your work in the container (seconds, because the image is already built).

B. Terminal (Optional)
++++++++++++++++++++++

- Open a terminal and go to the cloned repository folder:
    .. code-block:: bash
        
        cd vlsi-development-workspace

- Build the image and run the container (10 - 15 minutes just the first time building the image):
    .. code-block:: bash
    
        docker compose -f .devcontainer/compose.yaml run eda-env-compose

- Environment ready to use when you see the ``eda-env`` terminal:
    .. code-block:: bash
        
        root@eda-env:/vlsi-development-workspace#

- Stop the container with the command ( ``eda-env`` terminal):
    .. code-block:: bash
        
        exit

- Re-run the container (seconds, because the image is already built):
    .. code-block:: bash

        docker compose -f .devcontainer/compose.yaml run eda-env-compose

.. warning::
    The **local cloned** repository folder ``vlsi-development-workspace`` is **mounted** in the ``eda-env`` container folder ``root@eda-env:/vlsi-development-workspace#`` at a runtime, these local files will appear in the container. **These two spaces are bidirectional**, allowing you to modify files from one path to another. But, **if you keep your work outside these two paths**, **you can lose it when the container is deleted**.

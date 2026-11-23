#!/usr/bin/env bash

# Script to build Sphinx-Needs documentation within a venv at a subproject root.


# Catching and exiting script execution on error. https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425?permalink_comment_id=3799230
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: Return the exit status of the last command in the pipeline that failed.
# -x: Print commands and their arguments as they are executed. It could be useful for debugging purposes.
set -euo pipefail


# Variables - Paths relative to this script's location

# Project vlsi-development-workspace root directory
PROJECT_DOCS_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
PROJECT_ROOT_DIR="$(dirname "${PROJECT_DOCS_DIR}")"

# subproject-aes128-axi-accelerator root directory
SUBPROJECT_AES_DOCS_DIR="${PROJECT_ROOT_DIR}/subproject-aes128-axi-accelerator/docs"
SUBPROJECT_AES_ROOT_DIR="${SUBPROJECT_AES_DOCS_DIR}/.."

# Python virtual environment directory
VENV_DIR="${PROJECT_ROOT_DIR}/.venv"

# Project and subprojects documentation SOURCE directories
PROJECT_DOCS_SOURCE_DIR="${PROJECT_DOCS_DIR}/source"
SUBPROJECT_AES_DOCS_SOURCE_DIR="${SUBPROJECT_AES_DOCS_DIR}/source"

# Project and subprojects HTML documentation BUILD directories
PROJECT_DOCS_BUILD_HTML_DIR="${PROJECT_DOCS_DIR}/html"
SUBPROJECT_AES_BUILD_HTML_DIR="${PROJECT_DOCS_BUILD_HTML_DIR}/subproject-aes128-axi-accelerator"

GLOBAL_DOCS_REQ_FILE="${PROJECT_DOCS_DIR}/requirements.txt"


# Create the virtual environment if it does not exist yet
if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating virtual environment at ${VENV_DIR}..."
    python3 -m venv "${VENV_DIR}"
fi

# Activate the virtual environment
source "${VENV_DIR}/bin/activate"


# Install or update documentation dependencies
echo "Installing documentation dependencies..."
pip --version
pip install --quiet -r "${GLOBAL_DOCS_REQ_FILE}"


# Build HTML documentation (add -W to fail on broken links or Sphinx-Needs warnings)
echo "Building Sphinx-Needs documentation..."

# Fix missing locale data in minimal Linux Docker containers
export LC_ALL=C.UTF-8

# -W flag is used to treat warnings as errors, which is useful for CI/CD pipelines. It will cause the build to fail if there are any warnings
# -E (no cached environment) -a (all files) flags are used to force a clean rebuild of all files, which is useful when modifying conf.py or custom CSS
# -b X specifies the output format as X (e.g., HTML, PDF, others)

# Build the subproject-aes128-axi-accelerator documentation - Separately to keep the subproject documentation configuration isolated and organized (e.g., Needs, System Requirements, conf.py, etc.)
sphinx-build -W -E -a -b html "${SUBPROJECT_AES_DOCS_SOURCE_DIR}" "${SUBPROJECT_AES_BUILD_HTML_DIR}"

# Build the project vlsi-development-workspace documentation
sphinx-build -W -E -a -b html "${PROJECT_DOCS_SOURCE_DIR}" "${PROJECT_DOCS_BUILD_HTML_DIR}"

# Create a .nojekyll file in the build directory to prevent GitHub Pages from ignoring files and directories that start with an underscore (_), which is common in Sphinx documentation (e.g., _static, _templates, etc.)
touch "${PROJECT_DOCS_DIR}/.nojekyll"

echo "Build complete! Documentation available at: ${PROJECT_DOCS_BUILD_HTML_DIR}/index.html"

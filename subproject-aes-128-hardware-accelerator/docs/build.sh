#!/usr/bin/env bash

# Script to build Sphinx-Needs documentation within a venv at a subproject root.


# Catching and exiting script execution on error. https://gist.github.com/mohanpedala/1e2ff5661761d3abd0385e8223e16425?permalink_comment_id=3799230
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -o pipefail: Return the exit status of the last command in the pipeline that failed.
# -x: Print commands and their arguments as they are executed. It could be useful for debugging purposes.
set -euo pipefail


# Variables - Paths relative to this script's location
DOCS_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
SUBPROJECT_ROOT_DIR="$(dirname "${DOCS_DIR}")"

VENV_DIR="${SUBPROJECT_ROOT_DIR}/.venv"
DOCS_SOURCE_DIR="${DOCS_DIR}/source"
DOCS_BUILD_HTML_DIR="${DOCS_DIR}/_build/html"
DOCS_REQ_FILE="${DOCS_DIR}/requirements.txt"


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
pip install --quiet -r "${DOCS_REQ_FILE}"


# Build HTML documentation (add -W to fail on broken links or Sphinx-Needs warnings)
echo "Building Sphinx-Needs documentation..."

# Fix missing locale data in minimal Linux Docker containers
export LC_ALL=C.UTF-8

# -W flag is used to treat warnings as errors, which is useful for CI/CD pipelines. It will cause the build to fail if there are any warnings
# -E (no cached environment) -a (all files) flags are used to force a clean rebuild of all files, which is useful when modifying conf.py or custom CSS
# -b X specifies the output format as X (e.g., HTML, PDF, others)
sphinx-build -W -E -a -b html "${DOCS_SOURCE_DIR}" "${DOCS_BUILD_HTML_DIR}"

echo "Build complete! Documentation available at: ${DOCS_BUILD_HTML_DIR}/index.html"

#!/bin/bash
# Setup script for the wss virtual environment.
# requirements.txt is public packages only. A machine pip.conf pointed at
# CodeArtifact must not be used — those credentials are not valid for PyPI.
set -euo pipefail

cd "$(dirname "$0")"

PYPI_INDEX="https://pypi.org/simple"

# Create virtual environment if it doesn't exist
if [ ! -d "wss-venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv wss-venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
# shellcheck disable=SC1091
source wss-venv/bin/activate

# --isolated ignores user/env pip config (including a CodeArtifact index-url).
echo "Installing dependencies from PyPI..."
pip install --isolated --index-url "$PYPI_INDEX" --upgrade pip
pip install --isolated --index-url "$PYPI_INDEX" -r requirements.txt

echo "Setup complete! To activate the virtual environment, run:"
echo "  source wss-venv/bin/activate"
echo ""
echo "Then run the service with:"
echo "  python dev_ws_service.py"

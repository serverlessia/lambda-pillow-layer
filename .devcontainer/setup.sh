#!/bin/bash
set -e

echo "Setting up Pillow Lambda Layer Builder environment..."

# Update package lists
apt-get update

# Install software-properties-common for adding PPAs
apt-get install -y software-properties-common

# Add deadsnakes PPA for multiple Python versions
add-apt-repository ppa:deadsnakes/ppa -y

# Update package lists again
apt-get update

# Install all Python versions and their development packages
echo "Installing Python versions..."
apt-get install -y \
    python3.9 python3.9-dev python3.9-distutils \
    python3.10 python3.10-dev python3.10-distutils \
    python3.11 python3.11-dev python3.11-distutils \
    python3.12 python3.12-dev \
    python3.13 python3.13-dev

# Install pip and ensure it's available for all Python versions
echo "Setting up pip for all Python versions..."
apt-get install -y python3-pip python3.9-venv python3.10-venv python3.11-venv python3.12-venv python3.13-venv
python3 -m pip install --upgrade pip

# Install pip for each Python version using get-pip.py
echo "Installing pip for each Python version..."
curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.9 get-pip.py --ignore-installed --break-system-packages
python3.10 get-pip.py --ignore-installed --break-system-packages
python3.11 get-pip.py --ignore-installed --break-system-packages
python3.12 get-pip.py --ignore-installed --break-system-packages
python3.13 get-pip.py --ignore-installed --break-system-packages
rm get-pip.py

# Make scripts executable
chmod +x aws-lambda-pillow-layer/scripts/*.sh

echo "Environment setup complete!"

#!/bin/bash

# This script installs the latest version of Python on Debian-based Linux systems.
# It performs the following steps:
# 1. Updates the package lists.
# 2. Installs software-properties-common if not already installed.
# 3. Adds the deadsnakes PPA for accessing newer Python versions.
# 4. Installs the specified version of Python.
# 5. Verifies the installation by checking the Python version.

# Function to update package lists
# It uses 'apt update' to refresh the list of available packages.
update_packages() {
    sudo apt update || { echo "Failed to update package lists"; exit 1; }
}

# Function to install software-properties-common
# This package is required to manage the repositories (PPAs) more easily.
install_software_properties() {
    sudo apt install -y software-properties-common || { echo "Failed to install software-properties-common"; exit 1; }
}

# Function to add the deadsnakes PPA
# The deadsnakes PPA provides newer versions of Python not available in default repositories.
add_deadsnakes_ppa() {
    sudo add-apt-repository ppa:deadsnakes/ppa -y || { echo "Failed to add deadsnakes PPA"; exit 1; }
}

# Function to install Python
# It installs the specified version of Python using 'apt install'.
# The version number is passed as an argument to this function.
install_python() {
    local version=$1
    sudo apt install -y python${version} || { echo "Failed to install Python ${version}"; exit 1; }
}

# Function to verify Python installation
# This function checks if Python is installed correctly by calling 'python --version'.
# The version number is passed as an argument to this function.
verify_python() {
    local version=$1
    python${version} --version || { echo "Failed to verify Python ${version}"; exit 1; }
}

# Main script execution
# This function orchestrates the entire installation process by calling the above functions.
main() {
    local python_version="3.10"  # Specify the desired Python version here.

    echo "Updating package lists..."
    update_packages

    echo "Installing software-properties-common..."
    install_software_properties

    echo "Adding deadsnakes PPA..."
    add_deadsnakes_ppa

    echo "Updating package lists again..."
    update_packages

    echo "Installing Python ${python_version}..."
    install_python ${python_version}

    echo "Verifying Python ${python_version} installation..."
    verify_python ${python_version}

    echo "Python ${python_version} installation completed successfully."
}

# Run the main script
main

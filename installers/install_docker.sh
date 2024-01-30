#!/bin/bash

# This script installs the latest version of Docker on a Debian-based Linux distribution.
# It follows these steps:
# 1. Removes any old versions of Docker.
# 2. Installs required packages for Docker installation.
# 3. Adds Docker's official GPG key.
# 4. Sets up the Docker repository.
# 5. Installs the latest version of Docker Engine and containerd.
# 6. Verifies the Docker installation.

# install_packages: Installs packages necessary for Docker installation.
# Uses apt-get to install required packages like apt-transport-https, ca-certificates, etc.
install_packages() {
    sudo apt-get update
    sudo apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release
}

# add_gpg_key: Adds Dockerâs official GPG key to the system.
# This is required to ensure the authenticity of Docker packages.
add_gpg_key() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
}

# setup_repository: Sets up the stable Docker repository.
# Adds the Docker repository to apt sources to enable installation of Docker from this repository.
setup_repository() {
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
}

# install_docker: Installs the latest version of Docker Engine and containerd.
# Uses apt-get to install Docker packages.
install_docker() {
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}

# verify_installation: Verifies the Docker installation by running a test image.
# Executes a simple Docker command to ensure Docker is installed and working correctly.
verify_installation() {
    sudo docker run hello-world
}

# main: Main function to orchestrate Docker installation steps.
# Calls each function in order and includes error handling to exit if any step fails.
main() {
    # Remove any old versions of Docker
    sudo apt-get remove -y docker docker-engine docker.io containerd runc

    # Install required packages
    if ! install_packages; then
        echo "Failed to install required packages."
        exit 1
    fi

    # Add GPG key
    if ! add_gpg_key; then
        echo "Failed to add Docker GPG key."
        exit 1
    fi

    # Set up repository
    if ! setup_repository; then
        echo "Failed to set up Docker repository."
        exit 1
    fi

    # Install Docker
    if ! install_docker; then
        echo "Failed to install Docker."
        exit 1
    fi

    # Verify installation
    if ! verify_installation; then
        echo "Docker installation verification failed."
        exit 1
    fi

    echo "Docker installed successfully."
}

main

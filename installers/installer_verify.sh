#!/bin/bash

# This script installs Python, Docker, and Zsh using separate shell scripts.
# It includes modular functions for each installation with error handling.

# Function to install Python
# It runs the install_python.sh script and checks if it succeeds.
install_python() {
    echo "Installing Python..."
    if ./install_python.sh; then
        echo "Python installed successfully."
    else
        # If Python installation fails, print an error message and exit the script.
        echo "Error installing Python."
        exit 1
    fi
}

# Function to install Docker
# It runs the install_docker.sh script and checks if it succeeds.
install_docker() {
    echo "Installing Docker..."
    if ./install_docker.sh; then
        echo "Docker installed successfully."
    else
        # If Docker installation fails, print an error message and exit the script.
        echo "Error installing Docker."
        exit 1
    fi
}

# Function to install Zsh
# It runs the install_zsh.sh script and checks if it succeeds.
install_zsh() {
    echo "Installing Zsh..."
    if ./install_zsh.sh; then
        echo "Zsh installed successfully."
    else
        # If Zsh installation fails, print an error message and exit the script.
        echo "Error installing Zsh."
        exit 1
    fi
}

# Main script execution
# Calls the installation functions in sequence.
# If any installation fails, the script will terminate during that function call.
install_python
install_docker
install_zsh

# If all installations succeed, print a completion message.
echo "All installations complete!"


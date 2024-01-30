#!/bin/bash

# This script installs the latest version of Zsh and Oh My Zsh on a Debian-based Linux system.
# It includes functions for each major task and error handling to ensure each step completes successfully.
# The script requires internet access and sudo privileges.

# Function to update and upgrade the system
update_system() {
    # Update the package list and upgrade all existing packages to their latest versions.
    # If the update or upgrade fails, the script exits with an error message.
    echo "Updating and upgrading the system..."
    sudo apt-get update && sudo apt-get upgrade -y
    if [ $? -ne 0 ]; then
        echo "Failed to update and upgrade the system. Exiting."
        exit 1
    fi
}

# Function to install Zsh
install_zsh() {
    # Install the Zsh shell.
    # If the installation fails, the script exits with an error message.
    echo "Installing Zsh..."
    sudo apt-get install -y zsh
    if [ $? -ne 0 ]; then
        echo "Failed to install Zsh. Exiting."
        exit 1
    fi
}

# Function to set Zsh as the default shell
set_default_shell() {
    # Change the default shell for the user to Zsh.
    # If the shell change fails, the script exits with an error message.
    echo "Setting Zsh as the default shell..."
    chsh -s $(which zsh)
    if [ $? -ne 0 ]; then
        echo "Failed to set Zsh as the default shell. Exiting."
        exit 1
    fi
}

# Function to install Oh My Zsh
install_oh_my_zsh() {
    # Install Oh My Zsh, a framework for managing Zsh configuration.
    # If the installation fails, the script exits with an error message.
    echo "Installing Oh My Zsh..."
    sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
    if [ $? -ne 0 ]; then
        echo "Failed to install Oh My Zsh. Exiting."
        exit 1
    fi
}

# Main script execution
main() {
    # Execute the functions in order to perform the installation.
    # The script will inform the user upon completion.
    update_system
    install_zsh
    set_default_shell
    install_oh_my_zsh
    echo "Installation complete. Please restart your shell or system."
}

# Call the main function to start the script
main




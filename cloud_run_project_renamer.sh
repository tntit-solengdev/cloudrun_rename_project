#!/bin/bash

# Copyright 2025 - Tag N Trak It - Australia
#
# This script is released under AGPL v3.0.0. You can find the full license at https://www.gnu.org/licenses/agpl-3.0.en.html
# Crafted with care by TNTIT-Shamir
# Tag N Trak It
# 19/03/25
#
# Tag N Trak It is not responsible for any damages or losses caused by the use of this script.
# Please use it responsibly and ensure you have done the necessary due diligence before running it.
#
# Contact our devs at solengdev@tagntrakit.com or enquiries@tagntrakit.com, we will be more than happy to provide our support and services.
# Visit us at https://www.tagntrakit.com
#
# This script renames directories and updates Python file references for Django projects using template from Cloud Run.
# It renames 'helloproject' to a specified project name and 'helloapp' to a specified app name.
# In addition, it checks for python3 and required dependencies and creates a virtual environment.

set -e

# Load variables, these may come from the terminal when the script is launched.
PROJECT_NAME=${PROJECT_NAME:-'your_project_name'}
APP_NAME=${APP_NAME:-'your_app_name'}


# Function to prompt for project and app names.
prompt_for_names() {
    echo ""
    echo "Copyright 2025 - Tag N Trak It - Australia"
    echo "By: TNTIT-Shamir"
    echo "Contact: solengdev@tagntrakit.com"
    echo "Web: https://www.tagntrakit.com"
    read -p "Enter the project name (default: your_project_name): " input_project
    PROJECT_NAME=${input_project:-your_project_name}
    read -p "Enter the app name (default: your_app_name): " input_app
    APP_NAME=${input_app:-your_app_name}
}

# Function to rename directories.
rename_directories() {
    # Rename the 'helloproject' directory.
    if [ -d "helloproject" ]; then
        echo "Renaming 'helloproject' to '${PROJECT_NAME}'..."
        mv helloproject "$PROJECT_NAME"
    else
        echo "Directory 'helloproject' not found. Skipping renaming of project folder."
    fi

    # Rename the 'helloapp' directory.
    if [ -d "helloapp" ]; then
        echo "Renaming 'helloapp' to '${APP_NAME}'..."
        mv helloapp "$APP_NAME"
    else
        echo "Directory 'helloapp' not found. Skipping renaming of app folder."
    fi
}

# Function to update Python file references in a given directory.
update_references_in_directory() {
    local dir="$1"
    local old_name="$2"
    local new_name="$3"
    if [ -d "$dir" ]; then
        echo "Updating Python files in '${dir}' folder..."
        find "$dir" -type f -name "*.py" -exec sed -i "s/${old_name}/${new_name}/g" {} +
    else
        echo "Directory '${dir}' not found. Skipping update for ${new_name}."
    fi
}

# Function to update manage.py file.
update_manage_py() {
    if [ -f "manage.py" ]; then
        echo "Updating 'manage.py' file..."
        sed -i "s/helloproject/${PROJECT_NAME}/g" manage.py
        sed -i "s/helloapp/${APP_NAME}/g" manage.py
    else
        echo "'manage.py' file not found. Skipping update."
    fi
}

# Function to check python3 and install dependencies if required.
check_python_and_install_deps() {
    echo "Checking for python3..."
    if ! command -v python3 >/dev/null 2>&1; then
        echo "python3 is not installed. Please install python3 and try again."
        exit 1
    fi

    echo "Checking for python3-dev package..."
    if ! dpkg -s python3-dev >/dev/null 2>&1; then
        echo "python3-dev package is not installed. Attempting to install..."
        if command -v sudo >/dev/null 2>&1; then
            sudo apt-get update && sudo apt-get install -y python3-dev
        else
            echo "sudo command not found. Please install python3-dev manually."
            exit 1
        fi
    else
        echo "python3-dev is already installed."
    fi
}

# Function to create virtual environment.
create_virtual_environment() {
    VENV_DIR="venv"
    if [ -d "${VENV_DIR}" ]; then
        echo "Virtual environment directory '${VENV_DIR}' already exists. Skipping creation."
    else
        echo "Creating virtual environment in '${VENV_DIR}'..."
        python3 -m venv "${VENV_DIR}"
        echo "Virtual environment created successfully."
    fi
}

# Function to display the options menu.
display_menu() {
    echo ""
    echo "Select the operation you want to perform:"
    echo "1) Rename directories"
    echo "2) Update Python references in directories (project and app)"
    echo "3) Update manage.py file"
    echo "4) Check python environment and install dependencies"
    echo "5) Create virtual environment"
    echo "6) Run all operations"
    echo "0) Exit"
    echo ""
    read -p "Enter your choice (0-6): " menu_choice
}

# Main function handling user choices.
main() {
    prompt_for_names

    display_menu

    case "$menu_choice" in
        1)
            echo "Option 1 selected: Renaming directories."
            rename_directories
            ;;
        2)
            echo "Option 2 selected: Updating Python references in directories."
            update_references_in_directory "${PROJECT_NAME}" "helloproject" "${PROJECT_NAME}"
            update_references_in_directory "${APP_NAME}" "helloapp" "${APP_NAME}"
            ;;
        3)
            echo "Option 3 selected: Updating manage.py file."
            update_manage_py
            ;;
        4)
            echo "Option 4 selected: Checking Python environment and dependencies."
            check_python_and_install_deps
            ;;
        5)
            echo "Option 5 selected: Creating virtual environment."
            create_virtual_environment
            ;;
        6)
            echo "Option 6 selected: Running all operations."
            rename_directories
            update_references_in_directory "${PROJECT_NAME}" "helloproject" "${PROJECT_NAME}"
            update_references_in_directory "${APP_NAME}" "helloapp" "${APP_NAME}"
            update_manage_py
            check_python_and_install_deps
            create_virtual_environment
            ;;
        0)
            echo "Exiting as per user request."
            exit 0
            ;;
        *)
            echo "Invalid option. Exiting."
            exit 1
            ;;
    esac

    echo "Selected operation(s) have been executed successfully."
}

# Execute main to start the script.
main

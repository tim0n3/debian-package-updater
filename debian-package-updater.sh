#!/bin/bash

LOG_DIR="/var/log/debian-package-updater"
STDOUT_LOG="$LOG_DIR/stdout.log"
STDERR_LOG="$LOG_DIR/stderr.log"
FORCE_INSTALL=false

# Function to log messages to stdout and a file
log_message() {
    local message="$1"
    echo "$message"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" >> "$STDOUT_LOG"
}

# Function to log error messages to stderr and a file
log_error() {
    local error_message="$1"
    echo "$error_message" >&2
    echo "$(date +'%Y-%m-%d %H:%M:%S') - ERROR: $error_message" >> "$STDERR_LOG"
    exit 1
}

# Function to check if apt requires a force install (-f)
check_force_install() {
    local apt_output
    apt_output=$(apt-get -s upgrade 2>&1)
    if echo "$apt_output" | grep -q 'E: Unmet dependencies'; then
        log_message "Unmet dependencies detected, attempting to fix..."
        if [ "$FORCE_INSTALL" = true ]; then
            apt-get -y -f install || log_error "Failed to fix unmet dependencies with force install."
        else
            log_error "Unmet dependencies detected. Use -f option to force install."
        fi
    fi
}

# Function to check for updates and install them
check_and_install_updates() {
    log_message "Checking for updates..."
    if ! apt-get update; then
        log_error "Failed to update package lists."
    fi

    check_force_install

    log_message "Upgrading packages..."
    if ! apt-get -y upgrade; then
        log_error "Failed to upgrade packages."
    fi
}

# Main function
main() {
    # Parse command line options
    while getopts ":f" opt; do
        case $opt in
            f)
                FORCE_INSTALL=true
                ;;
            \?)
                log_error "Invalid option: -$OPTARG"
                ;;
        esac
    done

    # Create log directory if it doesn't exist
    mkdir -p "$LOG_DIR"

    log_message "Script started."

    check_and_install_updates

    log_message "Script completed."
}

# Call the main function
main "$@"

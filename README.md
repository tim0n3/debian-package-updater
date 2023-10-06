# debian-package-updater

This Bash script is designed to automate the process of checking for updates and upgrading packages on a Debian-based Linux system. It provides options for handling unmet dependencies and forcing installations when necessary.

## Usage

To use this script, follow the instructions below:

1. **Download the Script**: Download the Bash script to your Linux system.

2. **Make the Script Executable**: Before running the script, ensure it has execution permission. You can use the `chmod` command to grant execute permission:
   ```
   chmod +x debian-package-updater.sh
   ```

3. **Run the Script**: You can run the script without any options to check for updates and upgrade packages normally. Use the following command:
   ```
   ./debian-package-updater.sh
   ```

4. **Force Install Unmet Dependencies**: If the script detects unmet dependencies during the upgrade process, you can use the `-f` option to force the installation of packages with unresolved dependencies. Example:
   ```
   ./debian-package-updater.sh -f
   ```

## Configuration

You can customize the script's behavior by modifying the following variables at the beginning of the script:

- `LOG_DIR`: Specifies the directory where log files will be stored. By default, it's set to "/var/log/debian-package-updater".

- `STDOUT_LOG`: Defines the path to the standard output log file.

- `STDERR_LOG`: Defines the path to the standard error log file.

- `FORCE_INSTALL`: Controls whether to force install packages with unmet dependencies (default is `false`).

## Logging

The script logs both standard output and standard error messages to separate log files. You can find the log files in the directory specified by `LOG_DIR`. The log files are named `stdout.log` and `stderr.log`.

## Functions

The script includes several functions to perform specific tasks:

- `log_message()`: Logs messages to both standard output and a file.

- `log_error()`: Logs error messages to both standard error and a file and exits with a status code of 1.

- `check_force_install()`: Checks for unmet dependencies and attempts to fix them if the `-f` option is used.

- `check_and_install_updates()`: Checks for updates, upgrades packages, and calls `check_force_install()`.

- `main()`: The main function parses command line options, creates the log directory if it doesn't exist, and calls `check_and_install_updates()`.

## Dependencies

This script relies on the `apt-get` command, which is commonly available on Debian-based Linux distributions. Ensure that your system has the necessary package management tools installed.

## Notes

- It's recommended to run this script with superuser privileges (e.g., using `sudo`) to ensure proper access to system files and package management.

- Be cautious when using the `-f` option, as it may lead to unexpected behavior if used indiscriminately. It is primarily intended to resolve unmet dependency issues.

- This script is designed for Debian-based Linux distributions. It may not work correctly on other Linux distributions with different package managers.

## License

This script is provided under the [MIT License](LICENSE.md). Feel free to modify and distribute it as needed, but use it at your own risk.

## Donations

If you want to show your appreciation, you can donate via [PayPal](https://www.paypal.com/donate?hosted_button_id=ULMMXE4DLQVZS) . Thanks!
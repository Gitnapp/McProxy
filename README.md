# McProxy Script

## Overview
The `mcproxy.sh` script is a simple shell script designed to manage HTTP and HTTPS proxy settings. It provides an interactive menu for users to set temporary or permanent proxy settings, clear existing proxy settings, or exit the script.

## Features
- **Temporary Proxy**: Set a temporary proxy for the current session.
- **Permanent Proxy**: Set a permanent proxy in your shell configuration file.
- **Custom Proxy**: Set custom proxy addresses for both temporary and permanent settings.
- **Clear Proxy**: Remove all proxy settings.

## Usage
### Prerequisites
- A Unix-like system (Linux, macOS) with a shell environment (e.g., Bash, Zsh).
- Basic knowledge of shell commands.

### Installation
1. Clone the repository or download the `mcproxy.sh` script.
2. Make the script executable:
   ```sh
   chmod +x mcproxy.sh

### Menu Options
- Set Temporary Proxy: Set a temporary proxy using the default address (127.0.0.1:1082).
- Set Permanent Proxy: Set a permanent proxy in your shell configuration file (~/.bashrc by default).
- Set Custom Temporary Proxy: Set a custom temporary proxy address.
- Set Custom Permanent Proxy: Set a custom permanent proxy address.
- Clear Proxy Settings: Remove all proxy settings.
- Exit: Quit the script.

## License
This project is open-source and available under the MIT License.
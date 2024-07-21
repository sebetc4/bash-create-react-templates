# cts: Create TSX and SCSS Module

This script helps you automate the creation of `.tsx` and `.module.scss` files in the current directory or a specified directory.

## Features

-   Creates `.tsx` and `.module.scss` files in a single command.
-   Allows you to specify a directory where the files should be created.
-   Ensures the directory name starts with an uppercase letter.
-   Customizable templates for file creation.
-   Verbose mode for detailed messages.

## Usage

```bash
./cts.sh [-d <directory>] [-v]

Options:
  -d, --directory <directory>  Specify the directory where the files should be created.
  -v, --verbose                Enable verbose mode.
  -h, --help                   Show this help message and exit.
```

## Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/yourusername/bash-create-react-templates.git
    cd bash-create-react-templates
    ```

2. **Make the script executable:**

    ```bash
    chmod +x cts.sh
    ```

3. **Move the script to a directory in your `PATH`:**

    To make the script executable from anywhere, move it to a directory that is included in your `PATH`. For example:

    ```bash
    mv cts.sh ~/bin/cts
    ```

4. **Add this directory to your `PATH` (if necessary):**

    If `~/bin` is not already in your `PATH`, add it by including the following line in your shell configuration file (`~/.bashrc`, `~/.bash_profile`, `~/.zshrc`, etc.):

    ```bash
    export PATH="$HOME/bin:$PATH"
    ```

5. **Reload your shell configuration file:**

    After modifying your shell configuration file, reload it with the following command:

    ```bash
    source ~/.bashrc  # or ~/.bash_profile, ~/.zshrc, depending on your shell
    ```

6. **Verify the installation:**

    Open a new terminal and try running the script by its name:

    ```bash
    cts
    ```

    If the script runs correctly, you have successfully made it accessible from anywhere on your system.

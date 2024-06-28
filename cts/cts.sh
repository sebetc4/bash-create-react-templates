#!/bin/bash

# Function to display usage information
usage() {
    cat <<EOF
This script creates .tsx and .module.scss files in the current directory or in a specified directory.
Usage: $0 [-d <directory>]
Options:
    -d, --directory <directory>  Specify the directory in which to create the files. If not specified, files will be created in the current directory.
    -h, --help                   Display this help message.
EOF
    exit 1
}

# Function to create a directory if specified
create_directory() {
  if [ "$directory_name" != "$(basename "$PWD")" ]; then
    mkdir -p "$target_dir"
  fi
}

# Function to check if a file already exists
check_file_exists() {
  if [ -f "$1" ]; then
    echo "Error: The file $1 already exists."
    exit 1
  fi
}

# Function to create a file from a template
create_file_from_template() {
  local template_file=$1
  local output_file=$2
  local content=$(<"$template_file")
  local processed_content="${content//\{\{directory_name\}\}/$directory_name}"
  echo "$processed_content" > "$output_file"
}

# Function to validate if a file was created successfully
validate_file_creation() {
  if [ ! -f "$1" ]; then
    echo "Error: Failed to create $1."
    exit 1
  fi
}

# Parse command line options
parse_options() {
  directory_name=$(basename "$PWD")
  target_dir="$PWD"

  while [[ "$#" -gt 0 ]]; do
    case $1 in
      -d|--directory)
        if [ -z "$2" ]; then
          usage
        fi
        directory_name="$2"
        target_dir="$PWD/$directory_name"
        shift
        ;;
      -h|--help)
        usage
        ;;
      *)
        echo "Unknown option: $1"
        usage
        ;;
    esac
    shift
  done
}

# Main function to orchestrate file creation
main() {
  parse_options "$@"
  create_directory

  tsx_filepath="${target_dir}/${directory_name}.tsx"
  scss_filepath="${target_dir}/${directory_name}.module.scss"

  check_file_exists "$tsx_filepath"
  check_file_exists "$scss_filepath"

  create_file_from_template "$(dirname "$0")/template.tsx" "$tsx_filepath"
  validate_file_creation "$tsx_filepath"

  create_file_from_template "$(dirname "$0")/template.module.scss" "$scss_filepath"
  validate_file_creation "$scss_filepath"

  echo "Success: The files $tsx_filepath and $scss_filepath have been created successfully."
}

main "$@"

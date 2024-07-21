#!/bin/bash

usage() {
    cat <<EOF
This script creates .tsx and .module.scss files in the current directory or in a specified directory.
Usage: $0 [-d <directory>] [-v]
Options:
    -d, --directory <directory>  Specify the directory in which to create the files. If not specified, files will be created in the current directory.
    -v, --verbose                Display detailed messages.
    -h, --help                   Display this help message.
EOF
    exit 1
}

create_directory() {
  if [ "$directory_name" != "$(basename "$PWD")" ]; then
    mkdir -p "$target_dir"
  fi
}

check_file_exists() {
  if [ -f "$1" ]; then
    echo "Error: The file $1 already exists."
    exit 1
  fi
}

create_file_from_template() {
  local template_file=$1
  local output_file=$2
  local content=$(<"$template_file")
  local processed_content="${content//\{\{directory_name\}\}/$directory_name}"
  processed_content="${processed_content//\{\{directory_name_lower\}\}/$directory_name_lower}"
  echo "$processed_content" > "$output_file"
}

validate_file_creation() {
  if [ ! -f "$1" ]; then
    echo "Error: Failed to create $1."
    exit 1
  fi
}

check_directory_name() {
  if ! [[ "$directory_name" =~ ^[A-Z] ]]; then
    echo "Error: The directory name '$directory_name' must start with an uppercase letter."
    exit 1
  fi
}

convert_first_letter_to_lower() {
  directory_name_lower="$(echo "$directory_name" | sed 's/^\(.\)/\L\1/')"
}

parse_options() {
  directory_name=$(basename "$PWD")
  target_dir="$PWD"
  verbose_mode=false

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
      -v|--verbose)
        verbose_mode=true
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
  
  check_directory_name
  convert_first_letter_to_lower
}

main() {
  parse_options "$@"
  create_directory

  tsx_filepath="${target_dir}/${directory_name}.tsx"
  scss_filepath="${target_dir}/${directory_name}.module.scss"

  check_file_exists "$tsx_filepath"
  check_file_exists "$scss_filepath"

  create_file_from_template "$(dirname "$0")/templates/template.tsx" "$tsx_filepath"
  validate_file_creation "$tsx_filepath"

  create_file_from_template "$(dirname "$0")/templates/template.module.scss" "$scss_filepath"
  validate_file_creation "$scss_filepath"

  [ "$verbose_mode" = true ] && echo "Success: The files $tsx_filepath and $scss_filepath have been created successfully."
}

main "$@"

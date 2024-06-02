#!/bin/bash

# Get the name of the current directory
directory_name=$(basename "$PWD")

# Add the .tsx extension
tsx_filepath="${directory_name}.tsx"
scss_filepath="${directory_name}.module.scss"

# Check if the .tsx file already exists
if [ -f "$tsx_filepath" ]; then
  echo "The file $tsx_filepath already exists."
  exit 1
fi

# Check if the .module.scss file already exists
if [ -f "$scss_filepath" ]; then
  echo "The file $scss_filepath already exists."
  exit 1
fi

# Create the .tsx file with a basic React component template
cat <<EOL > "$tsx_filepath"
// Styles
import styles from './${directory_name}.module.scss'
// Libs
import { FC } from 'react'
// App

interface ${directory_name}Props {}

const ${directory_name}: FC<${directory_name}Props> = ({}) => {
  return (
    <div className={styles.container}>
        ${directory_name}
    </div>
  )
}

export default ${directory_name};
EOL

# Create the .module.scss file with a basic template
cat <<EOL > "$scss_filepath"
.container {

}
EOL

# Display a confirmation message
echo "The files $tsx_filepath and $scss_filepath have been created successfully."
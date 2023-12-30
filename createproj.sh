#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <project_path>"
    exit 1
fi

# Retrieve the project name and project path from the arguments
project_name=$1
project_path=$2

# Create the project directory (or skip if it already exists)
mkdir -p "$project_path/$project_name"

# Change into the project directory
cd "$project_path/$project_name" || exit

# URLs of .gitignore files on GitHub
gitignore_jetbrains_url="https://raw.githubusercontent.com/github/gitignore/main/Global/JetBrains.gitignore"
gitignore_vscode_url="https://raw.githubusercontent.com/github/gitignore/main/Global/VisualStudioCode.gitignore"
gitignore_c_url="https://raw.githubusercontent.com/github/gitignore/main/C.gitignore"
gitignore_cpp_url="https://raw.githubusercontent.com/github/gitignore/main/C%2B%2B.gitignore"
gitignore_haskell_url="https://raw.githubusercontent.com/github/gitignore/main/Haskell.gitignore"

# Downloading the .gitignore files
curl -o JetBrains.gitignore "$gitignore_jetbrains_url"
curl -o VisualStudioCode.gitignore "$gitignore_vscode_url"
curl -o C.gitignore "$gitignore_c_url"
curl -o C++.gitignore "$gitignore_cpp_url"
curl -o Haskell.gitignore "$gitignore_haskell_url"

cat JetBrains.gitignore VisualStudioCode.gitignore C.gitignore C++.gitignore Haskell.gitignore > .gitignore

rm JetBrains.gitignore VisualStudioCode.gitignore C.gitignore C++.gitignore Haskell.gitignore

# Remove duplicate lines from .gitignore and save the result to a temporary file
awk '!seen[$0]++' .gitignore > temp_gitignore

# Replace the original .gitignore with the cleaned version
mv temp_gitignore .gitignore

# Copy another script from an existing folder on your PC
curl -o run.sh "https://raw.githubusercontent.com/GuillaumeMichel10/EpitechProjectInit/main/run.sh"

# Add files to the Git repository
# to Add

echo "Project created successfully in the directory $project_path/$project_name."

#!/bin/bash

# Check if the number of arguments is correct
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <project_name> <project_path>"
    exit 1
fi

# Retrieve the project name and project path from the arguments
project_name=$1
project_path=$2

# Check if the directory already exists
if [ -d "$project_path/$project_name" ]; then
    echo "The directory $project_name already exists at path $project_path."
    exit 1
fi

# Create the project directory
mkdir -p "$project_path/$project_name"

# Change into the project directory
cd "$project_path/$project_name" || exit

# URLs des fichiers .gitignore sur GitHub
gitignore_jetbrains_url="https://raw.githubusercontent.com/github/gitignore/4488915eec0b3a45b5c63ead28f286819c0917de/Global/JetBrains.gitignore"
gitignore_vscode_url="https://raw.githubusercontent.com/github/gitignore/4488915eec0b3a45b5c63ead28f286819c0917de/Global/VisualStudioCode.gitignore"
gitignore_c_url="https://raw.githubusercontent.com/github/gitignore/4488915eec0b3a45b5c63ead28f286819c0917de/C.gitignore"
gitignore_cpp_url="https://raw.githubusercontent.com/github/gitignore/4488915eec0b3a45b5c63ead28f286819c0917de/C%2B%2B.gitignore"
gitignore_haskell_url="https://raw.githubusercontent.com/github/gitignore/4488915eec0b3a45b5c63ead28f286819c0917de/Haskell.gitignore"

# Téléchargement des fichiers .gitignore
curl -o JetBrains.gitignore "$gitignore_jetbrains_url"
curl -o VisualStudioCode.gitignore "$gitignore_vscode_url"
curl -o C.gitignore "$gitignore_c_url"
curl -o C++.gitignore "$gitignore_cpp_url"
curl -o Haskell.gitignore "$gitignore_haskell_url"

cat JetBrains.gitignore VisualStudioCode.gitignore C.gitignore C++.gitignore Haskell.gitignore > .gitignore

rm JetBrains.gitignore VisualStudioCode.gitignore C.gitignore C++.gitignore Haskell.gitignore

awk '!seen[$0]++' .gitignore > temp_gitignore
mv temp_gitignore .gitignore

# Copy another script from an existing folder on your PC
curl -o run.sh "https://raw.githubusercontent.com/GuillaumeMichel10/EpitechProjectInit/f010ff0ed3cb10dadf0879b695a15eaa905d6a23/run.sh"

# Add files to the Git repository
# to Add

echo "Project created successfully in the directory $project_path/$project_name."

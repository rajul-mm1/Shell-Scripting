Scenario: You have a folder with mixed file types (e.g., .txt, .jpg, .sh).
Write a Bash script that:
 - Organizes files into directories based on their extensions.
 - If a directory for an extension doesn't exist, create it.
 - Move the files into their respective directories.       

 #!/bin/bash

# Loop through all files in the current directory
for file in *; do
    # Skip if it's a directory
    if [ -d "$file" ]; then                       --> -d checks for the presence of directory, if the variable file has the name of the directory then it will skip the current iteration and move on to next one
        continue
    fi

    # Extract extension (after the last .)
    extension="${file##*.}"                      --> ## is known as greedy match. It removes the longest match from start till the last dot (.) and gives only the extension as result. If you want to extract filename as the result then use %% for longest match.

    # Define folder name (e.g., "txtfiles", "jpgfiles")
    folder="${extension}files"         

    # Create the folder if it doesn't exist
    mkdir -p "$folder"                          --> -p is an option that does 2 things - Create parent directories as needed and no error is generated if the directory already exists.

    # Move the file to the appropriate folder
    mv "$file" "$folder/"                      --> mv is the move command that will move the files from source to destination. So the source is $file and destination is $folder/
done

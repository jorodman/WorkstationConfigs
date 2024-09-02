#!/bin/bash

# Function to list files based on the provided command
list_files() {
  case "$1" in
    restore-staged)
      FILES=($(git diff --cached --name-only))
      ;;
    restore-tracked)
      FILES=($(git diff --name-only))
      ;;
    add-tracked|add-untracked)
      FILES=($(git ls-files --modified --deleted --others --exclude-standard))
      ;;
    *)
      echo "Invalid option. Use 'restore-staged', 'restore-tracked', 'add-tracked', or 'add-untracked'."
      exit 1
      ;;
  esac

  # Check if the print-files flag is set
  if [ "$PRINT_FILES" = true ]; then
    # Display the list of files with their indices
    echo "Files to choose from:"
    for i in "${!FILES[@]}"; do
      echo "$((i+1)). ${FILES[i]}"
    done
  fi
}

# Check if the user provided enough arguments
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <restore-staged|restore-tracked|add-tracked|add-untracked> <range|search-text> [--print-files]"
  exit 1
fi

# Assign arguments to variables
COMMAND=$1
INPUT=$2
PRINT_FILES=false

# Check if the third argument is --print-files
if [ "$3" == "--print-files" ]; then
  PRINT_FILES=true
fi

# Call the list_files function with the command argument
list_files $COMMAND

# Determine if the input is a range or text
if [[ $INPUT =~ ^[0-9]+(-[0-9]+)?$ ]]; then
  # Process input as a range
  if [[ $INPUT =~ ^[0-9]+$ ]]; then
    START=$INPUT
    END=$INPUT
  else
    START=$(echo $INPUT | cut -d'-' -f1)
    END=$(echo $INPUT | cut -d'-' -f2)
  fi

  # Validate range input
  if ! [[ $START =~ ^[0-9]+$ && $END =~ ^[0-9]+$ && $START -le $END ]]; then
    echo "Invalid range. Please provide a valid range, e.g., '1-5' or a single number '3'."
    exit 1
  fi

  # Determine the Git command to run
  case "$COMMAND" in
    restore-staged)
      GIT_COMMAND="git restore --staged"
      ;;
    restore-tracked)
      GIT_COMMAND="git restore"
      ;;
    add-tracked|add-untracked)
      GIT_COMMAND="git add"
      ;;
    *)
      echo "Invalid command. Use 'restore-staged', 'restore-tracked', 'add-tracked', or 'add-untracked'."
      exit 1
      ;;
  esac

  # Process the files in the specified range
  for ((i=START-1; i<=END-1; i++)); do
    if [ $i -lt ${#FILES[@]} ]; then
      $GIT_COMMAND "${FILES[i]}"
      echo "Executed: $GIT_COMMAND ${FILES[i]}"
    fi
  done

else
  # Process input as text search
  SEARCH_TEXT=$INPUT

  # Determine the Git command to run
  case "$COMMAND" in
    restore-staged)
      GIT_COMMAND="git restore --staged"
      ;;
    restore-tracked)
      GIT_COMMAND="git restore"
      ;;
    add-tracked|add-untracked)
      GIT_COMMAND="git add"
      ;;
    *)
      echo "Invalid command. Use 'restore-staged', 'restore-tracked', 'add-tracked', or 'add-untracked'."
      exit 1
      ;;
  esac

  # Find and process files matching the search text
  for FILE in "${FILES[@]}"; do
    if [[ "$FILE" == *"$SEARCH_TEXT"* ]]; then
      $GIT_COMMAND "$FILE"
      echo "Executed: $GIT_COMMAND $FILE"
    fi
  done
fi

# Run git status to display the result
git status

echo "Operation completed."


#! /usr/bin/env bash

# Function to display usage
usage() {
    echo "Usage: $0 [--without] <search_string>"
    echo "  Exit 0 if string is found, exit 1 if not found"
    echo "  Pass --without to exit 1 if string is found, exit 0 if not found"
    exit 2
}

# Initialize variables
search_string=""
exit_not_found=1
exit_found=0

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --without)
            exit_not_found=0
            exit_found=1
            shift
            ;;
        -*)
            echo "Error: Unknown option $1"
            usage
            ;;
        *)
            if [[ -n "$search_string" ]]; then
                echo "Error: Multiple search strings provided"
                usage
            fi
            search_string="$1"
            shift
            ;;
    esac
done

if [[ -z "$search_string" ]]; then
    echo "Error: Must provide a search string"
    usage
fi

# Perform the search and get count
exit $([[ $(git grep "$search_string" | wc -l) -eq 0 ]] && echo $exit_not_found || echo $exit_found)

#!/bin/bash

# This script generates a random password for each user specified on the command line

# Display what the user typed on the command line
echo "You executed this command: ${0}"

# Display the path and filename of the script
echo "You used $(dirname "${0}") as the path to the $(basename "${0}") file"

# Tell the user how many arguments they passed in
NUMBER_OF_PARAMETERS="${#}"
echo "You passed in ${NUMBER_OF_PARAMETERS} arguments"

# Make sure the number of argguments is greater than 0
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]; then
    echo "Usage: ${0} USER_NAME USER_NAME"
    exit
fi

for USER_NAME in "$@"; do
    PASSWORD=$(echo "${RANDOM}" | sha1sum | head -c 10)
    echo "${USER_NAME} :  ${PASSWORD}"
done

#!/bin/bash

# GOALS
# Display the uid and username of the user executing the file
# Display if the user is the vagrant user or not

USER_ID=$(id -u)
USER_NAME=$(id -un)

# echo "Your user ID is ${USER_ID} and your username is ${USER_NAME}"

if [[ $USER_NAME = 'vagrant' ]]; then
    echo 'You are the vagrant user'
    echo "Your userid ${USER_ID}"
else
    echo 'You are NOT the vagrant user'
    exit 1
fi

exit 0

# S? gives the exit status of the last command

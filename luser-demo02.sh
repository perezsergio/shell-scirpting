#!/bin/bash

# GOALS
# Display the uid and username of the user executing the file
# Display if the user is the root user or not

USER_ID=$(id -u)
USER_NAME=$(id -un)

echo "Your user ID is ${USER_ID} and your username is ${USER_NAME}"

if [[ $UID == 0 ]]; then
    echo 'You are the root user'
else
    echo 'You are NOT the root user'
fi

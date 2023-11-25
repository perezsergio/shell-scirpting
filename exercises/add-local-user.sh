#!/bin/bash

# This script can only be executed by the superuser
if [[ "${UID}" -ne 0 ]]; then
    echo 'Authentification failure: This script can only be executed with superuser (root) privileges'
    exit 1
fi

# Create user and set initial password bia prompts
read -r -p 'Enter the username: ' USERNAME
USERNAME_LENGTH="${#USERNAME}"

while [ "${USERNAME_LENGTH}" -gt 8 ] || [ -n "${USERNAME//[_[:digit:][:lower:]]/}" ]; do
    echo 'username must be shorter than 8 characters and it can only contain lowercase letters and digits'
    read -r -p 'Enter the username: ' USERNAME
done

read -r -p 'Person who will be using the account (commment): ' REALNAME
read -s -r -p 'Enter the inital password (you will be asked to change it after the first login): ' INITIAL_PASSWORD
echo ''

if ! useradd --create-home --comment "${REALNAME}" "${USERNAME}"; then
    echo "Unable to add user ${USERNAME}"
    exit 1
fi
if ! echo "${INITIAL_PASSWORD}" | passwd --stdin -e "${USERNAME}"; then
    echo "Unable to set initial password"
    exit 1
fi
HOST_NAME=$(hostname)
echo 'Success! Added user and set intial password'
echo ''
echo 'Info'
echo "- username: ${USERNAME}"
echo "- password: ${PASSWORD}"
echo "- host: ${HOST_NAME}"
echo ''
exit 0

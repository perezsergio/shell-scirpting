#!/bin/bash

# This script can only be executed by the superuser
if [[ "${UID}" -ne 0 ]]; then
    echo 'Authentification failure: This script can only be executed with superuser (root) privileges' >&2
    exit 1
fi

NUMBER_OF_PARAMETERS="${#}"

# If the user didn´t pass any arguments, exit and print a helper usage message
if [[ $NUMBER_OF_PARAMETERS = 0 ]]; then
    echo "Error: the user did not pass any arguments" >&2
    echo "Usage: $0 USERNAME [COMMENT] ...  " >&2
    exit 1
fi

# Parameters: USERNAME [COMMENT] ...
USERNAME=$1
USERNAME_LENGTH="${#USERNAME}"
shift 1 # This assigns *=[COMMENT] ... [COMMENT]
COMMENT=$*

# If the username isn't valid exit and print a helper message
if [ "${USERNAME_LENGTH}" -gt 8 ] || [ -n "${USERNAME//[_[:digit:][:lower:]]/}" ]; then
    echo 'Error: invalid username' >&2
    echo 'Username must be shorter than 8 characters and it can only contain lowercase letters and digits' >&2
    exit 1
fi

# Add new user with the name [USERNAME].
if ! useradd --create-home --comment "${COMMENT}" "${USERNAME}" &>/dev/null; then
    echo "Unable to add user ${USERNAME}" >&2
    exit 1
fi

# Randomly generate password

# Set the password as the inital password for the new user
if
    ! PASSWORD=$(echo "${RANDOM}${RANDOM}" | sha1sum | head -c12)
    ! echo "${PASSWORD}" | passwd --stdin "${USERNAME}" &>/dev/null
    ! passwd -e "${USERNAME}" &>/dev/null
then #-e doesnot work for some reason
    echo "Unable to set initial password" >&2
    exit 1
fi

# Force the user to change the password on first login

# Print th relevant info about the new user
HOST_NAME=$(hostname)

echo
echo 'Success! Added user and set intial password'
echo 'The password must be reset after the first login'
echo
echo 'Info'
echo "- username: ${USERNAME}"
echo "- password: ${PASSWORD}"
echo "- comment: ${COMMENT}"
echo "- host: ${HOST_NAME}"
echo
exit 0

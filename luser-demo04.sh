#!/bin/bash

# Create an account on the local system
# You will  be prompted for the account name and password

# CONVENTION: username must be only letters and numbers, less than 8 characcters
# and all lowercase

# Ask for the user name
read -p 'Enter the username: ' USERNAME

# Ask for the real name
read -p 'Enter your real name: ' REALNAME

# Ask for the password
read -s -p 'Enter the password: ' PASSWORD

# Create user
useradd --create-home --comment "${REALNAME}" "${USERNAME}"

# Set password
# Force password change on first login
echo "${PASSWORD}" | passwd --stdin -e "${USERNAME}"

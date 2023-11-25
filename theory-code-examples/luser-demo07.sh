#!/bin/bash

# This script demonstrates I/O redirection

# Redirect STDOUT to a file
FILE="/tmp/data"
head -n1 /etc/passwd >${FILE}
cat "${FILE}"

# Redirect stdin to a variable
read -r LINE <${FILE}
echo "${LINE}"

# ">" Overwrittes the content of the file
head -n3 /etc/passwd >${FILE}
echo
cat "${FILE}"

# ">>" Appends new line
echo "New line" >>${FILE}
echo
cat "${FILE}"

# USING FILE DESCRIPTORS
# Redirect STDOUT to a file
echo
echo
FILE="/tmp/data"
head -n1 /etc/passwd 1>${FILE}
cat "${FILE}"

# Redirect stdin to a variable
read -r LINE 0<${FILE}
echo "${LINE}"

# ">" OVerwrittes the content of the file
head -n3 /etc/passwd 1>${FILE}
echo
cat "${FILE}"

# ">>" Appends new line
echo "New line" 1>>${FILE}
echo
cat "${FILE}"

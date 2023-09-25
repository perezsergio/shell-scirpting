#!/bin/bash

# Show contents of a true file
echo
echo "Lore ipsum..." >./truefile.txt
echo "$ cat ./truefile.txt"
read -r TRUEFILE_CONTENT <./truefile.txt
echo "> ${TRUEFILE_CONTENT}"

# Create file to store stderr
SCRIPT_NAME=$(basename "${0}")
if [[ ! -d ./temp ]]; then # if the directory ./temp doesn't exist, create it
    mkdir ./temp
fi
TEMP_ERR_FILE="./temp/${SCRIPT_NAME}.err"

# show error that is displayed when you try to show the content of a file that
# does not exist
echo
echo "$ cat ./fakefile.txt"
cat /fakefile.txt 2>"${TEMP_ERR_FILE}"
read -r FAKEFILE_ERROR <"${TEMP_ERR_FILE}"
echo "> ${FAKEFILE_ERROR}"

# Example to demonstrate stdout and stderr redirection
echo
echo "$ cat ./truefile.txt ./fakefile.txt 1>./my-command.out 2>./my-command.err"
cat ./truefile.txt ./fakefile.txt 1>./my-command.out 2>./my-command.err

echo
echo "$ cat my-command.out "
read -r OUT <./my-command.out
echo "> ${OUT}"

echo
echo "$ cat my-command.err "
read -r ERR <./my-command.err
echo "> ${ERR}"
echo

# Cleanup
rm "${TEMP_ERR_FILE}" ./my-command.err ./my-command.out ./truefile.txt
exit 0

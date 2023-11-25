#!/bin/bash

# Location of the folder that stores the backups
BACKUP_DIR='/archives'

function echoUsage() {
    echo "Usage: ${0} [-dra] USERNAME [USERNAME] ..." >&2
    echo 'Disables or deletes a user' >&2
    echo '  -d Deletes accounts instead of disabling them' >&2
    echo '  -r Removes home directory associated with the account' >&2
    echo '  -a Creates a backup of the home directory in the /archives directory' >&2
}

function createBackup() {
    # Usage: createBackup [USERNAME]
    local USERNAME="${1}"
    local HOME_DIR="/home/${USERNAME}/"

    # Create /archives directory if it doesn't exist
    if [[ ! -d "${BACKUP_DIR}" ]]; then
        mkdir "${BACKUP_DIR}"
    fi
    # Create the backup
    tar -zcf "${BACKUP_DIR}/${USERNAME}.tar.gz" "${HOME_DIR}" &>'/dev/null'
    echo "Backup created at ${BACKUP_DIR}/${USERNAME}.tar.gz"
}
jz
function isSystemAccount() {
    # Usage: isSystemAccount [USERNAME]
    local USERNAME="${1}"
    local USER_ID
    if ! USER_ID=$(id -u "${USERNAME}" 2>'/dev/null'); then
        echo "Error: user ${USERNAME} does not exist" >&2
        exit 1
    fi

    if [[ "${USER_ID}" -le 1000 ]]; then
        return 0
    fi
    return 1
}

# The script must be run with superuser (root) privileges
if [[ "${UID}" -ne 0 ]]; then
    echo 'Authentification failure: This script can only be executed with superuser (root) privileges' >&2
    exit 1
fi

# Default variable values
DELETE_OR_DISABLE="Disable"
REMOVE_HOME_DIR="False"
CREATE_HOME_DIR_BACKUP="False"

# Parse options
while getopts dra OPTION; do
    case ${OPTION} in
    d)
        DELETE_OR_DISABLE="Delete"
        ;;
    r)
        REMOVE_HOME_DIR="True"
        ;;
    a)
        CREATE_HOME_DIR_BACKUP='True'
        ;;
    *)
        echoUsage
        exit 1
        ;;
    esac
done

# Remove options from arguments
shift $((OPTIND - 1))
# If no USERNAMEs where provided echo the usage statement and exit
if [[ "${#}" == '0' ]]; then
    echoUsage
    exit 1
fi

for USERNAME in "${@}"; do

    HOME_DIR="/home/${USERNAME}/"

    if isSystemAccount "${USERNAME}"; then
        echo 'System accounts (id<1001) cannot be deleted' >&2
        exit 1
    fi

    if [[ "${CREATE_HOME_DIR_BACKUP}" == 'True' ]]; then
        createBackup "${USERNAME}"
    fi

    if [[ "${REMOVE_HOME_DIR}" == 'True' ]]; then
        rm -rf "${HOME_DIR}"
    fi

    if [[ "${DELETE_OR_DISABLE}" == 'Delete' ]]; then
        userdel "${USERNAME}"
    elif [[ "${DELETE_OR_DISABLE}" == 'Disable' ]]; then
        chage -E 0 "${USERNAME}"
    else
        echo "ValueError: DELETE_OR_DISABLE must be either 'Delete' or 'Disable', but it is '${DELETE_OR_DISABLE}'. "
    fi

done

exit 0

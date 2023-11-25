#!/bin/bash

function log() {
    local VERBOSE="${1}"
    shift
    local MESSAGE="${*}"
    if [[ "${VERBOSE}" = 'true' ]]; then
        echo "Logged: ${MESSAGE} in /var/log/messages"
    fi
    logger -t "${0}" "${MESSAGE}"
    # Let the exit code of logger be the exit code of this function
}

function backup_file() {
    local FILE="${1}"

    if [[ -f "${FILE}" ]]; then #Check if file exist
        local BACKUP_FILE
        BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
        if cp -p "${FILE}" "${BACKUP_FILE}"; then
            log 'false' "copied ${FILE} in ${BACKUP_FILE}"
            echo "Success: copied ${FILE} in ${BACKUP_FILE}"
            return 0
        else
            echo "Error: Unable to copy ${FILE} in ${BACKUP_FILE}" >&2
            return 1
        fi
    else
        echo "Error: ${FILE} not found" >&2
        return 1
    fi
}

backup_file './luser-demo21.sh'

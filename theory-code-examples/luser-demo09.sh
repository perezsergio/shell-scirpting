#!/bin/bash

# This cript demonstrates the case statement.

# Not the best way to do this
#if [[ "${1}" = 'start' ]]; then
#    echo 'starting'
#elif [[ "${1}" = 'stop' ]]; then
#    echo 'stopping'
#elif [[ "${1}" = 'status' ]]; then
#    echo 'status'
#else
#    echo 'Supply a valid option' >&2
#    exit 1
#fi

case "${1}" in
start)
    echo 'Starting'
    ;;
stop)
    echo 'Stopping'
    ;;
status | state) # If $1 == 'status' or 'state'
    echo 'Status'
    ;;
*) # else
    echo 'Error: Invalid option' >&2
    exit 1
    ;;
esac

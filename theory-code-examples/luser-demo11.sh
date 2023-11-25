#!/bin/bash

# This script generates a random passwordç

# The user can set the password length with -l and add a special character with -s
# Verbose mode can be enabled with -v

# SET a default password length
LENGTH=12
VERBOSE='false'

# Usage statement
function usage() {
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password'
    echo '  -l LENGTH Specify the password length'
    echo '  -s        Append a special character to the end of the pàssword'
    echo '  -v        Verbose mode'
}

# echo a message if verbose mode is on
function echoWhenVerbose() {
    if [[ "${VERBOSE}" = 'true' ]]; then
        echo "${1}"
    fi
    return 0

}

# "l:" because it must be followed with an argument
while getopts vl:s OPTION; do
    case ${OPTION} in
    v)
        VERBOSE='true'
        echo 'Verbose mode on'
        ;;
    l)
        LENGTH="${OPTARG}"
        ;;
    s)
        USE_SPECIAL_CHARACTER='true'
        ;;
    *)
        usage
        exit 1
        ;;
    esac
done

# Generate a random password
echoWhenVerbose 'Generating a password'
if ! PASSWORD=$(echo "${RANDOM}${RANDOM}" | sha256sum | head -c "${LENGTH}"); then
    echo 'Error: Unable to generate password' >&2
    exit 1
fi

# Append special char if rrequested
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]; then
    echoWhenVerbose 'Selecting a random special character'
    SPECIAL_CHARACTER=$(echo '!@#$%&*()-+=' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

#    echo
#    echo 'Extra arguments: '
#    shift $((OPTIND - 1))
#    INDEX=0
#    for ARG in "${@}"; do
#        echo "Argument ${INDEX}: ${ARG}"
#        ((INDEX++))
#    done
#    echo

shift $((OPTIND - 1))
if [[ "${#}" -gt '0' ]]; then
    usage
    exit 1
fi

echoWhenVerbose 'Done'
echoWhenVerbose 'This is your password'
echo "${PASSWORD}"

exit 0

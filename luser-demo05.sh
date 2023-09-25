#!/bin/bash

# This script generates a list of random passwords
PASSWORD="${RANDOM}"
echo "${PASSWORD}"

PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "${PASSWORD}"

PASSWORD=$(date +%s)
echo "${PASSWORD}"

PASSWORD=$(date +%s%N)
echo "${PASSWORD}"

RANDOM_INT="${RANDOM}${RANDOM}${RANDOM}"
PASSWORD=$(echo "${RANDOM_INT}" | sha1sum | head -c 15)
echo "${PASSWORD}"

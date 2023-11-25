#!/bin/bash

for USER in "${@}"; do
    userdel -r "${USER}"
done

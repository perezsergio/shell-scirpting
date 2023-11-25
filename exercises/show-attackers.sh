#!/bin/bash

file="$1"

# check that the argument is a file that exists
if [[ $file == '' ]]; then
    echo "Usage: $0 FILE" >&2
    exit 1
elif [[ ! -f $file ]]; then
    echo "File $0 does not exist" >&2
    echo "Usage: $0 FILE" >&2
    exit 1
fi

# get the ip counts
ip_counts=$(
    grep 'Failed password' "$file" | # Get the logs of failed login attempts
        awk '{print $(NF - 3)}' |    # Ip is the 3rd last word of each line
        sort -n |                    # For 'uniq' to work you must sort before
        uniq -c |                    # Get list of unique ips with counts
        sort -n -r                   # Sort by counts
)

# echo counts,ips,locations to stdout
echo "count,ip,location"
echo "$ip_counts" | while read -r line; do
    count=$(echo "$line" | cut -d ' ' -f 1)
    ip=$(echo "$line" | cut -d ' ' -f 2)
    country=$(geoiplookup "$ip" | awk '{print $NF}')
    echo "$count,$ip,$country"
done

exit 0

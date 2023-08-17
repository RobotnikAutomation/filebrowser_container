#!/bin/sh

UID=1000
base_dir="/srv"

chown $UID:$UID "$FILE"
dir=$(dirname "$FILE")
# Fix parent directory's ownership until we hit the base_dir or a directory that
# Already belongs to the user
while [ "$dir" != "$base_dir" ] && [ $(stat -c %u "$dir") != $UID ]; do
    chown $UID:$UID "$dir"
    dir=$(dirname "$dir")
done

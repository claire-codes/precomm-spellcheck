#/usr/bin/env bash

for f in `git diff --name-only`
do
    echo "Processing $f"
    if grep -Fq "OK" $f
    then
        echo "You found me"
    else
        echo "Not here"
    fi
done

exit 1
echo "You won't see me"

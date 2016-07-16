#/usr/bin/env bash

typo="OK"
# This lists all the staged files about to committed but ignores the deleted ones
for f in `git diff --name-only --diff-filter=AM --cached`
do
    echo "Processing $f"
    if grep -Fq "$typo" $f # -F means interpret pattern as fixed string and not regex, -q means minimal printing
    then
        echo "You found me"
    else
        echo "Not here"
    fi
done

exit 1
echo "You won't see me"

#/usr/bin/env bash

typo="OK"
typo_exists=false
# This lists all the staged files about to be committed but ignores the deleted ones
for f in `git diff --name-only --diff-filter=AM --cached`
do
    echo "Processing $f"
    if grep -Fq "$typo" $f # -F means interpret pattern as fixed string and not regex, -q means minimal printing
    then
        echo "Typo '$typo' found in $f"
        typo_exists=true
    # else
    #     echo "Not here"
    fi
done

if [ "$typo_exists" = true ]
    exit 1
fi
echo "You won't see me"

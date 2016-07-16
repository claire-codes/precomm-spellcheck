#/usr/bin/env bash

# you can search for multiple words: just split them by escaped pipes: "foo\|bar"
typo="lumberjack"
typo_exists=false

# This lists all the staged files about to be committed but ignores the deleted ones.
# It pipes this list to grep which removes the name of this file from it:
# This file will contain the typo to look for and we therefore don't need to
# fail the commit for it.
for f in `git diff --name-only --diff-filter=AM --cached | grep -v precomm-spellcheck.sh`
do
    if grep -iq "$typo" $f # -q means minimal printing, -i ignore case
    then
        echo "Check $f for a spelling mistake"
        typo_exists=true
    # else
    #     echo "$f is clean"
    fi
done

if [ "$typo_exists" = true ]; then
    exit 1
else
    echo "Checked your files for spelling mistakes and found none"
fi

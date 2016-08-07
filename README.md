# 📎 precomm-spellcheck

## Motivation

Alas I can't seem to type very accurately and often commit code with typos in. 🙊

For example, typing `Magneto` instead of `Magento`: one is an Xmen villain and the other is an e-commerce platform.

What I wanted was a tool that told me that I had a made a spelling mistake before I pushed my code.

I first tried a package for the Atom editor but realised that was a bit OTT and that developing packages for Atom is hard.

I read [this great blog post](http://elijahmanor.com/npm-precommit-scripts/) by Elijah Manor about the `pre-commit` package and was inspired to whip up a shell script that would prevent me committing code that had certain pre-defined typos in it. 

N.B. I'm using an npm package to execute something that _I know_ could be done using Git hooks (see below for how) but:

- I 💜 automating tasks through npm scripts.
- using this method means you've got more visibility over the script and it can be easier to distribute amongst a team, instead of being buried within the gitignored `/git` directory.

## How to use

This repo is a full example of how the script would work in a real repo. If you want to use it in your project, you'll just need to add some lines to your `package.json` and use the shell script.

1. Copy the `precomm-spellcheck.sh` file to your project (don't forget to make it executable with `chmod +x precomm-spellcheck.sh`)

2. Install the `pre-commit` package: run `npm i -S pre-commit` to install it and add it to your project + `package.json`

3. In your `package.json` file add the following properties:

    ```
"scripts": {
  "pre-commit": "./hook.sh",
  "pre-commit-msg": "echo 'Running pre-commit spellcheck'"
},
"pre-commit": ["pre-commit-msg", "pre-commit"],
```

    This will tell the `pre-commit` package to run those particular scripts and that order before committing your code. It also defines the scripts: note the nice informative message to print to the user's console to let them know what's going on.

4. The last thing to do is to set the value of `typo` in the shell script to be the typos you want to avoid. Currently this line is `typo="lumberjack"`. When the script runs it will check the staged files for these words and if it finds any of them it will print out the file where they are found and exit with a status code of 1: this will cause the commit to fail. You can correct the spelling mistakes and commit your code embarrassment free! 😌

5. The script will run every time you run `git commit` or `git commit -m "Some message"`.

## Run as a Git hook instead

Don't like node modules? Don't have a package.json? Just replace the contents of `.git/hooks/pre-commit` with the contents of `precomm-spellcheck.sh`. Remove the `.sample` suffix if this already exists.

## Troubleshooting

* The shell script needs to be executable so don't forget to check it is with a `ls -l` and run `chmod` if necessary.
* If you want to check for more than word, separate them with escaped pipe symbols, like `typo="foo\|bar"`.
* The grep is currently case-insensitive: remove `-i` flag if you want case-sensitive matching.
* It only checks _staged_ files - those green ones you see when you run `git status`. If an already committed file contains a typo it will not be caught: this means that if someone pushes the commit through anyway with `git commit -n` then there's nothing you can do about it.
* Not running? Remove your node_modules and install again: `rm -rf node_modules && npm i && say done`.


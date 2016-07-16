# 📎 precomm-spellcheck

## Motivation

Alas I can't seem to type very accurately and often commit code with typos in. 🙊

For example, typing Magneto instead of Magento. One is an Xmen villan and the other is an ecommerce platform.

What I wanted was for something to tell me that I had a made a spelling mistake before I pushed my code.

I first tried a package for the Atom editor but realised that was a bit OTT and that developing packages for Atom is hard.

I read [this great blog post](http://elijahmanor.com/npm-precommit-scripts/) by Elijah Manor about the `pre-commit` package and was inspired to whip up a shell script that would prevent me committing code that had certain pre-defined typos in it. 

N.B. I 💜 using npm scripts although the script I wrote could also be used as git commit hook too.

## How to use

This repo is a full example of how the script would work in a real repo. If you want to use it in your project, you'll just need to add some lines to your `package.json` and use the shell script.

1. Copy the `precomm-spellcheck.sh` file to your project (don't forget to make it executable with `chmod +x precomm-spellcheck.sh`)

2. Install the `pre-commit` package: run `npm i -S pre-commit` to add it to your project and `package.json`

3. In your `package.json` file add the following properties:

    ```
"scripts": {
  "pre-commit": "./hook.sh",
  "pre-commit-msg": "echo 'Running pre-commit spellcheck'"
},
"pre-commit": ["pre-commit-msg", "pre-commit"],
```

    This will tell the `pre-commit` package to run those particular scripts and in what order before committing your code. It also defines the scripts: we've added a nice informative message to print to the user's console and also defined a script to execute the shell script.

4. The last thing to do is to set the value of `typo` in the shell script to be the typos you want to avoid. When the script runs it will check the staged files for these words and if it finds any of them it will print out the file where they are found and exit with a status code of 1: this will cause the commit to fail. You can correct the spelling mistakes and commit your code embarrassment free! 😌

## Troubleshooting

* If you rename the shell script, also rename it in the shell script itself as it needs to be explicitly excluded from the grep.
* The shell script needs to be executable so don't forget to check it is with a `ls -l`
* If you want to check for more than word, separate them with escaped pipe symbols, like `typo="foo\|bar"`
* The grep is currently case-insensitive: remove `-i` flag if you want case-sensitive matching.
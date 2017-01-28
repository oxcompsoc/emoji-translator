# Emoji translator

The challenge: translate English sentences to mixed emoji and English.

## Resources

The data was originally scraped from [this page][Unicode] (warning: 37MB page)

* `emoji.json` - the original file with each emoji and its keywords listed
* `emojo_ints.json` - same file but with integer codes instead of strings
* `emoji_invert.json` - keyword to code number lookup

## Simple example

If you get stuck, `simple.py` contains a very simple example of how you might
get started with the substitutions. However, there is a lot that could be
improved:

* It doesn't account for punctuation
* It could do something better than randomly picking an emoji
* It doesn't handle replacing multiple words by an emoji
* It doesn't replace segments of a word
* It doesn't do anything with homophones

[Unicode]: http://unicode.org/emoji/charts/full-emoji-list.html

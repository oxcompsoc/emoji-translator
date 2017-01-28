# A really simple example to get started
import json, random
from datetime import datetime

random.seed(datetime.now())

emoji_lookup = json.loads(open("emoji_invert.json", "r").read())

text = input("Enter an English sentence: ")

words = text.split(" ")
newWords = []

for word in words:
    lword = word.lower()
    if lword in emoji_lookup:
        i = random.randint(0, len(emoji_lookup[lword]) - 1)
        newWords.append(chr(emoji_lookup[lword][i]))
    else:
        newWords.append(word)

print(' '.join(newWords))

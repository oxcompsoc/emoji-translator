import json
emojis = json.loads(open("emoji_ints.json", "r").read())

keywords_to_ints = {}

for emoji in emojis:
    for keyword in emoji["keywords"]:
        if keyword in keywords_to_ints:
            keywords_to_ints[keyword].append(emoji['code'])
        else:
            keywords_to_ints[keyword] = [emoji['code']]

print(json.dumps(keywords_to_ints))

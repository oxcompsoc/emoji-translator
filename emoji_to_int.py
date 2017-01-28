import json, re

emojis = json.loads(open("emoji.json", "r").read())
for emoji in emojis:
    emoji['code'] = int(re.search('U\\+([A-F0-9]+)', emoji['code']).group(1), 16)
print(json.dumps(emojis))

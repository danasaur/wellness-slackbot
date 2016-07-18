'''
A quick script to fetch the id of a channel you want to use.

USAGE: python fetchChannelId.py <channel_name>
'''

import requests
import sys
import json
from tokens import Tokens

# Environment variables must be set with your tokens
tokens = Tokens()
USER_TOKEN_STRING = tokens.get_user_token()
URL_TOKEN_STRING = tokens.get_url_token()

HASH = "%23"

channelName = sys.argv[1]

params = {"token": USER_TOKEN_STRING}

# Capture Response as JSON
response = requests.get("https://slack.com/api/channels.list", params=params)
channels = json.loads(response.text, encoding='utf-8')["channels"]

for channel in channels:
    if channel["name"] == channelName:
        print channel["id"]
        break

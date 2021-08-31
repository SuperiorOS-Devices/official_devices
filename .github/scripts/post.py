#!/usr/bin/env python
#
# Python code which automatically sends a Message in a Telegram Group if any new update is found.
# Intended to be run on every push
# USAGE : python post.py
# See README for more.
#
# Copyright (C) 2021 Ashwin DS <astroashwin@outlook.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation;
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

import sys
import datetime
import json
import os
import time
import telebot

# Get secrets from Workflow
BOT_API = os.environ.get("BOT_TOKEN")
CHAT_ID = os.environ.get("CHAT")

STICKER_ID = "CAACAgUAAxkBAAECnFNg-AABFfAWqPOep8GY1VTw4iC9TQsAAiYEAALTXBBXwFGChYjyKZkgBA"

# Init the bot
bot = telebot.TeleBot(BOT_API, parse_mode="HTML")

# Where to look for .json files
fileDir = "."
fileExt = ".json"
gappsDir = "gapps"

# Github releases tag

GithubReleasesTag = time.time()
open("tag.txt","w+").write(str(GithubReleasesTag))

def send_mes(message):
    return bot.send_message(chat_id=CHAT_ID, text=message, disable_web_page_preview=True)


def send_photo(image, caption):
    if not caption or caption == "" or caption is None:
        return bot.send_photo(chat_id=CHAT_ID, photo=open(image, "rb"))
    else:
        return bot.send_photo(chat_id=CHAT_ID, photo=open(image, "rb"), caption=caption)


# store MD5s in a file to compare
def update(IDs):
    with open(".github/scripts/log.txt", "w+") as f:
        for s in IDs:
            f.write(str(s) + "\n")


# Return IDs of all latest files from *.json files
def get_id():
    result = []
    for a in os.listdir(fileDir):
        if a.endswith(fileExt):
            if a != "devices.json":
                result.append(a)

    file_id = []
    for a in result:
        print (a)
        file = open( fileDir + "/" + a, "r")
        json_processed = json.loads(file.read())
        try:
            file_id.append(json_processed['response'][0]['id'])
        except Exception as e:
            print(e)
    return file_id


# Return previous IDs
def read_old():
    old_id = []
    file = open(".github/scripts/log.txt", "r")
    for line in file.readlines():
        old_id.append(line.replace("\n", ""))
    return old_id


# remove elements in 2nd list from 1st, helps to find out what device got an update
def get_diff(new_id, old_id):
    first_set = set(new_id)
    sec_set = set(old_id)
    return list(first_set - sec_set)


# Grab needed info using id of the file
def get_info(id):
    devices = []
    for a in os.listdir(fileDir):
        if a.endswith(fileExt):
            if a != "devices.json":
                devices.append(a)
    for a in devices:
        file = open(fileDir + "/" + a, "r")
        json_processed = json.loads(file.read())
        if json_processed['response'][0]['id'] == id:
            print(json_processed['response'][0])
            required = json_processed['response'][0]
            device = a.replace(".json", "")
            break


    if device + ".json" in os.listdir(fileDir + "/" + gappsDir):
        variant = "Both GApps and Vanilla"
        isOnlyVanilla = False
    else:
        variant = "Vanilla Only"
        isOnlyVanilla = True

    if isOnlyVanilla:
        gapps_url = ""
    else:
        file = open( fileDir + "/" + gappsDir + "/" + device + ".json" , "r")
        gapps_json_processed = json.loads(file.read())
        print(gapps_json_processed['response'][0])
        gapps_required = gapps_json_processed['response'][0]
        gapps_url = gapps_required['url']


    print("Device is : " + device)
    print("Size is : " + str(required['size']))
    print("Maintained by : " + required['maintainer'])
    print("File name : " + required['filename'])
    print("Version : " + required['version'])
    print("Variant : " + variant)

    return {
        "device": device,
        "size": str(required['size']),
        "maintainer": required['maintainer'],
        "variant": variant,
        "version" : required['version'],
        'name' : required["device_name"],
        "time" : required['datetime'],
        "filename" : required['filename'],
        "id" : required['id'],
        "romtype" : required['romtype'],
        "url" : required['url'],
        "isOnlyVanilla": isOnlyVanilla,
        "gapps_url" : gapps_url,
    }


def bold(text1, text2):
    message = "<b>" + text1 + "</b>" + text2
    return message


# Prepare in the format needed
def cook_content(information):
    message = ""
    # links need to be in this format <a href="http://www.example.com/">inline URL</a>
    message = message + \
        "<b>New Update for " + information['name'] +  " (" + str(information['device'] ) + ") is here!</b>\n" + \
        bold("by ", str(information["maintainer"])) + "\n\n" + \
        "▫️ " + bold("Build: ", str(information['filename'])) + "\n" +\
        "▫️ " + bold("Size: ", str(information['size'])) + "\n" + \
        "▫️ " + bold("Variant: ", str(information["variant"])) + "\n" + \
        "▫️ " + bold("Date: ", str(datetime.date.today()).replace("-", "/")) + "\n" + \
        "▫️ " + bold("SHA256: ", str(information['id'])) + "\n" + \
        "▫️ " + bold("Download: ", "<a href=\"https://sourceforge.net/projects/superioros/files/" + str(information['device']) + "\">Sourceforge</a>" + " | " + "<a href=\"https://github.com/geek0609/official_devices/releases/download/" + str(GithubReleasesTag) + "\">Github Releases</a>") + "\n" + \
        "▫️ " + bold("Changelog: ", "<a href=\"https://raw.githubusercontent.com/SuperiorOS-Devices/changelogs/eleven/xcalibur_" + str(information['device']) + ".txt\">Changelog</a>") + "\n\n" + \
        "#" + str(information['device']) + " | #besuperior | @superioros"
    return message


new = get_id()
old = read_old()

if len(get_diff(new, old)) == 0:
    print("All Updated\nNothing to do\nExiting")
    exit()

print(get_diff(new, old))
commit_message = "Update new IDS"
commit_descriptions = "Data of the following device(s) were changed :\n"
release_notes = "New Superior OS Update has been released for the following devices :\n"
urls = ""
for i in get_diff(new, old):
    print(i)
    info = get_info(i)
    #send_mes(cook_content(info))
    send_photo(".github/assets/banner.png", cook_content(info))
    bot.send_sticker(CHAT_ID, STICKER_ID)
    commit_descriptions += info['name'] + " (" + info['device'] + ")\n"
    release_notes += info['name'] + " (" + info['device'] + ")\n"
    urls += info['url'] + "\n"
    if not info["isOnlyVanilla"]:
        urls += info['gapps_url'] + "\n"
    print (info['url'])
    print (info['gapps_url'])
    if info['url'].endswith('.zip'):
        if not info["isOnlyVanilla"]:
            if info["gapps_url"].endswith(".zip"):
                pass
            else:
                raise Exception("Provide direct link to SF, Download Link MUST end only with \".zip\".")
        pass
    else:
        raise Exception("Provide direct link to SF, Download Link MUST end only with \".zip\".")
    time.sleep(2)


open("commit_mesg.txt", "w+").write( "official_devices : " + commit_message + " [BOT]\n" + commit_descriptions)
open("release_notes.txt", "w+").write(release_notes + "\n\n *THIS WAS AN AUTOMATED RELEASE TRIGGERED THRU A PUSH, IF ANYTHING IS WRONG MAKE SURE TO TELL US THRU TELEGRAM*")
open("urls.txt", "w+").write(urls)

update(new)

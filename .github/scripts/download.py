#!/usr/bin/env python
#
# Copyright (C) 2021 Ashwin DS <astroashwin@outlook.com>
#
# Part of SuperiorOS <https://github.com/SuperiorOS>
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

import requests
import os
import time
try:
    urls = open("urls.txt", "r")

except FileNotFoundError:
    print("NO UPDATES or artifacts missing")
    open("noupdates.txt", "w+").write("NO UPDATES or artifacts missing")
    exit()

for url in urls.readlines():
    print(url)
    os.system("sudo wget " + url)

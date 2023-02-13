#!/bin/bash
# Copyright (C) 2020-23 The Superior OS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

myname="$0"
function help() {
  cat <<EOF
Syntax:
  $myname <device> <folder_of_rom>

for example:
$myname ef63 superior

EOF
}

if [ $# -lt 2 ]; then
  echo "ERROR: Not enough arguments provided"
  help
  exit 1
fi

device=$1
sourcerom=$2

DATE="$(grep ro.build.date.utc ~/$sourcerom/out/target/product/$device/system/build.prop | cut -d'=' -f2)"

if [ -z "$DATE" ]; then
  echo "ERROR: Failed to retrieve build date"
  exit 1
fi

echo ""

# make DATE human readable like 20230203
BUILDDATE="$(date -d @$DATE +%Y%m%d)"
DAY="$(date -d @$DATE +%d/%m/%Y)"

# get the zip path from out folder using the date
zip_path=~/$sourcerom/out/target/product/$device/*$BUILDDATE*.zip

# don't fail if there is no device json
set +e

if [ ! -d ~/official_devices ]; then
  cd ~
  git clone https://github.com/SuperiorOS-Devices/official_devices.git -b thirteen
fi

echo ""

if [ -d ~/official_devices ]; then

  # datetime
  timestamp=$(cat ~/$sourcerom/out/target/product/$device/system/build.prop | grep ro.build.date.utc | cut -d'=' -f2)
  timestamp_old=$(cat ~/official_devices/$device.json | grep "datetime" | cut -d':' -f2 | cut -d',' -f1)
  $(sed -i "s|$timestamp_old|$timestamp|g" ~/official_devices/$device.json)

  # filename
  zip_name=$(cat ~/$sourcerom/out/target/product/$device/system/build.prop | grep ro.superior.version | cut -d'=' -f2)
  zip_name_old=$(cat ~/official_devices/$device.json | grep "filename" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$zip_name_old|$zip_name.zip|g" ~/official_devices/$device.json)

  # id
  id=$(sha256sum $zip_path | cut -d' ' -f1)
  id_old=$(cat ~/official_devices/$device.json | grep "id" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$id_old|$id|g" ~/official_devices/$device.json)

  # Rom type
  type="RELEASE"
  type_old=$(cat ~/official_devices/$device.json | grep "romtype" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$type_old|$type|g" ~/official_devices/$device.json)

  # Rom size
  size_new=$(stat -c "%s" $zip_path)
  size_old=$(cat ~/official_devices/$device.json | grep "size" | cut -d':' -f2 | cut -d',' -f1)
  $(sed -i "s|$size_old|$size_new|g" ~/official_devices/$device.json)

  # Rom version
  version=$(cat ~/$sourcerom/out/target/product/$device/system/build.prop | grep ro.modversion | cut -d'=' -f2)
  version_old=$(cat ~/official_devices/$device.json | grep "version" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$version_old|$version|g" ~/official_devices/$device.json)

  # url
  url="https://master.dl.sourceforge.net/project/superioros/$device/vanilla/$zip_name.zip"
  url_old=$(cat ~/official_devices/$device.json | grep https | cut -d '"' -f4)
  $(sed -i "s|$url_old|$url|g" ~/official_devices/$device.json)
fi

echo ""

# if there is no json file, create one
if [ ! -f ~/official_devices/$device.json ]; then
  echo "No json file found, creating one"
  echo "Creating json file for $device"
  echo "{
  \"response\": [
    {
      \"datetime\": $timestamp,
      \"filename\": \"$zip_name.zip\",
      \"id\": \"$id\",
      \"romtype\": \"$type\",
      \"size\": $size_new,
      \"url\": \"$url\",
      \"version\": \"$version\",
      \"device_name\": \"Unknown\",
      \"maintainer\": \"Noob\"
    }
  ]
}" >~/official_devices/$device.json
  sleep 1
  echo "Done"
fi

echo ""
# if device name and maintainer is not set, ask for it
if [ "$(cat ~/official_devices/$device.json | grep "device_name" | cut -d':' -f2 | cut -d'"' -f2)" == "Unknown" ]; then
  echo "Device name is not set, please enter it"
  read -p "Device name: " device_name
  device_name_old=$(cat ~/official_devices/$device.json | grep "device_name" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$device_name_old|$device_name|g" ~/official_devices/$device.json)
fi

if [ "$(cat ~/official_devices/$device.json | grep "maintainer" | cut -d':' -f2 | cut -d'"' -f2)" == "Noob" ]; then
  echo "Maintainer is not set, please enter it"
  read -p "Maintainer: " maintainer
  maintainer_old=$(cat ~/official_devices/$device.json | grep "maintainer" | cut -d':' -f2 | cut -d'"' -f2)
  $(sed -i "s|$maintainer_old|$maintainer|g" ~/official_devices/$device.json)
fi

# add & push commit to github
echo ""
echo "Making commit..."
cd ~/official_devices
git add --all
git commit -m "$device: update $DAY"
cd ~
rm -rf OTA.sh
echo "Done"
echo ""

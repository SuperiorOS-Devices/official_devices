#!/bin/bash
# Copyright (C) 2015 Paranoid Android Project
# Copyright (C) 2018-2022 Sipun Ku Mahanta<sipunkumar85@gmail.com>

# PA Colors
# red = errors, cyan = warnings, green = confirmations, blue = informational
# plain for generic text, bold for titles, reset flag at each end of line
# plain blue should not be used for readability reasons - use plain cyan instead
CLR_RST=$(tput sgr0)                        ## reset flag
CLR_RED=$CLR_RST$(tput setaf 1)             #  red, plain
CLR_GRN=$CLR_RST$(tput setaf 2)             #  green, plain
CLR_YLW=$CLR_RST$(tput setaf 3)             #  yellow, plain
CLR_BLU=$CLR_RST$(tput setaf 4)             #  blue, plain
CLR_PPL=$CLR_RST$(tput setaf 5)             #  purple,plain
CLR_CYA=$CLR_RST$(tput setaf 6)             #  cyan, plain
CLR_BLD=$(tput bold)                        ## bold flag
CLR_BLD_RED=$CLR_RST$CLR_BLD$(tput setaf 1) #  red, bold
CLR_BLD_GRN=$CLR_RST$CLR_BLD$(tput setaf 2) #  green, bold
CLR_BLD_YLW=$CLR_RST$CLR_BLD$(tput setaf 3) #  yellow, bold
CLR_BLD_BLU=$CLR_RST$CLR_BLD$(tput setaf 4) #  blue, bold
CLR_BLD_PPL=$CLR_RST$CLR_BLD$(tput setaf 5) #  purple, bold
CLR_BLD_CYA=$CLR_RST$CLR_BLD$(tput setaf 6) #  cyan, bold

# This script is used to clone all the required trees for building
# Usage bash trees.sh <device>

usage() {

printf "\navailable options:\n"
printf "\n     avicii         - for Oneplus Nord\n"
printf "\n     whyred         - for Xiaomi Redmi Note 5 Pro\n"
printf "\n     spes           - for Xiaomi Redmi Note 11\n"
printf "\n     clean          - for deleting trees\n\n"

}

[ -z "$1" ] && usage && exit

if [ $1 = "whyred" ]
  then
echo -e "${CLR_BLD_RED}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/whyred
rm -rf device/xiaomi/sdm660-common
rm -rf kernel/xiaomi/whyred
rm -rf vendor/xiaomi
echo -e ""
echo -e "${CLR_BLD_RED}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_whyred.git -b thirteen device/xiaomi/whyred
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_whyred-common.git -b thirteen device/xiaomi/sdm660-common
git clone https://github.com/SuperiorOS-Devices/kernel_xiaomi_whyred.git -b thirteen kernel/xiaomi/whyred
git clone https://github.com/SuperiorOS-Devices/vendor_xiaomi_whyred.git -b thirteen vendor/xiaomi
echo -e ""
echo -e "${CLR_BLD_RED}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "spes" ]
  then
echo -e "${CLR_BLD_RED}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/spes
rm -rf kernel/xiaomi/spes
rm -rf vendor/xiaomi/spes
echo -e ""
echo -e "${CLR_BLD_RED}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_spes device/xiaomi/spes
git clone https://github.com/SuperiorOS-Devices/kernel_xiaomi_spes kernel/xiaomi/spes
git clone https://github.com/SuperiorOS-Devices/vendor_xiaomi_spes vendor/xiaomi/spes
echo -e ""
echo -e "${CLR_BLD_RED}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "avicii" ]
  then
echo -e "${CLR_BLD_RED}Removing device repos...${CLR_RST}"
rm -rf device/oneplus
rm -rf kernel/oneplus/avicii
rm -rf vendor/oneplus
rm -rf hardware/oneplus
rm -rf packages/apps/GoogleCamera
echo -e ""
echo -e "${CLR_BLD_RED}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_oneplus_avicii.git -b thirteen device/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/device_oneplus_avicii-common.git -b thirteen device/oneplus/sm7250-common
git clone https://github.com/SuperiorOS-Devices/kernel_oneplus_avicii.git -b thirteen kernel/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/vendor_oneplus_avicii.git -b thirteen vendor/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/vendor_oneplus_avicii-common.git -b thirteen vendor/oneplus/sm7250-common
git clone https://github.com/SuperiorOS-Devices/hardware_oneplus.git -b thirteen hardware/oneplus
git clone https://gitlab.com/superioros/vendor_oneplus-firmware.git -b thirteen vendor/oneplus/firmware
git clone https://gitlab.com/superioros/packages_apps_googlecamera.git -b thirteen packages/apps/GoogleCamera
echo -e "${CLR_BLD_RED}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "clean" ]
  then
echo -e "${CLR_BLD_RED}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi
rm -rf device/oneplus
rm -rf kernel/xiaomi
rm -rf kernel/oneplus
rm -rf vendor/xiaomi
rm -rf vendor/oneplus
rm -rf hardware/oneplus
rm -rf packages/apps/GoogleCamera
rm -rf vendor/MiuiCamera
echo -e ""
echo -e "${CLR_BLD_RED}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Force Syncing...${CLR_RST}"
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
else
usage
printf "\n\e[1;31mERROR:\e[0m Unknown option: $1\n"

fi

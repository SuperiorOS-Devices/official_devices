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
printf "\n     violet         - for Xiaomi Redmi Note 7 Pro\n"
printf "\n     lancelot       - for Xiaomi Redmi 9/Poco M2\n"
printf "\n     merlinx        - for Xiaomi Redmi Note 9/Redmi 10X 4G\n"
printf "\n     begonia        - for Xiaomi Redmi Note 8 Pro\n"
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
echo -e "${CLR_BLD_BLU}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/spes
rm -rf kernel/xiaomi/spes
rm -rf vendor/xiaomi/spes
echo -e ""
echo -e "${CLR_BLD_BLU}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_BLU}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_spes device/xiaomi/spes
git clone https://github.com/SuperiorOS-Devices/kernel_xiaomi_spes kernel/xiaomi/spes
git clone https://github.com/SuperiorOS-Devices/vendor_xiaomi_spes vendor/xiaomi/spes
echo -e ""
echo -e "${CLR_BLD_BLU}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "avicii" ]
  then
echo -e "${CLR_BLD_PPL}Removing device repos...${CLR_RST}"
rm -rf device/oneplus
rm -rf kernel/oneplus/avicii
rm -rf vendor/oneplus
rm -rf hardware/oneplus
echo -e ""
echo -e "${CLR_BLD_PPL}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_PPL}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_oneplus_avicii.git -b thirteen device/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/device_oneplus_avicii-common.git -b thirteen device/oneplus/sm7250-common
git clone https://github.com/SuperiorOS-Devices/kernel_oneplus_avicii.git -b thirteen kernel/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/vendor_oneplus_avicii.git -b thirteen vendor/oneplus/avicii
git clone https://github.com/SuperiorOS-Devices/vendor_oneplus_avicii-common.git -b thirteen vendor/oneplus/sm7250-common
git clone https://github.com/SuperiorOS-Devices/hardware_oneplus.git -b thirteen hardware/oneplus
echo -e "${CLR_BLD_PPL}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "violet" ]
  then
echo -e "${CLR_BLD_GRN}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/violet
rm -rf kernel/xiaomi/violet
rm -rf vendor/xiaomi/violet
rm -rf vendor/xiaomi-firmware/violet
echo -e ""
echo -e "${CLR_BLD_GRN}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_GRN}Cloning device repos...${CLR_RST}"
git clone git@github.com:SuperiorOS-Devices/vendor_xiaomi_violet.git -b thirteen vendor/xiaomi/violet
git clone git@github.com:SuperiorOS-Devices/device_xiaomi_violet.git -b thirteen device/xiaomi/violet
git clone git@github.com:SuperiorOS-Devices/kernel_xiaomi_violet.git -b thirteen kernel/xiaomi/violet
git clone https://gitlab.com/Joker-V2/vendor_xiaomi-firmware_violet vendor/xiaomi-firmware/violet
echo -e ""
echo -e "${CLR_BLD_GRN}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "lancelot" ]
  then
echo -e "${CLR_BLD_CYA}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/lancelot
rm -rf kernel/xiaomi/mt6768
rm -rf vendor/xiaomi/lancelot
rm -rf hardware/mediatek
rm -rf device/mediatek/sepolicy_vndr
rm -rf vendor/mediatek/opensource/interfaces
rm -rf vendor/goodix/opensource/interfaces
echo -e ""
echo -e "${CLR_BLD_CYA}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_CYA}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_lancelot -b thirteen device/xiaomi/lancelot
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_mt6768-common -b thirteen device/xiaomi/mt6768-common
git clone https://github.com/SuperiorOS-Devices/vendor_xiaomi_mt6768-common -b thirteen vendor/xiaomi
git clone https://github.com/JR205-5000/JR205-6768 -b Liella! kernel/xiaomi/mt6768
git clone https://github.com/JR205-5000/android_hardware_mediatek -b main hardware/mediatek
git clone https://github.com/JR205-5000/android_device_mediatek-sepolicy_vndr -b main device/mediatek/sepolicy_vndr 
git clone https://github.com/JR205-5000/vendor_mediatek_opensource_interfaces -b main vendor/mediatek/opensource/interfaces
git clone https://github.com/JR205-5000/vendor_goodix_opensource_interfaces -b lineage-20 vendor/goodix/opensource/interfaces
echo -e ""
echo -e "${CLR_BLD_CYA}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "merlinx" ]
  then
echo -e "${CLR_BLD_YLW}Removing device repos...${CLR_RST}"
rm -rf device/xiaomi/merlinx
rm -rf kernel/xiaomi/mt6768
rm -rf vendor/xiaomi/lancelot
rm -rf vendor/xiaomi/merlinx
rm -rf vendor/xiaomi/mt6768-common
rm -rf vendor/xiaomi/mt6768-ims
rm -rf hardware/mediatek
rm -rf device/mediatek/sepolicy_vndr
rm -rf vendor/goodix/opensource/interfaces
rm -rf vendor/mediatek/opensource/interfaces
echo -e ""
echo -e "${CLR_BLD_YLW}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_YLW}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_merlinx -b thirteen device/xiaomi/merlinx
git clone https://github.com/SuperiorOS-Devices/device_xiaomi_mt6768-common -b thirteen device/xiaomi/mt6768-common
git clone https://github.com/SuperiorOS-Devices/vendor_xiaomi_mt6768-common -b thirteen vendor/xiaomi
git clone https://github.com/JR205-5000/JR205-6768 -b Liella! kernel/xiaomi/mt6768
git clone https://github.com/JR205-5000/android_hardware_mediatek -b main hardware/mediatek
git clone https://github.com/JR205-5000/android_device_mediatek-sepolicy_vndr -b main device/mediatek/sepolicy_vndr 
git clone https://github.com/JR205-5000/vendor_mediatek_opensource_interfaces -b main vendor/mediatek/opensource/interfaces
git clone https://github.com/JR205-5000/vendor_goodix_opensource_interfaces -b lineage-20 vendor/goodix/opensource/interfaces
echo -e ""
echo -e "${CLR_BLD_YLW}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "begonia" ]
  then
echo -e "${CLR_BLD_RED}Removing device repos...${CLR_RST}"
rm -rf device/redmi/begonia
rm -rf kernel/xiaomi/mt6785
rm -rf vendor/redmi/begonia
rm -rf vendor/redmi/begonia-ims
rm -rf vendor/redmi/begonia-firmware
rm -rf packages/apps/MtkFMRadio
rm -rf prebuilts/clang/host/linux-x86/clang-azure
echo -e ""
echo -e "${CLR_BLD_RED}Device repos removed ...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Cloning device repos...${CLR_RST}"
git clone https://github.com/SuperiorOS-Devices/device_redmi_begonia -b 13 device/redmi/begonia
git clone https://github.com/SHADOW-REX/kernel_xiaomi_mt6785 -b nova kernel/xiaomi/mt6785
git clone https://github.com/SuperiorOS-Devices/vendor_redmi_begonia -b 13 vendor/redmi/begonia
git clone https://github.com/Trinity-ROMS/android_vendor_redmi_begonia-ims -b tiramisu vendor/redmi/begonia-ims
git clone https://github.com/Trinity-ROMS/android_vendor_redmi_begonia-firmware -b tiramisu vendor/redmi/begonia-firmware
git clone https://github.com/Trinity-ROMS/android_packages_apps_MtkFMRadio -b tiramisu packages/apps/MtkFMRadio
git clone https://gitlab.com/Panchajanya1999/azure-clang -b main prebuilts/clang/host/linux-x86/clang-azure
echo -e ""
echo -e "${CLR_BLD_RED}Cloning Complete...${CLR_RST}"
echo -e ""
echo -e "${CLR_BLD_RED}Now You are good to Go${CLR_RST}"
echo -e ""
elif [ $1 = "clean" ]
  then
echo -e "${CLR_BLD_RED}Removing every devices repos...${CLR_RST}"
rm -rf device/xiaomi
rm -rf device/redmi
rm -rf device/oneplus
rm -rf device/mediatek
rm -rf kernel/xiaomi
rm -rf kernel/oneplus
rm -rf vendor/xiaomi
rm -rf vendor/redmi
rm -rf vendor/oneplus
rm -rf vendor/MiuiCamera
rm -rf vendor/goodix
rm -rf hardware/oneplus
rm -rf hardware/mediatek
rm -rf packages/apps/GoogleCamera
rm -rf packages/apps/MtkFMRadio
rm -rf prebuilts/clang/host/linux-x86/clang-azure
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

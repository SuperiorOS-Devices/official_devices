---------------------------------------------------------------------

## Official devices application

Before you apply to add your device into our list of official devices, you should know a few things:

Any failure in following the below instructions will make you unfit for the maintainership. No questions asked.

### To turn into a maintainer of Superior OS:

• You must own the device. Blind and untested builds aren't allowed.

• You must have knowledge of git.

• You must do one or two unofficial build[Post at XDA],  be sure that the build is stable for daily usage before applying. Stability context may differ for different devices, so explain for any exceptions.

• You must have your device sources public [Modified trees needed]  .


### 2. Maintainers conduct notes:

• The maintainers mustn't do any unofficial modifications.

• The maintainers must upload theirs trees on [SuperiorOS-Devices](https://github.com/SuperiorOS-Devices) organization. The trees should fully reflect the changes when a new build is pushed for that specific device tree. Last but not the least, it should be fully buildable.

• The maintainers must test every build before sending OTA update to user.

• The maintainers must keep authorship of git commits that are pushed, mandatory for all repository. Force-pushes are acceptable.

----------------------------------------------------------------------

Mail us at - superioros123@gmail.com with stuffs given below.

• Sources - All device trees which you used to build the rom(Need modified trees).

• XDA Thread - Your XDA thread for unofficial builds.

• TG Id - Your telegram username.

• Screenshot - Your about Phone screenshot.

-----------------------------------------------------------------------

OTA Guide for maintainers:-
======================

• After Building the ROM push to sf then folllow the procedures given below:-

If U added Your SSH key then use this -
-------------------------------------

```bash

cd ~ && wget https://raw.githubusercontent.com/SuperiorOS-Devices/official_devices/ten/OTA.sh

```

Then

```bash

bash OTA.sh <device_codename> <rom_dir>

```

Example - bash OTA.sh whyred superior



If U didn't added Your SSH key then use this -
--------------------------------------------------------------------------------

```bash

cd ~ && wget https://raw.githubusercontent.com/SuperiorOS-Devices/official_devices/ten/Maintainers.sh

```

Then

```bash

bash Maintainers.sh <device_codename> <rom_dir>

```

Example - bash Maintainers.sh whyred superior

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

• Create device specific directory (Use device codename).

• Create build.json for vanilla builds and gapps_build.json for GApps builds.

### Example

```
{
  "response": [
    {
      "datetime":1615528227,
      "filename": "SuperiorOS-Xcalibur-violet-OFFICIAL-20210312-0555.zip",
      "id": "bca525af7a31f41e3d22d7c35f3bef0c",
      "romtype": "OFFICIAL",
      "size":955104642,
      "url": "https://master.dl.sourceforge.net/project/superioros/violet/SuperiorOS-Xcalibur-violet-OFFICIAL-20210312-0555.zip",
      "version": "Xcalibur"
    }
  ]
}
```

These are some custom scripts I have created. [install] and [subextract] are mostly used to manage the packages in budlime, and may or may not be of general interest. [sublaunch] and [sublget] on the other hand provides some nice functions that can be of use in any workflow.

The links in this readme, take you to the scripts readme in the `src` directory.
You can also execute the scripts with `--help` to get some info about commandline options and such.  

## Installation 
There is currently no installation, such as makefiles, if you want to use the scripts i suggest you copy them to your `$PATH`.

## [install] - (the script)
this script applies and install all the packages and settings in the **packages** directory of this repo. It has [subextract] as a dependency.  

## [subextract]
can be used to sync settings of a sublime installation, an extract *common files* from packed/archived packages. It have the **unzip** program as an dependency.  

## [sublaunch]
Open a sublime window, with a specific project, file and/or instance name. This script depends on [sublget] and [xdotool].

## [sublget]
prints information about open sublime windows, by analyzing the window title. This script depends on [wmctrl]


[xdotool]: https://github.com/jordansissel/xdotool
[wmctrl]: http://tripie.sweb.cz/utils/wmctrl/
[subextract]: https://github.com/budlabs/budlime/tree/master/src/subextract
[sublget]: https://github.com/budlabs/budlime/tree/master/src/sublget
[install]: https://github.com/budlabs/budlime/tree/master/src/install
[sublaunch]: https://github.com/budlabs/budlime/tree/master/src/sublaunch

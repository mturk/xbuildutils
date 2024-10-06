# Overview

xbuildutils is a set of scripts for setting up build
environment on Microsoft Windows platfom.

# Creating distribution

Download or checkout the latest xbuildutils from
[Github](https://github.com/mturk/xbuildutils)

Open command prompt and change directory
to the xbuildutils.

```cmd
> cd install
> xbprep.bat
> getcygwrun.bat
> getgit.bat
> getnasm.bat
> getperl.bat
> cd java
> getopenjdk8u.bat
> getopenjdk17u.bat
> getopenjdk21u.bat
> getopenjdk21u.bat /i
> cd ..
> cd msvs
> xprepare.bat
> %SystemRoot%\System32\tar.exe -cf xbuildutils-prep-%date%.tar C:\VisualStudio C:\xbuildutils

```

Copy the xbuildutils-prep-YYYY-mm-dd.tar to a permanent storage location.
Reset the Virtual machine to the initial state

Copy the xbuildutils-prep-YYYY-mm-dd.tar to the root of C drive.
Open the command prompt as Administrator

```cmd
> cd \
> md VisualStudio
> md xbuildutils
> %SystemRoot%\System32\tar.exe -xf xbuildutils-prep-YYYY-mm-dd.tar
> cd VisualStudio\Layouts\vs2022s
> xinstall.bat
> cd \
> %SystemRoot%\System32\tar.exe -cf xbuildutils-dist-%date%.tar xbuildutils

```

Copy the xbuildutils-dist-YYYY-mm-dd.tar to a permanent storage location.
Reset the Virtual machine to the initial state

Copy the xbuildutils-dist-YYYY-mm-dd.tar to the root of C drive.
Open the command prompt as Administrator

```cmd
> cd \
> md xbuildutils
> %SystemRoot%\System32\tar.exe -xf xbuildutils-prep-YYYY-mm-dd.tar
> rm xbuildutils-prep-YYYY-mm-dd.tar

```

The Virtual machine now has all te tools inside xbuildutils directory


# License

The code in this repository is licensed under the [Apache-2.0 License](LICENSE.txt).

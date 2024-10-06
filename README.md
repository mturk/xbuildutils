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
> msvsprepare.bat
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
> cd VisualStudio\Layouts\msvs
> msvsinstall.bat
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

# Installing Cygwin

Xbuildutils contains a non-interactive Cygwin installer.

Open command prompt and change directory
to the xbuildutils.

```cmd
> cd install\cygwin
> cygwinprepare.bat

```


Open command prompt and change directory
to the install directory.

```cmd
> cs \
> cd cygwin64\.install
> cygwininstall.bat

```

After installation call the `cygwin.bat` for initial
setup

```cmd
> cs \
> cd cygwin64
> call cygwin.bat

```

After that, setup users, add additional packages, etc.

Cygwin installer will modify '/etc/fstab' file by
adding **noacl** option to default mount.
This fixes the problems when using cygwin tools
to download or copy files, which then cannot be used
by native Windows applications.

The alternative is to reset the permissions for
each affected directory by using the following:

```sh
$ takeown /F "`cygpath -w directory`" /R /D Y > /dev/null
$ icacls "`cygpath -w directory`" /reset /T /Q

```


# Installing Msys2

Xbuildutils contains a non-interactive Msys2 installer.

Open command prompt and change directory
to the xbuildutils.

```cmd
> cd install
> installmsys2.bat

```

This will install Msys2 in **C:\msys64** directory.
After installation, open the **msys2_shell.cmd** and install
additional packages, users, etc.


# License

The code in this repository is licensed under the [Apache-2.0 License](LICENSE.txt).

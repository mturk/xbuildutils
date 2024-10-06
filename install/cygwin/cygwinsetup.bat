@echo off
rem
rem Licensed under the Apache License, Version 2.0 (the "License");
rem you may not use this file except in compliance with the License.
rem You may obtain a copy of the License at
rem
rem     http://www.apache.org/licenses/LICENSE-2.0
rem
rem Unless required by applicable law or agreed to in writing, software
rem distributed under the License is distributed on an "AS IS" BASIS,
rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
rem See the License for the specific language governing permissions and
rem limitations under the License.
rem
rem Set version and packages
rem
rem
set "CygwinMirror=https://mirrors.kernel.org/sourceware/cygwin/"
set "CygwinSetupVer=2.932"
set "CygwinVersion=3.5.4"
set "CygwinSetup=setup-x86_64-%CygwinSetupVer%.exe"
rem
rem Define required packages
rem
set "_P0=curl,wget,wget2,gnupg,gnupg2,inetutils"
set "_P1=diffutils,dos2unix,patch,patchutils,time,chere,cygrunsrv,attr,shutdown"
set "_P2=python2,python3,tcl,git,subversion"
set "_P3=cpio,unzip,xz,p7zip,zip,zstd,rpm,rpm-build"
set "_P4=gcc-core,gcc-g++,autoconf,automake,autogen,autobuild,libtool,m4,make,makedepend"
set "_P5=bison,byacc,flex,cmake,ninja,meson,w32api-headers,w32-api-runtime,windows-default-manifest"
set "_P6=mingw64-x86_64-binutils,mingw64-x86_64-gcc-core,mingw64-x86_64-gcc-g++,mingw64-x86_64-headers,mingw64-x86_64-runtime"
rem
set "CygwinPackages=%_P0%,%_P1%,%_P2%,%_P3%,%_P4%,%_P5%,%_P6%"
rem
set _P0=
set _P1=
set _P2=
set _P3=
set _P4=
set _P5=
set _P6=
set _P7=
set _P8=
set _P9=

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
set "_P0=time,chere,cygrunsrv,attr,shutdown,ping,gnupg2"
set "_P1=,diffutils,inetutils,dos2unix,patch,patchutils,nano"
set "_P2=,cpio,unzip,xz,p7zip,zip,zstd,rpm,rpm-build"
set "_P3=,git,curl,wget,wget2"
set "_P4=,python,python3"
rem
goto SetPackages
Rem Comment above line to install some basic dev packages
set "_P5=,bison,byacc,flex"
set "_P6=,autoconf,automake,autogen,autobuild,libtool,m4,make,makedepend"
set "_P7=,w32api-headers,w32api-runtime,windows-default-manifest"
set "_P8=,mingw64-x86_64-binutils,mingw64-x86_64-gcc-core,mingw64-x86_64-gcc-g++,mingw64-x86_64-headers,mingw64-x86_64-runtime"
rem
:SetPackages
set "CygwinPackages=%_P0%%_P1%%_P2%%_P3%%_P4%%_P5%%_P6%%_P7%%_P8%"
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

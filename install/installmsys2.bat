@echo off
setlocal
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
rem Downloads and install Msys2 distribution
rem
rem @author Mladen Turk
rem
set "Msys2VerMajor=2024"
set "Msys2VerMinor=07"
set "Msys2VerPatch=27"
set "Msys2Version=%Msys2VerMajor%%Msys2VerMinor%%Msys2VerPatch%"
set "Msys2VerDate=%Msys2VerMajor%-%Msys2VerMinor%-%Msys2VerPatch%"
rem
set "Msys2Root=%SystemDrive%\msys64"
rem
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
pushd %~dp0
set "_WorkPath=%cd%"
pushd ..\utils
set "PATH=%cd%;%PATH%"
popd
popd
rem
set "Msys2Name=msys2-base-x86_64"
set "Msys2Url=https://github.com/msys2/msys2-installer/releases/download/%Msys2VerDate%"
set "Msys2Tar=%Msys2Name%-%Msys2Version%.tar"
set "Msys2Arch=%Msys2Tar%.xz"
rem Check if already installed
if exist %Msys2Root% (
  echo Error: Msys2 Root "%Msys2Root%" already exists
  exit /B 1
)
rem Download msys2-base
if not exist "%Msys2Arch%" (
  echo Downloading %Msys2Arch%
  curl.exe %CurlOpts% -o %Msys2Arch% %Msys2Url%/%Msys2Arch%
)
rem
7za.exe t %Msys2Arch% >NUL 2>&1 && ( goto Exp )
echo.
echo Error: Failed to download %Msys2Arch%.
del /F /Q %Msys2Arch% 2>NUL
exit /B 1
rem
:Exp
rem
if not exist "%Msys2Tar%" (
  echo Uncompressing %Msys2Arch%
  7za.exe x -bd %Msys2Arch%
  echo.
)
echo Extracting %Msys2Tar%
7za.exe x -y -o%SystemDrive% -bd %Msys2Tar%
rem
pushd %Msys2Root%
set "PATH=%cd%\usr\bin;%PATH%"
rem Do initial install
echo.
echo Installing msys2
set "_Pacman=pacman --noconfirm  --disable-download-timeout"
rem pacman needs to be called few times
bash.exe --login -c "%_Pacman% -Syuu"
bash.exe --login -c "%_Pacman% -Syuu"
bash.exe --login -c "%_Pacman% -Syuu"
rem Add basic packages
echo.
echo Installing basic packages
bash.exe --login -c "%_Pacman% -Syu compression base-devel VCS"
rem Add additional packages
echo.
echo Installing additional packages
bash.exe --login -c "%_Pacman% -Syu mingw-w64-x86_64-toolchain"
bash.exe --login -c "%_Pacman% -Syu mingw-w64-ucrt-x86_64-toolchain"
rem
popd
echo.
echo Finished.
:End

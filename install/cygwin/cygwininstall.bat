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
rem Install Cygwin ditribution from the local .install directory
rem
rem
set "CygwinRoot=%SystemDrive%\cygwin64"
rem
call cygwinsetup.bat
rem
pushd ..\
start /B /MIN /WAIT %CygwinSetup% -qnoOABXL -l "%CygwinRoot%\.packages" -s "%CygwinMirror%" -R "%CygwinRoot%" -P "%CygwinPackages%"
popd
if /i "x%~1" NEQ "x/s" goto End
move /Y ..\etc\skel\.bashrc bashrc.org >NUL
move /Y ..\etc\fstab fstab.org >NUL
copy /Y /B bashrc.org+bashrc ..\etc\skel\.bashrc >NUL
copy /Y fstab ..\etc\fstab >NUL
rem
:End
echo.
echo Finished.
exit /B 0

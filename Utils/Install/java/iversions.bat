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
rem Java versions
rem
set "Java8Ver=402"
set "Java8Bld=b06"
rem
set "Java11Ver=11.0.24"
set "Java11Bld=8"
set "Java11Rel=8"
rem
set "Java17Ver=17.0.10"
set "Java17Bld=7"
set "Java17Rel=7"
rem
set "Java19Ver=19.0.2"
set "Java19Bld=7"
rem
set "Java20Ver=20.0.2"
set "Java20Bld=9"
rem
set "Java21Ver=21.0.4"
set "Java21Bld=7"
rem
set "CurlOpts=-qkL --retry 5 --no-progress-meter"
set "_InstallPath=%SystemDrive%\Tools"
set "_InstallFile=%_InstallPath%\java\_setupenv.bat"
rem
if not exist "%_InstallFile%" (
    echo @echo off >%_InstallFile%
    echo setlocal >>%_InstallFile%
    echo rem >>%_InstallFile%
    echo rem set "_InstallPath=%_InstallPath%" >>%_InstallFile%
    echo rem >>%_InstallFile%
)

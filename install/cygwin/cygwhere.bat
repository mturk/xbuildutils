@echo off
setlocal enableextensions
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
rem
rem CygwinHere support for Total Commander Start menu
rem Command: %COMSPEC%
rem Parameters: /k C:\cygwin64\cygwhere.bat "%P"
rem
rem You can also run this from any program, eg
rem %COMSPEC% /k C:\cygwin64\cygwhere.bat "%cd%"
rem
rem Make sure to add the following to ~/.bashrc
rem if [ ".$__CYGWINCD" != "." ]; then
rem   cd "$__CYGWINCD"
rem fi
rem unset __CYGWINCD
rem
set TERM=
set "__CYGWINCD=%~1"
cd /d "%~dp0bin" && .\bash --login -i

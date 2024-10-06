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
rem
rem
set "_XbuildUtilsDir=C:\xbuildutils"
rem
set "VisualStudioVersion=17.0"
set "VSCMD_VER=17.10.7"
set "VCToolsVersion=14.40.33807"
set "WindowsSdkVersion=10.0.22621.0"
rem
rem echo ************************************************************************
rem echo ** Microsoft Visual Studio 2022 Build Tools Command Prompt %VSCMD_VER%_LTSC
rem echo ************************************************************************
rem echo.
set "WindowsSdkDir=%_XbuildUtilsDir%\wsdk"
set "VSINSTALLDIR=%_XbuildUtilsDir%\msvs"
set "VCINSTALLDIR=%VSINSTALLDIR%\VC"
set "VCToolsInstallDir=%VCINSTALLDIR%\Tools\MSVC\%VCToolsVersion%"
set "VCToolsRedistDir=%VCINSTALLDIR%\Redist\MSVC\%VCToolsVersion%"
rem
set "Platform=x64"
set "DevEnvDir=%VSINSTALLDIR%\Common7\IDE"
set "UCRTVersion=%WindowsSdkVersion%"
set "UniversalCRTSdkDir=%WindowsSdkDir%"
set "VCIDEInstallDir=%DevEnvDir%\VC"
set "VS170COMNTOOLS=%VSINSTALLDIR%\Common7\Tools"
set "VSCMD_ARG_app_plat=Desktop"
set "VSCMD_ARG_HOST_ARCH=x64"
set "VSCMD_ARG_TGT_ARCH=x64"
rem
set "WindowsLibPath=%WindowsSdkDir%\UnionMetadata\%WindowsSdkVersion%;%WindowsSdkDir%\References\%WindowsSdkVersion%"
set "WindowsSdkBinPath=%WindowsSdkDir%\bin"
set "WindowsSDKLibVersion=%WindowsSdkVersion%"
set "WindowsSdkVerBinPath=%WindowsSdkBinPath%\%WindowsSdkVersion%"
set "WindowsSdkVerLibPath=%WindowsSdkDir%\lib\%WindowsSdkVersion%"
set "WindowsSdkVerIncPath=%WindowsSdkDir%\include\%WindowsSdkVersion%"
rem
set "INCLUDE=%VCToolsInstallDir%\include;%WindowsSdkVerIncPath%\ucrt;%WindowsSdkVerIncPath%\shared;%WindowsSdkVerIncPath%\um;%WindowsSdkVerIncPath%\winrt;%WindowsSdkVerIncPath%\cppwinrt"
set "LIB=%VCToolsInstallDir%\lib\x64;%WindowsSdkVerLibPath%\ucrt\x64;%WindowsSdkVerLibPath%\um\x64"
set "LIBPATH=%VCToolsInstallDir%\lib\x64;%VCToolsInstallDir%\lib\x86\store\references;%WindowsLibPath%"
set "PATH=%_XbuildUtilsDir%;%_XbuildUtilsDir%\perl\perl\bin;%_XbuildUtilsDir%\nasm;%VCToolsInstallDir%\bin\HostX64\x64;%VSINSTALLDIR%\MSBuild\Current\bin\Roslyn;%WindowsSdkVerBinPath%\x64;%WindowsSdkBinPath%\x64;%VSINSTALLDIR%\MSBuild\Current\Bin\amd64;%PATH%"
rem
rem Remove private variables
set _XbuildUtilsDir=
rem

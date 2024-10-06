#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#
_XbuildUtilsDir="C:/xbuildutils"
#
export VisualStudioVersion="17.0"
export VSCMD_VER="17.10.7"
export VCToolsVersion="14.40.33807"
export WindowsSdkVersion="10.0.22621.0"
#
export WindowsSdkDir="$_XbuildUtilsDir/wsdk"
export VSINSTALLDIR="$_XbuildUtilsDir/msvs"
export VCINSTALLDIR="$VSINSTALLDIR/VC"
export VCToolsInstallDir="$VCINSTALLDIR/Tools/MSVC/$VCToolsVersion"
export VCToolsRedistDir="$VCINSTALLDIR/Redist/MSVC/$VCToolsVersion"
export VCToolsRedistDir="$VCINSTALLDIR/Redist/MSVC/$VCToolsVersion"
#
export Platform="x64"
export DevEnvDir="$VSINSTALLDIR/Common7/IDE"
export UCRTVersion="$WindowsSdkVersion"
export UniversalCRTSdkDir="$WindowsSdkDir"
export VCIDEInstallDir="$DevEnvDir/VC"
export VS170COMNTOOLS="$VSINSTALLDIR/Common7/Tools"
export VSCMD_ARG_app_plat="Desktop"
export VSCMD_ARG_HOST_ARCH="x64"
export VSCMD_ARG_TGT_ARCH="x64"
#
export WindowsLibPath="$WindowsSdkDir/UnionMetadata/$WindowsSdkVersion;$WindowsSdkDir/References/$WindowsSdkVersion"
export WindowsSdkBinPath="$WindowsSdkDir/bin"
export WindowsSDKLibVersion="$WindowsSdkVersion"
export WindowsSdkVerBinPath="$WindowsSdkBinPath/$WindowsSdkVersion"
export WindowsSdkVerLibPath="$WindowsSdkDir/lib/$WindowsSdkVersion"
export WindowsSdkVerIncPath="$WindowsSdkDir/include/$WindowsSdkVersion"
#
export INCLUDE="$VCToolsInstallDir/include;$WindowsSdkVerIncPath/ucrt;$WindowsSdkVerIncPath/shared;$WindowsSdkVerIncPath/um;$WindowsSdkVerIncPath/winrt;$WindowsSdkVerIncPath/cppwinrt"
export LIB="$VCToolsInstallDir/lib/x64;$WindowsSdkVerLibPath/ucrt/x64;$WindowsSdkVerLibPath/um/x64"
export LIBPATH="$VCToolsInstallDir/lib/x64;$VCToolsInstallDir/lib/x86/store/references;$WindowsLibPath"
#
CYGWRUN_PATH="$_XbuildUtilsDir;$_XbuildUtilsDir/perl/perl/bin;$_XbuildUtilsDir/nasm"
CYGWRUN_PATH="$CYGWRUN_PATH;$VCToolsInstallDir/bin/HostX64/x64;$VSINSTALLDIR/MSBuild/Current/bin/Roslyn;$WindowsSdkVerBinPath/x64;$WindowsSdkBinPath/x64;$VSINSTALLDIR/MSBuild/Current/Bin/amd64"
CYGWRUN_PATH="$CYGWRUN_PATH;C:/Windows/system32;C:/Windows;C:/Windows/System32/Wbem;C:/Windows/System32/WindowsPowerShell/v1.0"
export CYGWRUN_PATH
#
unset _XbuildUtilsDir

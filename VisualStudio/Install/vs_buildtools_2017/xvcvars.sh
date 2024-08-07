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

export "VSCMD_VER=15.9.64"
export "VCToolsVersion=14.16.27023"
export "WindowsSdkVersion=10.0.17763.0"
#
echo *********************************************************
echo ** Microsoft Visual Studio 2017 Build Tools $VSCMD_VER
echo *********************************************************
echo

_ToolsPath="/cygdrive/c/Tools"
_UtilsPath="/cygdrive/c/Utils"

export "WindowsSdkDir=$_ToolsPath/wsdk22000"
export "VSINSTALLDIR=$_ToolsPath/msvs2017b"
export "VCINSTALLDIR=$VSINSTALLDIR/VC"
export "VCToolsInstallDir=$VCINSTALLDIR/Tools/MSVC/$VCToolsVersion"
export "VCToolsRedistDir=$VCINSTALLDIR/Redist/MSVC/14.16.27012"

_PerlVersion="5.38.0.1"
_NasmVersion="2.16.03"
_PerlPath="$_UtilsPath/perl/$_PerlVersion/perl/bin"
_NasmPath="$_UtilsPath/nasm/$_NasmVersion"

export "Platform=x64"
export "DevEnvDir=$VSINSTALLDIR/Common7/IDE"
export "UCRTVersion=$WindowsSdkVersion"
export "UniversalCRTSdkDir=$WindowsSdkDir"
export "VCIDEInstallDir=$DevEnvDir/VC"
export "VisualStudioVersion=15.0"
export "VS150COMNTOOLS=$VSINSTALLDIR/Common7/Tools"
export "VSCMD_ARG_app_plat=Desktop"
export "VSCMD_ARG_HOST_ARCH=x64"
export "VSCMD_ARG_TGT_ARCH=x64"

export "WindowsLibPath=$WindowsSdkDir/UnionMetadata/$WindowsSdkVersion:$WindowsSdkDir/References/$WindowsSdkVersion"
export "WindowsSdkBinPath=$WindowsSdkDir/bin"
export "WindowsSDKLibVersion=$WindowsSdkVersion"
export "WindowsSdkVerBinPath=$WindowsSdkBinPath/$WindowsSdkVersion"
export "WindowsSdkVerLibPath=$WindowsSdkDir/lib/$WindowsSdkVersion"
export "WindowsSdkVerIncPath=$WindowsSdkDir/include/$WindowsSdkVersion"

export "INCLUDE=$VCToolsInstallDir/include:$WindowsSdkVerIncPath/ucrt:$WindowsSdkVerIncPath/shared:$WindowsSdkVerIncPath/um:$WindowsSdkVerIncPath/winrt:$WindowsSdkVerIncPath/cppwinrt"
export "LIB=$VCToolsInstallDir/lib/x64:$WindowsSdkVerLibPath/ucrt/x64:$WindowsSdkVerLibPath/um/x64"
export "LIBPATH=$VCToolsInstallDir/lib/x64:$VCToolsInstallDir/lib/x86/store/references:$WindowsLibPath"
_VsCmdPath="$VCToolsInstallDir/bin/HostX64/x64:$VSINSTALLDIR/MSBuild/Current/bin/Roslyn:$WindowsSdkVerBinPath/x64:$WindowsSdkBinPath/x64:$VSINSTALLDIR/MSBuild/Current/Bin/amd64"
export "PATH=$_UtilsPath:$_PerlPath:$_NasmPath:$_VsCmdPath:$PATH"

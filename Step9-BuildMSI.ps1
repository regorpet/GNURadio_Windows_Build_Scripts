# GNURadio Windows Build System
# Geof Nieboer
# Step9_BuildMSI.ps1
#

# script setup
$ErrorActionPreference = "Stop"

# setup helper functions
$mypath =  Split-Path $script:MyInvocation.MyCommand.Path
. $mypath\Setup.ps1 -Force

SetLog "MSI Creation"
cd $root\src-stage4-installer
New-Item -ItemType Directory -Force build 2>&1 >> $Log 
Write-Host "Building MSI packages"

Function BuildMSI {

	$configuration = $args[0]

	Write-Host -NoNewline "Building $configuration package..."

	New-Item -ItemType Directory -Force build\$configuration 2>&1 >> $Log 

	msbuild gnuradio-winstaller.wixproj /m /p:"configuration=$configuration;root=$root;platform=x64"  2>&1 >> $Log 

	Validate "$root/src-stage4-installer/dist/$configuration/gnuradio_3.7_win64.msi"
}

BuildMSI "Release"
BuildMSI "Release-AVX2"
BuildMSI "Debug"

""
"COMPLETED STEP 9: .msi files have been created and can be found in $root/src-stage4-installer/dist/(configuration)/gnuradio_3.7_win64.msi"
""
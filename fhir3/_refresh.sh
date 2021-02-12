#!/bin/bash
#DO NOT EDIT WITH WINDOWS
tooling_jar=tooling-1.3.1-SNAPSHOT-jar-with-dependencies.jar
input_cache_path=$PWD/input-cache
ig_path=input/connectathon.xml
resources_path=input/resources
root_dir=$PWD
#measure_to_refresh_path=$PWD/input/resources/measure/measure-EXM104-8.2.000.json

set -e
echo Checking internet connection...
wget -q --spider tx.fhir.org

if [ $? -eq 0 ]; then
	echo "Online"
	fsoption=""
else
	echo "Offline"
	fsoption=""
fi

echo "$fsoption"

tooling=$input_cache_path/$tooling_jar
if test -f "$tooling"; then
	java -jar $tooling -RefreshIG -root-dir="$root_dir" -ig-path="$ig_path" -rp="$resources_path" -t -d -p $fsoption
        #java -jar $tooling -RefreshIG -ini="$PWD"/ig.ini -mtrp="$measure_to_refresh_path" -t -d -p -v $fsoption
else
	tooling=../$tooling_jar
	echo $tooling
	if test -f "$tooling"; then
		java -jar $tooling -RefreshIG -root-dir="$root_dir" -ig-path="$ig_path" -rp="$resources_path" -t -d -p $fsoption
                #java -jar $tooling -RefreshIG -ini="$PWD"/ig.ini -mtrp="$measure_to_refresh_path" -t -d -p -v $fsoption
	else
		echo IG Refresh NOT FOUND in input-cache or parent folder.  Please run _updateRefreshIG.  Aborting...
	fi
fi

#!/usr/bin/env bash

rm config.cfg
echo "config file cleared setting up new config file"
echo "press enter to continue"
read
mindir=$(zenity  --file-selection --directory --title "select mindustry source dir")
echo $mindir >> config.cfg
echo "type the command that will bu used to compile in case of update/no jar avaliable"
read -e -p "command:" -i "./gradlew desktop:dist" compilecmd
echo $compilecmd >> config.cfg
echo "type the command that will bu used to run the game after compile"
read -e -p "command:" -i "java -jar desktop/build/libs/mindustry.jar" runcmd
echo $runcmd >> config.cfg

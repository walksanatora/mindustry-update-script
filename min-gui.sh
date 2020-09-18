#!/usr/bin/env bash
tmp=$(mktemp)

dialog --checklist "options:" 0 0 4 1 "6.0 version" on 2 "forcing compile" off 3 "compile server build" off 4 "compile only no run" off 2>"$tmp"
clear
export iknowwhatimdoing=yes #this is is only for 6.0 beta since it yells at you if you dont have it
out=$(cat $tmp)
echo $out | grep 1
if [ "$?" -eq 0 ]; then
    cd /home/$USER/Desktop/git/mindustry
else
    cd /home/$USER/Desktop/git/mindustry
fi
gitout=$(git pull)
echo "$gitout" >> updatelogs.txt
echo $out | grep 2
if [ "$?" -eq 0 ]; then
    echo $out | grep 3
    if [ "$?" -eq 1 ]; then
        ./gradlew server:dist
    else
        ./gradlew desktop:dist
    fi
else
    echo "no recompile cheking if update is needed" 
    echo $gitout | grep -v "up to date"
    if [ "$?" -eq 0 ]; then
        echo "compiling"
        echo $out | grep 3
        if ["$?" -eq 1 ]; then
            ./gradlew server:dist
        else
            ./gradlew desktop:dist
        fi  
        notify-send "compile finished"
    fi
fi
echo $out | grep 4
if [ "$?" -eq 1 ]; then
        echo $out | grep 3
        if ["$?" -eq 1 ]; then
            if test -e desktop/build/libs/mindustry.jar; then
                echo "running"
                java -jar desktop/build/libs/mindustry.jar
            else
                echo "a compile is required as there is no jar to run"
                ./gradlew desktop:dist
                java -jar desktop/build/libs/mindustry.jar
            fi
        else
            if test -e server/build/libs/mindustry.jar; then
                echo "running"
                java -jar server/build/libs/mindustry.jar
            else
                echo "a compile is required as there is no jar to run"
                ./gradlew desktop:dist
                java -jar server/build/libs/mindustry.jar
            fi
        fi  
fi
rm $tmp

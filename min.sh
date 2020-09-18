#!/usr/bin/env bash
if [ "$#" -eq 0 ]; then
    inputs="-6.0 -desktop"
    echo "defaulting"
    echo "{"$inputs"} are the defaults this can be changed in line 4"
else
    inputs="$@"
    echo "$inputs"
fi
if echo $inputs | grep -qs "[-]6\.0" ; then
    cd ~/Desktop/git/mindustry
    echo 6.0 is selected
elif echo $inputs | grep -qs "[-]5\.0" ; then
    cd ~/Desktop/git/mindustry-client
    echo 5.0 client is selected
else
    echo [E] "version not passed as an input in any way"
    exit 1
fi
if echo $inputs|grep -qs "[-]desktop"; then
    git pull >~/last.update.txt 
    if cat ~/last.update.txt |grep -sv "up to date"; then
        ./gradlew desktop:dist
    fi
        echo "preparig desktop client"
        if test -e "desktop/build/libs/Mindustry.jar"; then
            echo "runnining mindustry client"
        else
            ./gradlew desktop:dist
            echo "rerun to play game"       
        fi
    export iknowwhatimdoing=yes
    read
    java -jar desktop/build/libs/Mindustry.jar >~/last.output.txt
elif echo $inputs | grep -sv "[-]server"; then
    git pull >~/last.update.txt | grep -qsv "Already up to date." && ./gradlew server:dist
    echo "preparing server"       
        if test -e "server/build/libs/Mindustry.jar"; then
            echo "running mindsutry server"
        else
            ./gradlew desktop:dist
        fi
    read 
    export iknowwhatimdoing=yes
    java -jar server/build/libs/Mindustry.jar >~/last.output.txt
echo
    echo [E] "what to compile not passed as an input in any way"
    exit 1
fi


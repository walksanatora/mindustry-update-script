#!/usr/bin/env bash
if test -e configure.cfg; then
    echo "config found loading config"
else
    echo "configuration is needed"
    ./configure.sh
fi
mindir=$(sed -n '1p' < config.cfg)
compile=$(sed -n '2p' < config.cfg)
run=$(sed -n '3p' < config.cfg)
scriptdir=$(pwd)
cd $mindir
gitout=$(git pull)
cd $scriptdir
echo $gitout >> update.txt
cd $mindir
echo $gitout | grep -v "up to date"
if [ "$?" -eq 0 ]; then
    echo "compiling"
    $compile
fi
if test -e desktop/build/libs/mindustry.jar; then
    echo "running"
    $run
else
    echo "compilng as file does not exist"
    $compile
    $run
fi

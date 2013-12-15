#!/bin/sh
DISTFILE=mapbbcode-latest.zip
TARGET=mapbbcode_fluxbb.zip

wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
mkdir files
mv mapbbcode files
wget -nv https://raw.github.com/MapBBCode/mapbbcode-loader/master/MapBBCodeLoader.min.js -O files/mapbbcode/MapBBCodeLoader.min.js

rm -f $TARGET
zip -qr $TARGET readme.txt files
rm -r files

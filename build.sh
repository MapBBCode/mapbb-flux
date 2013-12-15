#!/bin/sh
TARGET=mapbbcode_fluxbb.zip

DISTFILE=mapbbcode-latest.zip
wget -nv http://mapbbcode.org/dist/$DISTFILE
unzip -q $DISTFILE
rm $DISTFILE
mkdir files
mv mapbbcode files
wget -nv https://raw.github.com/MapBBCode/mapbbcode-loader/master/MapBBCodeLoader.min.js -O files/mapbbcode/MapBBCodeLoader.min.js
wget -nv https://raw.github.com/MapBBCode/mapbbcode-loader/master/mapbbcode-window.html -O files/mapbbcode/mapbbcode-window.html
# this is awesome line editing to fix mapbbcode path
printf '/force/\n-a\npath: ".",\n.\nw\n' | ed files/mapbbcode/mapbbcode-window.html

# now copy buttons for EZBBC and FluxToolbar
FLUXTB=files/img/fluxtoolbar/smooth
mkdir -p $FLUXTB
cp map_ft.png $FLUXTB/bt_map.png
EZBBC=files/plugins/ezbbc/style/Default/images
mkdir -p $EZBBC
cp map_ezbbc.png $EZBBC/map.png

rm -f $TARGET
zip -qr $TARGET readme.txt files
rm -r files

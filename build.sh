#!/bin/bash

which docker > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "This tool needs docker. Please install it first."
  exit 1
fi

docker images | grep ksoichiro/app-icons > /dev/null 2>&1
if [ $? -ne 0 ]; then
  docker build -t ksoichiro/app-icons .
fi

if [ ! -d .libs ]; then
  mkdir .libs
fi
if [ ! -d .libs/export_icons ]; then
  git clone git@github.com:ksoichiro/export_icons.git .libs/export_icons
fi

if [ -d dist ]; then
  rm -rf dist
  mkdir dist
fi

mkdir -p .tmp
for i in $(find src -type f -name "*.svg"); do
  file=`basename $i`
  sed -e 's/\(id=\"background\"\)/\1 style=\"display:none\"/' $i > .tmp/$file
  base=`echo $file | sed -e 's/\.[^\.]*$//'`
  docker run -t -i -v `pwd`:/workspace \
    -w /workspace \
    ksoichiro/app-icons \
    .libs/export_icons/export_icons.sh \
    -p /usr/bin/inkscape \
    -t Android \
    -i .tmp/$file \
    -s 24 \
    -o dist \
    -b $base \
    -f
  rm -f dist/$base/Android/*.png
done
rm -rf .tmp

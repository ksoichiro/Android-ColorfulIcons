#!/bin/bash

which export_icons > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "This tool needs export_icons. Please install it first."
  echo ""
  echo "  go get github.com/ksoichiro/export_icons"
  echo "or "
  echo "  brew tap ksoichiro/export_icons
  echo "  brew install export_icons
  exit 1
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
  export_icons \
    -t Android \
    -i .tmp/$file \
    -s 24 \
    -o dist \
    -b $base \
    -f
  rm -f dist/$base/Android/*.png
done
rm -rf .tmp

# Copy to sample Android app
cp -pR dist/Android/res app/src/main/


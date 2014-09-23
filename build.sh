#!/bin/bash

################################################################################
# Be careful! This script may take so much time.
# To avoid it, this script will not generate file
# if there are already built image.
#
# example:
#  ./build.sh -f src/ic_action_add.svg
#    --> generate holo dark png for ic_action_add.svg
#  ./build.sh -t holo_blue -f src/ic_action_add.svg
#    --> generate holo blue png for ic_action_add.svg
#  ./build.sh
#    --> generate holo dark png for all svgs
#  ./build.sh -a -f src/ic_action_add.svg
#    --> generate all colors for ic_action_add.svg
#        1 svg x 6 dpi x 35 colors -> 210 generations
#  ./build.sh -a
#    --> generate all colors for all svgs
#        100 svg x 6 dpi x 35 colors -> 21000 generations
################################################################################
#
which export_icons > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "This tool needs export_icons. Please install it first."
  echo ""
  echo "  go get github.com/ksoichiro/export_icons"
  echo "or "
  echo "  brew tap ksoichiro/export_icons"
  echo "  brew install export_icons"
  exit 1
fi

while getopts af:t: flag
do
  case ${flag} in
    a)
      ALL_TYPES=1;;
    f)
      TARGET=${OPTARG};;
    t)
      COLOR_TYPE=${OPTARG};;
  esac
done

if [ ! -z $TARGET ]; then
  echo "Generate only for ${TARGET}..."
fi
if [ ! -z $COLOR_TYPE ]; then
  echo "Color: ${COLOR_TYPE}"
fi

function gen() {
  local path=$1
  local file=`basename $1`
  local filename="${file%.*}"
  local icon_type=$2
  local color=$3
  local opacity=$4
  local dist=.tmp/$icon_type
  local suffix=_$icon_type
  if [ "$icon_type" == "holo_dark" ]; then
    suffix=
  fi
  local base=${filename}${suffix}

  if [ -e dist/${icon_type}/res/drawable-xhdpi/${base}.png ]; then
    echo "Skip ${base}.png"
  else
    sed -e 's/\(id=\"background\"\)/\1 style=\"display:none\"/' $path > .tmp/$file
    if [ -z $color ]; then
      color=#ffffff
    fi
    if [ -z $opacity ]; then
      opacity=0.8
    fi
    cp -p .tmp/$file .tmp/${file}.2
    sed -e "s/opacity:0.8;fill:#ffffff;/opacity:${opacity};fill:${color};/" .tmp/${file}.2 > .tmp/$file
    rm .tmp/${file}.2

    mkdir -p .tmp/$icon_type
    export_icons \
      -t Android \
      -i .tmp/$file \
      -s 24 \
      -o $dist \
      -b $base \
      -f
    rm -rf $dist/$base/Android/*.png
    if [ ! -d dist/$icon_type ]; then
      mkdir -p dist/$icon_type
    fi
    cp -pR $dist/Android/res dist/$icon_type/
  fi
  rm -rf $dist
}

function genHoloLight() {
  gen $1 "holo_light" "#333333" 0.6
}
function genHoloDark() {
  gen $1 "holo_dark" "#ffffff" 0.8
}
function genHoloBlue() {
  gen $1 "holo_blue" "#33b5e5" 0.8
}
function genHoloPurple() {
  gen $1 "holo_purple" "#aa66cc" 0.8
}
function genHoloGreen() {
  gen $1 "holo_green" "#99cc00" 0.8
}
function genHoloYellow() {
  gen $1 "holo_yellow" "#ffbb33" 0.8
}
function genHoloRed() {
  gen $1 "holo_red" "#ff4444" 0.8
}
function genHoloDarkBlue() {
  gen $1 "holo_dark_blue" "#0099cc" 0.8
}
function genHoloDarkPurple() {
  gen $1 "holo_dark_purple" "#9933cc" 0.8
}
function genHoloDarkGreen() {
  gen $1 "holo_dark_green" "#669900" 0.8
}
function genHoloDarkYellow() {
  gen $1 "holo_dark_yellow" "#ff8800" 0.8
}
function genHoloDarkRed() {
  gen $1 "holo_dark_red" "#cc0000" 0.8
}
function genMtrlRed() {
  gen $1 "mtrl_red" "#e51c23" 1.0
}
function genMtrlPink() {
  gen $1 "mtrl_pink" "#e91e63" 1.0
}
function genMtrlPurple() {
  gen $1 "mtrl_purple" "#9c27b0" 1.0
}
function genMtrlDeepPurple() {
  gen $1 "mtrl_deep_purple" "#673ab7" 1.0
}
function genMtrlIndigo() {
  gen $1 "mtrl_indigo" "#3f51b5" 1.0
}
function genMtrlBlue() {
  gen $1 "mtrl_blue" "#5677fc" 1.0
}
function genMtrlLightBlue() {
  gen $1 "mtrl_light_blue" "#03a9f4" 1.0
}
function genMtrlCyan() {
  gen $1 "mtrl_cyan" "#00bcd4" 1.0
}
function genMtrlTeal() {
  gen $1 "mtrl_teal" "#009688" 1.0
}
function genMtrlGreen() {
  gen $1 "mtrl_green" "#259b24" 1.0
}
function genMtrlLightGreen() {
  gen $1 "mtrl_light_green" "#8bc34a" 1.0
}
function genMtrlLime() {
  gen $1 "mtrl_lime" "#cddc39" 1.0
}
function genMtrlYellow() {
  gen $1 "mtrl_yellow" "#ffeb3b" 1.0
}
function genMtrlAmber() {
  gen $1 "mtrl_amber" "#ffc107" 1.0
}
function genMtrlOrange() {
  gen $1 "mtrl_orange" "#ff9800" 1.0
}
function genMtrlDeepOrange() {
  gen $1 "mtrl_deep_orange" "#ff5722" 1.0
}
function genMtrlBrown() {
  gen $1 "mtrl_brown" "#795548" 1.0
}
function genMtrlGrey() {
  gen $1 "mtrl_grey" "#9e9e9e" 1.0
}
function genMtrlBlueGrey() {
  gen $1 "mtrl_blue_grey" "#607d8b" 1.0
}
function genBlack() {
  gen $1 "black" "#000000" 1.0
}
function genWhite() {
  gen $1 "white" "#ffffff" 1.0
}

function genAllTypes() {
  genHoloLight      $1
  genHoloDark       $1
  genHoloBlue       $1
  genHoloPurple     $1
  genHoloGreen      $1
  genHoloYellow     $1
  genHoloRed        $1
  genHoloDarkBlue   $1
  genHoloDarkPurple $1
  genHoloDarkGreen  $1
  genHoloDarkYellow $1
  genHoloDarkRed    $1
  genMtrlRed        $1
  genMtrlPink       $1
  genMtrlPurple     $1
  genMtrlDeepPurple $1
  genMtrlIndigo     $1
  genMtrlBlue       $1
  genMtrlLightBlue  $1
  genMtrlCyan       $1
  genMtrlTeal       $1
  genMtrlGreen      $1
  genMtrlLightGreen $1
  genMtrlLime       $1
  genMtrlYellow     $1
  genMtrlAmber      $1
  genMtrlOrange     $1
  genMtrlDeepOrange $1
  genMtrlBrown      $1
  genMtrlGrey       $1
  genMtrlBlueGrey   $1
  genBlack          $1
  genWhite          $1
}

function genSomeIcons() {
  if [ ! -z $COLOR_TYPE ]; then
    case $COLOR_TYPE in
      "holo_light" )       genHoloLight      $1 ;;
      "holo_dark" )        genHoloDark       $1 ;;
      "holo_blue" )        genHoloBlue       $1 ;;
      "holo_purple" )      genHoloPurple     $1 ;;
      "holo_green" )       genHoloGreen      $1 ;;
      "holo_yellow" )      genHoloYellow     $1 ;;
      "holo_red" )         genHoloRed        $1 ;;
      "holo_dark_blue" )   genHoloDarkBlue   $1 ;;
      "holo_dark_purple" ) genHoloDarkPurple $1 ;;
      "holo_dark_green" )  genHoloDarkGreen  $1 ;;
      "holo_dark_yellow" ) genHoloDarkYellow $1 ;;
      "holo_dark_red" )    genHoloDarkRed    $1 ;;
      "mtrl_red" )         genMtrlRed        $1 ;;
      "mtrl_pink" )        genMtrlPink       $1 ;;
      "mtrl_purple" )      genMtrlPurple     $1 ;;
      "mtrl_deep_purple" ) genMtrlDeepPurple $1 ;;
      "mtrl_indigo" )      genMtrlIndigo     $1 ;;
      "mtrl_blue" )        genMtrlBlue       $1 ;;
      "mtrl_light_blue" )  genMtrlLightBlue  $1 ;;
      "mtrl_cyan" )        genMtrlCyan       $1 ;;
      "mtrl_teal" )        genMtrlTeal       $1 ;;
      "mtrl_green" )       genMtrlGreen      $1 ;;
      "mtrl_light_green" ) genMtrlLightGreen $1 ;;
      "mtrl_lime" )        genMtrlLime       $1 ;;
      "mtrl_yellow" )      genMtrlYellow     $1 ;;
      "mtrl_amber" )       genMtrlAmber      $1 ;;
      "mtrl_orange" )      genMtrlOrange     $1 ;;
      "mtrl_deep_orange" ) genMtrlDeepOrange $1 ;;
      "mtrl_brown" )       genMtrlBrown      $1 ;;
      "mtrl_grey" )        genMtrlGrey       $1 ;;
      "mtrl_blue_grey" )   genMtrlBlueGrey   $1 ;;
      "black" )            genBlack          $1 ;;
      "white" )            genWhite          $1 ;;
    esac
  elif [ -z $ALL_TYPES ]; then
    genHoloDark $1
  else
    genAllTypes $1
  fi
}

mkdir -p .tmp

if [ ! -d dist ]; then
  mkdir dist
fi

# all
if [ -z $TARGET ]; then
  for i in $(find src -type f -name "*.svg"); do
    genSomeIcons $i
  done
else
  genSomeIcons $TARGET
fi

rm -rf .tmp

# Copy to sample Android app
if [ -d dist/holo_dark ]; then
  cp -pR dist/holo_dark/res app/src/main/
fi


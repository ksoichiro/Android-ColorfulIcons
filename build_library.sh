#!/bin/sh

# Copy dist directory's icons to library

COLOR_TYPE=holo_dark

cp -pR dist/${COLOR_TYPE}/res/drawable-xhdpi library/src/main/res/
cp -pR dist/${COLOR_TYPE}/res/drawable-xxhdpi library/src/main/res/

for i in $(find library/src/main/res -type f); do
    if [[ "${i}" =~ ^ic_action_aci_ ]]; then
        # Ignore already renamed file
        continue
    fi
    mv ${i} ${i/ic_action_/ic_action_aci_}
done


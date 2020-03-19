#!/bin/bash

set -e
set -x

curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/"${SHOP_SYSTEM}"/"${SHOP_SYSTEM}"/releases | jq -r '.[] | .tag_name' | egrep -v [a-zA-Z] | head -3 > tmp.txt

sort -nr tmp.txt > "${COMPATIBILITY_FILE}"

if [[ $(git diff HEAD "${COMPATIBILITY_FILE}") != '' ]]; then
    git config --global user.name "Travis CI"
    git config --global user.email "wirecard@travis-ci.org"
    git add  "${COMPATIBILITY_FILE}"
    git commit -m "${SHOP_SYSTEM_UPDATE_COMMIT}"
    cd /home/travis/build/wirecard/"${SHOP_SYSTEM}"-ee/shop-extension-versions && git push https://"${GITHUB_TOKEN}"@github.com/brkicadis/shop-extension-versions.git HEAD:master
fi

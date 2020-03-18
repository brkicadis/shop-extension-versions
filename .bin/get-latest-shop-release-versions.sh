#!/bin/bash

set -e
set -x

DEFAULT_CONDITION=$(jq -r '.[] | .tag_name' | egrep -v [a-zA-Z] | head -3)
FILENAME=${SHOP_SYSTEM^^}_COMPATIBILITY_FILE

case ${SHOP_SYSTEM} in "prestashop") export CONDITION=jq -r '.[] | .tag_name' | egrep -v [a-zA-Z] | grep -v "^1.6";;
"woocommerce") export CONDITION=${DEFAULT_CONDITION};;
"magento2") export CONDITION=${DEFAULT_CONDITION};;
*)
esac

curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/"${SHOP_SYSTEM}"/"${SHOP_SYSTEM}"/releases | ${CONDITION} > tmp.txt

sort -nr tmp.txt > "${FILENAME}"

if [[ $(git diff HEAD "${FILENAME}") != '' ]]; then
    git config --global user.name "Travis CI"
    git config --global user.email "wirecard@travis-ci.org"
    git add  "${FILENAME}"
    git commit -m "${SHOP_SYSTEM_UPDATE_COMMIT}"
    cd /home/travis/build/wirecard/prestashop-ee/wirecardpaymentgateway/vendor/wirecard/shopsystem-ui-testsuite && git push https://"${GITHUB_TOKEN}"@github.com/wirecard/shopsystems-ui-testsuite.git HEAD:TPWDCEE-5954
fi

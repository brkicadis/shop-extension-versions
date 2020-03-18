#!/bin/bash

set -e
set -x

COMPATIBILITY_FILENAME=${SHOP_SYSTEM^^}_COMPATIBILITY_FILE
RELEASE_FILENAME=${SHOP_SYSTEM^^}_COMPATIBILITY_FILE

if [[ ${COMPATIBILITY_CHECK}  == "1" ]]; then
    cp "${COMPATIBILITY_FILENAME}" "${RELEASE_FILENAME}"
    git config --global user.name "Travis CI"
    git config --global user.email "wirecard@travis-ci.org"
    git add  "${RELEASE_FILENAME}"
    git commit -m "${SHOP_SYSTEM_UPDATE_COMMIT}"
    cd /home/travis/build/wirecard/prestashop-ee/wirecardpaymentgateway/vendor/wirecard/shopsystem-ui-testsuite && git push https://"${GITHUB_TOKEN}"@github.com/wirecard/shopsystems-ui-testsuite.git HEAD:TPWDCEE-5954
fi

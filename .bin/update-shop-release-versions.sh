#!/bin/bash

set -e
set -x

if [[ ${COMPATIBILITY_CHECK}  == "1" ]]; then
    cp "${COMPATIBILITY_FILE}" "${RELEASES_FILE}"
    git config --global user.name "Travis CI"
    git config --global user.email "wirecard@travis-ci.org"
    git add  "${RELEASES_FILE}"
    git commit -m "${SHOP_SYSTEM_UPDATE_COMMIT}"
    cd /home/travis/build/wirecard/prestashop-ee/shop-extension-versions && git push https://"${GITHUB_TOKEN}"@github.com/brkicadis/shop-extension-versions.git HEAD:TPWDCEE-5954
fi

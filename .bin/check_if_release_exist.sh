#!/bin/bash

set -e
set -x

cmp --silent "${RELEASES_FILE}" "${COMPATIBILITY_FILE}" && export COMPATIBILITY_CHECK=0 || export COMPATIBILITY_CHECK=1

if [[ "${COMPATIBILITY_CHECK}"  == "0" ]]; then
  export PRESTASHOP_VERSION=$(awk "NR==${PRESTASHOP_RELEASE_VERSION} {print; exit}" "${RELEASES_FILE}");
else
  export PRESTASHOP_VERSION=$(awk "NR==${PRESTASHOP_RELEASE_VERSION} {print; exit}" "${COMPATIBILITY_FILE}");
fi

echo "Testing with Prestashop version ${PRESTASHOP_VERSION}"

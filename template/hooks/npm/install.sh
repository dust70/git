#!/bin/sh

PACKAGE_JSON="${PWD}"/package.json
RESULT=0

if test -e "${PACKAGE_JSON}" && hash npm > /dev/null 2>&1; then
    case "${1}" in
        post-checkout | post-merge)
            npm install; RESULT=$?
            ;;
    esac
fi

exit ${RESULT}

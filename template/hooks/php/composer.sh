#!/bin/bash

GIT_DIR="${GIT_DIR:-${PWD}/.git}"
source "${GIT_DIR}"/hooks/config.sh

if hash composer > /dev/null 2>&1; then
    COMPOSER="composer"
else
    COMPOSER="${PROJECT_DIR}"/bin/composer

    if [ ! -e "${COMPOSER}" ]; then
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

        EXPECTED_SIGNATURE=$(wget https://composer.github.io/installer.sig -O - -q)
        ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

        if [ "${EXPECTED_SIGNATURE}" = "${ACTUAL_SIGNATURE}" ]; then
            mkdir bin >> /dev/null 2>&1
            php ./composer-setup.php --install-dir="bin" --filename=composer
        fi

        rm -f ./composer-setup.php
    fi

    COMPOSER="php ${COMPOSER}"
fi

"${COMPOSER}" install --no-interaction --optimize-autoloader --prefer-source

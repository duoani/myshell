#!/bin/bash

# This is a simple shell script for php-fpm manipulation.
# Such as start, stop or restart php-fpm process.
# This script require an Environment Varible [PHP_HOME] to
# assign the PHP installation directory.
# 
# You can export the PHP installation directory in ~/.bashrc:
# export PHP_HOME=/usr/local/php

PHP_DIR="$PHP_HOME"
PHP_CONFIG="${PHP_DIR}/etc/php.ini"

echo "PHP install in: $PHP_DIR"

function init(){
    while [ true ]
    do
        if [ -z "$1" ]; then
            exit 0
            break
        fi

        case $1 in
            start)
                start
                ;;

            restart)
                restart
                ;;

            stop)
                stop
                ;;

            *)
                echo "Unknown param: $1"
                usage
                ;;
        esac
        shift
    done
}

function stop(){
    echo "Trying to stop php-fpm..."
    PID=$(cat "${PHP_DIR}/var/run/php-fpm.pid")
    sudo kill -INT $PID

    if [ $? -eq 0 ] ; then
        echo '[OK] php-fpm is stoped.'
    else
        echo '[Error] php-fpm can not be stop!'
        return 1
    fi
}

function start(){
    echo "Trying to start php-fpm..."
    echo "Use configuration file: $PHP_CONFIG"
    eval "sudo php-fpm -c $PHP_CONFIG"

    if [ $? -eq 0 ]; then
        echo '[OK] php-fpm is started now.'
    else
        echo '[Error] php-fpm can not be start!'
        return 1
    fi
}

function restart(){
    stop

    if [ $? -eq 0  ] ; then
        start
    fi
}

function usage(){
    echo "Usage: phpfpm.sh [stop | start | restart]"
}

init $@

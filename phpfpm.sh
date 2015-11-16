#!/bin/bash

PHP_DIR="$PHP_HOME"
PHP_CONFIG="${PHP_DIR}/etc/php.ini"


echo $PHP_DIR

function init(){
    echo $@
    while [ true ]
    do
        echo "\$1:$1"
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
    PID=$(cat "${PHP_DIR}/var/run/php-fpm.pid")
    echo "Kill pid: $PID"
    #kill -INT $PID
}

function start(){
    echo ""
}

function restart(){
    stop
    start
}

function usage(){
    echo "Usage: phpfpm [stop | start | restart]"
}

init $@

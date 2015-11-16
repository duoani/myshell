#!/bin/bash

# This is a simple shell script for Nginx server manipulation.
# Such as start, stop or restart nginx server.
# This script require an Environment Varible [NGINX_HOME] to
# assign the nginx installation directory.
# 
# You can export the nginx installation directory in ~/.bashrc:
# export NGINX_HOME=/usr/local/nginx

NGINX_DIR="$NGINX_HOME"
echo "Nginx install in: $NGINX_DIR"

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
    echo "Trying to stop Nginx..."

    eval "sudo ${NGINX_DIR}/sbin/nginx -s stop"

    if [ $? -eq 0 ] ; then
        echo '[OK] Nginx is stoped.'
    else
        echo '[Error] Nginx can not be stop!'
        return 1
    fi
}

function start(){
    echo "Trying to start Nginx..."
    eval "sudo ${NGINX_DIR}/sbin/nginx"

    if [ $? -eq 0 ]; then
        echo '[OK] Nginx is started now.'
    else
        echo '[Error] Nginx can not be start!'
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
    echo "Usage: nginx.sh [stop | start | restart]"
}

init $@

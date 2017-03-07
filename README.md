# docker-php-xdebug

xdebug workaround for php in docker on Windows

This docker image extending my [other](https://github.com/andrdru/docker-php-fpm) docker image

Warning! Use this image for development only

## Requirements

- Docker and docker-compose on Windows

## Description

On Windows Docker creates DockerNAT virtual net(10.0.75.0 by default), where host machine on 10.0.75.1 and Docker containers on 10.0.75.2

## Usage

0. Switch off your windows brandmauer, or add exception rule
1. add local alias to %SYSTEMROOT%\System32\drivers\etc\hosts
```
10.0.75.2 site.local
```
2. Checkout this repository
3. **cd ./example && docker-compose start -d**
4. default debug port is **9001**  
For PhpStorm:
- File->Settings PHP->Debug Xdebug Debug port 9001
- Run->Start listening for PHP Debug Connections

Open http://site.local in browser. Now you can debug PHP locally using xDebug on Docker.

#!/bin/sh
mkdir -p log
docker run -d -p 8008:80 -v `pwd`/log:/var/log/apache2 oligot/filter

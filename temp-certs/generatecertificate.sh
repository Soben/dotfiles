#!/bin/bash

openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout ./cog.test.key -out ./cog.test.crt -config ./openssl.cnf
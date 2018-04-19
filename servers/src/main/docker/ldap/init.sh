#!/bin/bash
set -e

/usr/local/bin/dockerize -wait tcp://localhost:10389 -wait-retry-interval 2s -timeout 600s
ldapmodify -h localhost -p 10389 -D "uid=admin,ou=system" -w secret -a -f init.ldif



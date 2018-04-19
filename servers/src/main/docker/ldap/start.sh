#!/bin/bash
set -e

/opt/init.sh &
/opt/apacheds/bin/apacheds.sh "$@"

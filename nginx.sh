#!/bin/bash -v

DEBIAN_FRONTEND=noninteractive apt-get update
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y -qq
DEBIAN_FRONTEND=noninteractive apt-get install -y -qq apt-transport-https ca-certificates nginx curl >/dev/null

service nginx start
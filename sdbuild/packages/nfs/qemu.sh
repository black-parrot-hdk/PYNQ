#!/bin/bash

set -e
set -x

. /etc/environment
for f in /etc/profile.d/*.sh; do source $f; done

export HOME=/root
export BOARD=${PYNQ_BOARD}

apt-get update -y
apt-get install -y nfs-common

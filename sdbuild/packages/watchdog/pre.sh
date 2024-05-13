#!/bin/bash

set -x
set -e

target=$1
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo cp $script_dir/wdt-heartbeat.sh $target/usr/bin/.
sudo chmod +x $target/usr/bin/wdt-heartbeat.sh

sudo cp $script_dir/wdt-heartbeat.service $target/lib/systemd/system/.
sudo chmod 644 $target/lib/systemd/system/wdt-heartbeat.service
sudo ln -s -r $target/lib/systemd/system/wdt-heartbeat.service $target/lib/systemd/system/multi-user.target.wants/.

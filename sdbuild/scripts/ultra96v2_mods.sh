#!/bin/bash

set -e
set -x

target=$1

# Assign static IP to eth0
sudo bash -c "cat > $target/etc/network/interfaces.d/eth0" << EOL
allow-hotplug eth0
iface eth0 inet static
    address 192.168.3.1
    netmask 255.255.255.0
EOL

# Create and enable the wdt-heartbeat systemd service
sudo bash -c "cat - > $target/usr/bin/wdt-heartbeat.sh" << EOL
echo "Starting wdt heartbeat..."

while true
do
    echo s > /dev/watchdog0;
    sleep 2;
done
EOL
sudo chmod +x $target/usr/bin/wdt-heartbeat.sh

sudo bash -c "cat > $target/lib/systemd/system/wdt-heartbeat.service" << EOL
[Unit]
Description=Watchdog timer heartbeat systemd service.

[Service]
Type=simple
ExecStart=/bin/bash /usr/bin/wdt-heartbeat.sh

[Install]
WantedBy=multi-user.target
EOL
sudo chmod 644 $target/lib/systemd/system/wdt-heartbeat.service
sudo ln -s -r $target/lib/systemd/system/wdt-heartbeat.service $target/lib/systemd/system/multi-user.target.wants/.

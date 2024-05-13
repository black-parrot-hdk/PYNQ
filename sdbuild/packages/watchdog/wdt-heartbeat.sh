echo "Starting wdt heartbeat..."

while true
do
    echo s > /dev/watchdog0;
    sleep 2;
done

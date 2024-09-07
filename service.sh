#!/system/bin/sh

MODDIR=${0%/*}

# This script will be executed in late_start service mode
if [ ! -f "$MODDIR"/disable ]; then
    # Wait for the system to boot up before launching juicity
    until [ $(getprop sys.boot_completed) -eq 1 ]; do
        sleep 3
        $MODDIR/juicity.init start
        break
    done
fi


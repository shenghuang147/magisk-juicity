#!/system/bin/sh

MODDIR=${0%/*}

# This script will be executed in late_start service mode
if [ ! -f "$MODDIR"/disable ]; then
    $MODDIR/juicity.init start
fi

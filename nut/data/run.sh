#!/bin/bash
set -e

CONFIG_PATH=/data/options.json

# Generate upsd.users
echo "[INFO] Generate upsd.users"
LOGINS=$(jq --raw-output ".logins | length" $CONFIG_PATH)

echo "" > /etc/nut/upsd.users
if [ "$LOGINS" -gt "0" ]; then
    for (( i=0; i < "$LOGINS"; i++ )); do
        USERNAME=$(jq --raw-output ".logins[$i].username" $CONFIG_PATH)
        PASSWORD=$(jq --raw-output ".logins[$i].password" $CONFIG_PATH)
        INSTCMDS=$(jq --raw-output ".logins[$i].instcmds" $CONFIG_PATH)
	    echo "[$USERNAME]"            >> /etc/nut/upsd.users
        echo "  password = $PASSWORD" >> /etc/nut/upsd.users
        echo "  instcmds = $INSTCMDS" >> /etc/nut/upsd.users
        echo ""                       >> /etc/nut/upsd.users
    done
fi

# Generate ups.conf
echo "[INFO] Generate ups.conf"
BATTERY=$(jq --raw-output ".battery | length" $CONFIG_PATH)
RUNTIMECAL=$(jq --raw-output ".runtimecal | length" $CONFIG_PATH)
UPS=$(jq --raw-output ".ups | length" $CONFIG_PATH)
echo "" > /etc/nut/ups.conf
if [ "$UPS" -gt "0" ]; then
    for (( i=0; i < "$LOGINS"; i++ )); do
        UPSNAME=$(jq --raw-output ".ups[$i].upsname" $CONFIG_PATH)
        DRIVER=$(jq --raw-output ".ups[$i].driver" $CONFIG_PATH)
        PORT=$(jq --raw-output ".ups[$i].port" $CONFIG_PATH)
        PROTOCOL=$(jq --raw-output ".ups[$i].protocol" $CONFIG_PATH)
        VENDORID=$(jq --raw-output ".ups[$i].vendorid" $CONFIG_PATH)
        PRODUCTID=$(jq --raw-output ".ups[$i].productid" $CONFIG_PATH)
        DESC=$(jq --raw-output ".ups[$i].desc" $CONFIG_PATH)
        BATTVOLTHIGH=$(jq --raw-output ".battery[$i].battery_voltage_high" $CONFIG_PATH)
        BATTVOLTLOW=$(jq --raw-output ".battery[$i].battery_voltage_low" $CONFIG_PATH)
        CHARGETIME=$(jq --raw-output ".battery[$i].charge_time" $CONFIG_PATH)
        IDLELOAD=$(jq --raw-output ".battery[$i].idle_load" $CONFIG_PATH)
        RUNTIME1=$(jq --raw-output ".runtimecal[$i].runtime1" $CONFIG_PATH)
        POWER1=$(jq --raw-output ".runtimecal[$i].power1" $CONFIG_PATH)
        RUNTIME2=$(jq --raw-output ".runtimecal[$i].runtime2" $CONFIG_PATH)
        POWER2=$(jq --raw-output ".runtimecal[$i].power2" $CONFIG_PATH)
        echo "[$UPSNAME]"         >> /etc/nut/ups.conf
        echo "  driver = $DRIVER" >> /etc/nut/ups.conf
        echo "  port = $PORT"	  >> /etc/nut/ups.conf
        if [ "$PROTOCOL" != "null" ]; then
            echo "  protocol = $PROTOCOL"     >> /etc/nut/ups.conf
        fi
        if [ "$VENDORID" != "null" ]; then
            echo "  vendorid = $VENDORID"     >> /etc/nut/ups.conf
        fi
        if [ "$PRODUCTID" != "null" ]; then
            echo "  productid = $PRODUCTID"   >> /etc/nut/ups.conf
        fi
        if [ "$BATTVOLTHIGH" != "null" ]; then
            echo "  default.battery.voltage.high = $BATTVOLTHIGH"     >> /etc/nut/ups.conf
        fi
        if [ "$BATTVOLTLOW" != "null" ]; then
            echo "  default.battery.voltage.low = $BATTVOLTLOW"   >> /etc/nut/ups.conf
        fi        
        if [ "$CHARGETIME" != "null" ]; then
            echo "  chargetime = $CHARGETIME"   >> /etc/nut/ups.conf
        fi
        if [ "$IDLELOAD" != "null" ]; then
            echo "  idleload = $IDLELOAD"   >> /etc/nut/ups.conf
        fi 
        echo "  runtimecal = $RUNTIME1,$POWER1,$RUNTIME2,$POWER2" >> /etc/nut/ups.conf
        echo "  desc = $DESC"             >> /etc/nut/ups.conf
        echo ""                           >> /etc/nut/ups.conf
    done
fi

# Generate upsd.conf
echo "[INFO] Generate upsd.conf"
BINDADDR=$(jq --raw-output ".bindaddr" $CONFIG_PATH)
BINDPORT=$(jq --raw-output ".bindport" $CONFIG_PATH)
echo "LISTEN $BINDADDR $BINDPORT" > /etc/nut/upsd.conf

# Generate nut.conf
echo "[INFO] Generate nut.conf"
MODE=$(jq --raw-output ".mode" $CONFIG_PATH)
echo "MODE=$MODE" > /etc/nut/nut.conf

# change perms on config files
chmod 660 /etc/nut/*

# grant access to all usb devices
chmod 777 /dev/bus/usb/*/*

echo "[INFO] running NUT..."
upsdrvctl start
upsd -D

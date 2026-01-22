#!/usr/bin/env bash

# Paths from NixOS packages
I2CSET=/run/current-system/sw/bin/i2cset
I2CDETECT=/run/current-system/sw/bin/i2cdetect
LOGGER=/run/current-system/sw/bin/logger
MODPROBE=/run/current-system/sw/sbin/modprobe
AWK=/run/current-system/sw/bin/awk
SED=/run/current-system/sw/bin/sed

export TERM=linux

# Load i2c-dev in case kernel module wasn't loaded yet
$MODPROBE i2c-dev

laptop_model=$(</sys/class/dmi/id/product_name)
echo "Laptop model: $laptop_model" | $LOGGER

# Wait until at least one i2c bus exists
until ls /sys/class/i2c-dev/i2c-* 1>/dev/null 2>&1; do
    sleep 1
done

# Function to find the correct I2C bus
find_i2c_bus() {
    local adapter_description="Synopsys DesignWare I2C adapter"
    local dw_count=$($I2CDETECT -l | grep -c "$adapter_description")

    local bus_index=3
    [[ "$laptop_model" == "83L0" ]] && bus_index=2

    if [ "$dw_count" -lt "$bus_index" ]; then
        echo "Error: Less than $bus_index DesignWare I2C adapters found." | $LOGGER
        return 1
    fi

    local bus_number=$($I2CDETECT -l | grep "$adapter_description" | $AWK '{print $1}' | $SED 's/i2c-//' | $SED -n "${bus_index}p")
    echo "$bus_number"
}

i2c_bus=$(find_i2c_bus)
if [ -z "$i2c_bus" ]; then
    echo "Error: Could not find the DesignWare I2C bus for the audio IC." | $LOGGER
    exit 1
fi

echo "Using I2C bus: $i2c_bus" | $LOGGER

if [[ "$laptop_model" == "83BY" ]]; then
    i2c_addr=(0x39 0x38 0x3d 0x3b)
else
    i2c_addr=(0x3f 0x38)
fi

count=0
for value in "${i2c_addr[@]}"; do
    val=$((count % 2))

    # Sequence of I2C writes to initialize speakers
    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x7f 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x01 0x01
    $I2CSET -f -y "$i2c_bus" "$value" 0x0e 0xc4
    $I2CSET -f -y "$i2c_bus" "$value" 0x0f 0x40
    $I2CSET -f -y "$i2c_bus" "$value" 0x5c 0xd9
    $I2CSET -f -y "$i2c_bus" "$value" 0x60 0x10

    if [ $val -eq 0 ]; then
        $I2CSET -f -y "$i2c_bus" "$value" 0x0a 0x1e
    else
        $I2CSET -f -y "$i2c_bus" "$value" 0x0a 0x2e
    fi

    $I2CSET -f -y "$i2c_bus" "$value" 0x0d 0x01
    $I2CSET -f -y "$i2c_bus" "$value" 0x16 0x40
    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x01
    $I2CSET -f -y "$i2c_bus" "$value" 0x17 0xc8
    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x04
    $I2CSET -f -y "$i2c_bus" "$value" 0x30 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x31 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x32 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x33 0x01

    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x08
    $I2CSET -f -y "$i2c_bus" "$value" 0x18 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x19 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x1a 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x1b 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x28 0x40
    $I2CSET -f -y "$i2c_bus" "$value" 0x29 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x2a 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x2b 0x00

    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x0a
    $I2CSET -f -y "$i2c_bus" "$value" 0x48 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x49 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x4a 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x4b 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x58 0x40
    $I2CSET -f -y "$i2c_bus" "$value" 0x59 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x5a 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x5b 0x00

    $I2CSET -f -y "$i2c_bus" "$value" 0x00 0x00
    $I2CSET -f -y "$i2c_bus" "$value" 0x02 0x00

    count=$((count + 1))
done

echo "Speaker init completed" | $LOGGER

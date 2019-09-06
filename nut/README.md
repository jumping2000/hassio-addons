## Network UPS Tools for Hass.io

[Network UPS Tools](http://networkupstools.org/) can be used to control and manage several power devices like [Uninterruptible Power Supplies](https://en.wikipedia.org/wiki/Uninterruptible_power_supply). This [Hass.io](https://home-assistant.io/hassio/) plugin provides the necessary daemon to make use of the [Home Assistant NUT Sensor](https://home-assistant.io/components/sensor.nut/).

The default configuration was adapted to work with Tecnoware ERA+ UPS which uses the [blazer_usb](https://networkupstools.org/docs/man/blazer_usb.html) driver. The UPS sensors can be added to `configuration.yaml` by adding:


```
sensor:
  - platform: nut
    name: "Tecnoware UPS"
    host: IP_ADDRESS_OF_YOUR_HOST
    port: 3493
    username: USERNAME
    password: PASSWORD
    resources:
      - battery.charge
      - battery.runtime
      - battery.voltage
      - ups.load
      - ups.status.display
      - input.voltage
      - output.voltage
      - input.frequency
      [...]


```
The addon configuration uses some parameters to calculate runtime estimation and battery charge:

**Runtimecalc**
This takes two runtimes at different loads. Typically, this uses the runtime at full load and the runtime at half load. For instance, if your UPS has a rated runtime of 240 seconds at full load and 720 seconds at half load, you would enter: 240,100,720,50

**Battery Charge**

battery voltage high: Maximum battery voltage that is reached after about 12 to 24 hours charging.
battery voltage low: Minimum battery voltage just before the UPS automatically shuts down.
chargetime: The time needed to fully recharge the battery after being fully discharged. If not specified, the driver defaults to 43200 seconds (12 hours)

`The resources vary depending on your UPS vendor/model`

All supported USB UPS should work using one of the [USB drivers](http://networkupstools.org/stable-hcl.html) as well. Due to the lack of hardware some code changes might be neccessary in order to get serial or network UPS connections to work. Requests, feedback and pull request are welcome.

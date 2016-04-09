FROM resin/rpi-raspbian:jessie-20160401
CMD modprobe w1-gpio && modprobe w1-therm && while true; do echo 'ohai'; sleep 10; done

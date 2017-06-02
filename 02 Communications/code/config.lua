-- CONSTANTS

-- Thing
THING_ID = node.chipid()

-- Actuators
PIN_LED = 1

-- Sensors
PIN_BUTTON = 2

-- WiFi
AP = "IOT-GW-01" --Name of the access point to connect
PASSWORD =  "IOT-PASS-01" --Password for the access point

-- MQTT
MQTT_BROKER_IP = ""
MQTT_BROKER_PORT = 1883
MQTT_TOPIC = THING_ID
MQTT_CLIENT = THING_ID

-- CONSTANTS

-- Thing
THING_ID = node.chipid()

-- Actuators
PIN_LED = 1

-- Sensors
PIN_BUTTON = 2

-- WiFi
AP = "" -- TODO: Name of the access point to connect
PASSWORD =  "" -- TODO: Password for the access point

-- MQTT
MQTT_BROKER_IP = ""  -- TODO: IP of your machine
MQTT_BROKER_PORT = 1883
MQTT_TOPIC = THING_ID
MQTT_CLIENT = THING_ID

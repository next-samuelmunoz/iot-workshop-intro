require "config"  --Import constants

-- Actuator LED
function mqtt_led(client, topic, message)
  print("[MQTT] Topic: "..topic.."    Message: "..message)
  if message == "1" then
    print("[LED] On")
    gpio.write(PIN_LED, gpio.HIGH)
  elseif message == "0" then
    print("[LED] Off")
    gpio.write(PIN_LED, gpio.LOW)
  end
end

-- Sensor Button
function button_cb(level, when)
  MQTT_CLIENT:publish(MQTT_TOPIC.."/BUTTON", "1", 0 ,0,
    function(client) print("[MQTT] Publish") end
  )
end


-- MQTT Events
function mqtt_connected(client)
  print("[MQTT] Connected")
  MQTT_CLIENT:subscribe(MQTT_TOPIC.."/LED", 0,
    function(client) print("[MQTT] Subscribed (LED)") end
  )
end

function mqtt_disconnected(client, reason)
  print("[MQTT] Disconnected: "..reason)
  tmr.create():alarm(30000, tmr.ALARM_SINGLE, mqtt_connect)
end

function mqtt_connect()
  MQTT_CLIENT:connect(MQTT_BROKER_IP, MQTT_BROKER_PORT, 0, 0,
    mqtt_connected, mqtt_disconnected
  )
end

-- Callback function when WiFi connects...
function print_ip()
  addr, nm, gw = wifi.sta.getip()
  print("[WIFI] GOTIP: "..addr)
  -- Configure Pins
  gpio.mode(pin_led, gpio.OUTPUT)
  gpio.mode(pin_button, gpio.INT, gpio.PULLUP)
  gpio.trig(pin_button, "down", button_cb)
  -- Configure MQTT connection
  MQTT_CLIENT = mqtt.Client(THING_ID, 120)
  MQTT_CLIENT:on("message", mqtt_led)
  mqtt_connect()
end

-- WiFi events
wifi.setmode(wifi.STATION)
wifi.sta.eventMonReg(wifi.STA_GOTIP, print_ip)
wifi.sta.eventMonReg(wifi.STA_IDLE, function() print("[WIFI] IDLE") end)
wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() print("[WIFI] CONNECTING") end)
wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function() print("[WIFI] WRONG_PASSWORD") end)
wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function() print("[WIFI] NO_AP_FOUND") end)
wifi.sta.eventMonReg(wifi.STA_FAIL, function() print("[WIFI] CONNECT_FAIL") end)

-- Launch WiFi
print("[NODEMCU] Thing Id: "..THING_ID)
wifi.sta.eventMonStart()
wifi.sta.config(AP, PASSWORD)

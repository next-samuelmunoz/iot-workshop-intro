require "config"  --Import constants

-- Callback function when WiFi connects...
function print_ip()
  addr, nm, gw = wifi.sta.getip()
  print("[WIFI] GOTIP: "..addr)
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

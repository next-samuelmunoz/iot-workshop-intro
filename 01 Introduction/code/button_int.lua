pin_led = 1  -- Board pin attached to the LED
pin_button = 2
-- Configuration
gpio.mode(pin_led, gpio.OUTPUT)
gpio.mode(pin_button, gpio.INT, gpio.PULLUP)

function cb_led(level, when)
  if level == gpio.HIGH then
    gpio.write(pin_led, gpio.LOW)
  else
    gpio.write(pin_led, gpio.HIGH)
  end
end

gpio.trig(pin_button, "both", cb_led)

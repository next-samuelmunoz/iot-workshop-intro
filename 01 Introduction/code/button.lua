pin_led = 1  -- Board pin attached to the LED
pin_button = 2
wait_seconds = 1*100000  -- Read every 0,1 sg
-- Configuration
gpio.mode(pin_led, gpio.OUTPUT)
gpio.mode(pin_button, gpio.INPUT, gpio.PULLUP) -- Default value is High
-- When pressed, button is LOW, when released, high.
repeat
  button_val = gpio.read(pin_button)
  if button_val == gpio.HIGH then
    gpio.write(pin_led, gpio.LOW)
  else
    gpio.write(pin_led, gpio.HIGH)
  end
  tmr.delay(wait_seconds)
until True

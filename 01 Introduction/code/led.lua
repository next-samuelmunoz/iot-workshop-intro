pin_led = 1  -- Board pin attached to the LED
wait_seconds = 1*1000000  -- Seconds to wait before changing state
gpio.mode(pin_led, gpio.OUTPUT) -- Set pin to output
repeat
  gpio.write(pin_led, gpio.HIGH)  -- Set pin to 3,3V
  tmr.delay(wait_seconds)
  gpio.write(pin_led, gpio.LOW)  -- Set pin to 0V
  tmr.delay(wait_seconds)
until True

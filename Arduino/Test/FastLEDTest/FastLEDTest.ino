// FastLED test
// dps
// 29 march 2014

#include <FastLED.h>
#define NUM_LEDS 128
#define DATA_PIN 6

CRGB leds[NUM_LEDS];

void setup()
{
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  
  for(int i = 0; i < NUM_LEDS; i++)
  {
    leds[i].setRGB(255, 0, 255); // purple
  }
  
  FastLED.show();
}

void loop()
{
  // derp
}

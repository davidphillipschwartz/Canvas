// FastLED test code
// david schwartz
// 9 march 2014

#include <FastLED.h>
#define  NUM_LEDS 4
#define DATA_PIN 6

CRGB leds[NUM_LEDS]

void setup()
{
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
}

void loop()
{
  leds[0] = CRGB::Red;
  leds[1] = CRGB::Blue;
  leds[2] = CRGB::Green;
  leds[3] = CRGB::Purple;
  
  FastLED.show();
  delay(30);
}


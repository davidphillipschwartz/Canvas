// firmware for canvas
// david schwartz
// 8 march 2014

// NOTE: all code related to Serial1 must be commented out on the Uno boards

#include <FastLED.h>
#define NUM_LEDS 4
#define DATA_PIN 6

byte buffer;
CRGB leds[NUM_LEDS];

void setup()
{
  // MIDI over pins 0 and 1
  Serial.begin(31250);
  
  // USB - PC over pins 18 and 19
  //Serial1.begin(9600);
  
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
}

void loop()
{
  // check for MIDI
  if(Serial.available())
  {
    // process MIDI
  }
  // check for data from PC
  /*
  else if(Serial1.available())
  {
    // process data from PC
  }
  */
  
}

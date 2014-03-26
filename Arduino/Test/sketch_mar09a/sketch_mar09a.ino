// FastLED test code
// david schwartz
// 9 march 2014

#include <FastLED.h>
#include <MIDI.h>
#define  NUM_LEDS 4
#define DATA_PIN 6

CRGB leds[NUM_LEDS];
unsigned char index = 0;
CRGB colours[4] = {CRGB::Red, CRGB::Blue, CRGB::Green, CRGB::Purple};

void callbackNoteOn(byte channel, byte note, byte velocity)
{
  if(velocity != 0)
  {
    leds[0] = colours[index];
    leds[1] = colours[(index+1)%4];
    leds[2] = colours[(index+2)%4];
    leds[3] = colours[(index+3)%4];
  
    FastLED.show();
  
    index++;
    index %= 4;
  }
}

void setup()
{
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
  MIDI.begin();
  MIDI.setHandleNoteOn(callbackNoteOn);
}

void loop()
{
  MIDI.read();
}


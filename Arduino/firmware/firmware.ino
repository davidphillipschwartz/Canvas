// firmware for canvas
// david schwartz
// 8 march 2014

// NOTE: all code related to Serial1 must be commented out on the Uno boards

#include <FastLED.h>
#include <MIDI.h>
#define NUM_LEDS 4
#define DATA_PIN 6

MIDI_CREATE_INSTANCE(HardwareSerial, Serial1, Midi);

byte buffer;
CRGB leds[NUM_LEDS];
unsigned char index = 0;
CRGB colours[4] = {CRGB::Red, CRGB::Blue, CRGB::Green, CRGB::Purple};

void callbackNoteOn(byte channel, byte note, byte velocity)
{
  if(velocity != 0)  // some implementations use Note On with Velocity = 0 instead of Note Off
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

void callbackClock(void)
{
  
}

void setup()
{
  // MIDI over pins 18 and 19
  Midi.begin();
  Midi.setHandleNoteOn(callbackNoteOn);
  Midi.setHandleClock(callbackClock);
  
  // USB - PC over pins 0 and 1
  Serial.begin(9600);
  
  FastLED.addLeds<NEOPIXEL, DATA_PIN>(leds, NUM_LEDS);
}

void loop()
{
  // check for MIDI
  if(Midi.read())
  {
    // process MIDI
  }
  // check for data from PC
  else if(Serial.available())
  {
    // process data from PC
  }
  
}

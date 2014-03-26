// firmware for canvas
// david schwartz
// 8 march 2014

// NOTE: all code related to Serial1 must be commented out on the Uno boards

#include <FastLED.h>
#include <MIDI.h>
#define NUM_LEDS 128
#define DATA_PIN 6

MIDI_CREATE_INSTANCE(HardwareSerial, Serial1, Midi);

CRGB leds[NUM_LEDS];

void callbackNoteOn(byte channel, byte note, byte velocity)
{
  if(velocity != 0)  // some implementations use Note On with Velocity = 0 instead of Note Off
  {
    // switch pattern
  }
}

void callbackClock(void)
{
  // show frame
}

void parseSerialInput()
{
  byte width, height, length;
  
  // read the size bytes
  while(true)
  {
    if(Serial.available() >= 3)
    {
      width = Serial.read();
      height = Serial.read();
      length = Serial.read();
      
      Serial.write(width);
      Serial.write(height);
      Serial.write(length);
      
      break;
    }
  }

  // read the colours
  byte red, green, blue;
  int counter = 0;
  
  while(true)
  {
    // stop once we have read 3 colour bytes per LED
    if(counter == NUM_LEDS)
      break;
    
    if(Serial.available() >= 3)
    {
      red = Serial.read();
      green = Serial.read();
      blue = Serial.read();
      
      leds[counter].setRGB(red, green, blue);
      counter++;
    }
  }
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
  // check for MIDI & trigger callbacks
  if(Midi.read());
  
  // check for data from PC
  else if(Serial.available())
  {
    // process data from PC
    parseSerialInput();
    FastLED.show();
  }
  
}

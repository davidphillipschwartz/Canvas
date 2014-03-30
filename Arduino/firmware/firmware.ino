// firmware for canvas
// david schwartz
// 8 march 2014

#include <FastLED.h>
#include <MIDI.h>
#include <SD.h>
#define NUM_LEDS 128
#define DATA_PIN 6
#define SPI_CS 53
#define BAUD_RATE 9600

byte width = 1, height = 1, length = 1;
byte frameIndex = 0;

MIDI_CREATE_INSTANCE(HardwareSerial, Serial1, Midi);

CRGB leds[NUM_LEDS];

// ---------------------------------------------------------------------- //

void callbackClock(void)
{
  // show frame
  FastLED.show();
  
  frameIndex++;
  frameIndex %= length;
}

void callbackNoteOn(byte channel, byte note, byte velocity)
{
  if(velocity != 0)  // some implementations use Note On with Velocity = 0 instead of Note Off
  {
    File patternFile = SD.open("test.txt");
    width = patternFile.read();
    height = patternFile.read();
    length = patternFile.read();
    
    byte index, red, green, blue;
    
    // switch pattern
    for(byte x = 0; x < width; x++)
    {
      for(byte y = 0; y < height; y++)
      {
        for(byte q = 0; q < 4; q++)
        {
           index = 4 * (width * height * frameIndex + width * y + x) + q;
           
           red = patternFile.read();
           green = patternFile.read();
           blue = patternFile.read();
           
           leds[index].setRGB(red, green, blue);
        }
      }
    }
    
    callbackClock();
  }
}

void parseSerialInput()
{ 
  // open file
  SD.remove("test.txt");
  File patternFile = SD.open("test.txt", FILE_WRITE);
  
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
      
      patternFile.write(width);
      patternFile.write(height);
      patternFile.write(length);
      
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
      
      Serial.write(red);
      Serial.write(green);
      Serial.write(blue);
      
      patternFile.write(red);
      patternFile.write(green);
      patternFile.write(blue);
      
      leds[counter].setRGB(red, green, blue);
      counter++;
    }
  }
    
  patternFile.close();
}   
      
void setup()
{
  // MIDI over pins 18 and 19
  Midi.begin();
  Midi.setHandleNoteOn(callbackNoteOn);
  Midi.setHandleClock(callbackClock);
  
  // USB - PC over pins 0 and 1
  Serial.begin(BAUD_RATE);
  
  // initialize SD
  pinMode(SPI_CS, OUTPUT);
  if (!SD.begin(SPI_CS))
  {
    //Serial.println("failed to initialize SD card");
    return;
  }
  //Serial.println("initialized SD card");
  
  // initialize FastLED
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
  }
  
}

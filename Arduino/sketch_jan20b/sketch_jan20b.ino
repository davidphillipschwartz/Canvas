#define FORCE_SOFTWARE_SPI
#define FORCE_SOFTWARE_PINS
#include "FastSPI_LED2.h"

///////////////////////////////////////////////////////////////////////////////////////////
//
// Move a white dot along the strip of leds.  This program simply shows how to configure the leds,
// and then how to turn a single pixel white and then off, moving down the line of pixels.
// 

// How many leds are in the strip?
#define NUM_LEDS 5

// Data pin that led data will be written out over
#define DATA_PIN 6

// This is an array of leds.  One item for each led in your strip.
CRGB leds[5];
CRGB colors[16] = {
  CRGB::Black,
  CRGB::Black,
  CRGB::Black,
  CRGB::Black,
  CRGB::Red,
  CRGB::Orange,
  CRGB::Yellow,
  CRGB::Green,
  CRGB::Blue,
  CRGB::Purple,
  CRGB::Black,
  CRGB::Black,
  CRGB::Black,
  CRGB::Black,
  CRGB::Black,
  CRGB::Black};
  
// This function sets up the LEDs and tells the controller about them
void setup() {
  pinMode(2,INPUT);
  Serial.begin(9600);
  
  // sanity check delay - allows reprogramming if accidently blowing power w/leds
  delay(2000);
  
  // Uncomment one of the following lines for your leds arrangement.
  FastLED.addLeds<WS2812B, DATA_PIN, GRB>(leds, NUM_LEDS);
}

// This function runs over and over, and is where you do the magic to light
// your leds.
void loop() {
  for(int state=0; state < 11; state++) {
    for(int lightnum=0; lightnum < NUM_LEDS; lightnum++) {
      leds[lightnum] = colors[state + lightnum];
    }
    FastLED.show();
    delay(500);
  }
  //delay(1000);
}

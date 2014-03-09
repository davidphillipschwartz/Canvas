// Jan 29: testing the diffusion characteristics with the RGBLED setup

#define FORCE_SOFTWARE_SPI
#define FORCE_SOFTWARE_PINS
#include "FastSPI_LED2.h"

///////////////////////////////////////////////////////////////////////////////////////////
//
// Move a white dot along the strip of leds.  This program simply shows how to configure the leds,
// and then how to turn a single pixel white and then off, moving down the line of pixels.
// 

#define PRELOAD 32767

// How many leds are in the strip?
#define NUM_MODES 4
#define NUM_LEDS 9

// Data pin that led data will be written out over
#define DATA_PIN 6
#define LED_PIN 13

// Clock pin only needed for SPI based chipsets when not using hardware SPI
//#define CLOCK_PIN 8

// This is an array of leds.  One item for each led in your strip.
CRGB leds[NUM_LEDS];

unsigned int stage=0;
int mode;
int colournum;
boolean storedbutton=0;

// This function sets up the LEDs and tells the controller about them
void setup() {
      pinMode(2,INPUT);
      Serial.begin(9600);
      
	// sanity check delay - allows reprogramming if accidently blowing power w/leds
   	delay(2000);

      FastLED.addLeds<TM1809, DATA_PIN, RGB>(leds, NUM_LEDS);

        cli();//stop interrupts

      //set timer0 interrupt at 2kHz
        TCCR0A = 0;// set entire TCCR2A register to 0
        TCCR0B = 0;// same for TCCR2B
        TCNT0  = 0;//initialize counter value to 0
        // set compare match register for 2khz increments
        OCR0A = 124;// = (16*10^6) / (2000*64) - 1 (must be <256)
        // turn on CTC mode
        TCCR0A |= (1 << WGM01);
        // Set CS01 and CS00 bits for 64 prescaler
        TCCR0B |= (1 << CS01) | (1 << CS00);   
        // enable timer compare interrupt
        TIMSK0 |= (1 << OCIE0A);
        
        sei();
}

ISR(TIMER0_COMPA_vect){//timer0 interrupt 2kHz
//generates pulse wave of frequency 2kHz/2 = 1kHz (takes two cycles for full wave- toggle high then toggle low)
  stage+=1;
}

// This function runs over and over, and is where you do the magic to light
// your leds.
void loop() {
  for(int whiteLed = 0; whiteLed < NUM_LEDS; whiteLed = whiteLed + 1) {
      leds[whiteLed] = CRGB::White;
    }
  }
  FastLED.show();
}

#define FORCE_SOFTWARE_SPI
#define FORCE_SOFTWARE_PINS
#include "FastSPI_LED2.h"
#include "MIDI.h"

#define PRELOAD 32767

#define DATA_PIN 6
#define NUM_LEDS 9

CRGB leds[NUM_LEDS];

CRGB colours[6] = {
  CRGB::Red,
  CRGB::Orange,
  CRGB::Yellow,
  CRGB::Green,
  CRGB::Blue,
  CRGB::Purple};
int colourindex=0;
int keyson=0;
int stage=0;

char* notes[128] = {
  "C-1","C#-1","D-1","Eb-1","E-1","F-1","F#-1","G-1","G#-1","A-1","Bb-1","B-1",
  "C0","C#0","D0","Eb0","E0","F0","F#0","G0","G#0","A0","Bb0","B0",
  "C1","C#1","D1","Eb1","E1","F1","F#1","G1","G#1","A1","Bb1","B1",
  "C2","C#2","D2","Eb2","E2","F2","F#2","G2","G#2","A2","Bb2","B2",
  "C3","C#3","D3","Eb3","E3","F3","F#3","G3","G#3","A3","Bb3","B3",
  "C4","C#4","D4","Eb4","E4","F4","F#4","G4","G#4","A4","Bb4","B4",
  "C5","C#5","D5","Eb5","E5","F5","F#5","G5","G#5","A5","Bb5","B5",
  "C6","C#6","D6","Eb6","E6","F6","F#6","G6","G#6","A6","Bb6","B6",
  "C7","C#7","D7","Eb7","E7","F7","F#7","G7","G#7","A7","Bb7","B7",
  "C8","C#8","D8","Eb8","E8","F8","F#8","G8","G#8","A8","Bb8","B8",
  "C9","C#9","D9","Eb9","E9","F9","F#9","G9"};

/*
void BlinkLed(byte num) { 	// Basic blink function
  for (byte i=0;i<num;i++) {
    digitalWrite(LED,HIGH);
    delay(50);
    digitalWrite(LED,LOW);
    delay(50);
  }
}
*/

void setup() {
  MIDI.begin();            	// Launch MIDI with default options
				// (input channel is default set to 1)
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
  //  stage+=1;
}

void loop() {
  if (MIDI.read()) {                    // Is there a MIDI message incoming ?
    switch(MIDI.getType()) {		// Get the type of the message we caught
      case NoteOn:
        if(MIDI.getData2()!=0) {        // Second data byte of MIDI is the velocity; if velocity==0 then noteOn, if velocity==0 then noteOff
          keyson++;
          colourindex++;
          if(colourindex >= 6)
            colourindex=0;
        }
        else {
          keyson--;
        }
      default:
        break;
    }
  }
  if(keyson==0){
    for(int led=0; led<NUM_LEDS; led++)
      leds[led] = CRGB::Black;
  }
  else if(keyson==1){
    for(int led=0; led<NUM_LEDS; led++)
      leds[led] = colours[colourindex];
  }
  else{
    colourindex++;
    if(colourindex >= 6)
      colourindex=0;
    for(int led=0; led<NUM_LEDS; led++)
      leds[led] = colours[colourindex];
  }
  FastLED.show();
}


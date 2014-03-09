/*
 * Hello World!
 *
 * This is the Hello World! for Arduino. 
 * It shows how to send data to the computer
 */

void basicloop();
void serialloop();
void serialsend(byte red, byte green, byte blue);
void transmitserial(byte data);

const byte RPORT = 2;
const byte GPORT = 3;
const byte BPORT = 4;
const byte SIN = 5;
const byte SCLK = 6;
const byte XLAT = 7;

int incomingByte;

//
// Use of timer2 to generate a signal for a particular frequency on pin 11
//
// davekw7x
//

const int freqOutputPin = 11;   // OC2A output pin for ATmega328 boards

// Constants are computed at compile time

// If you change the prescale value, it affects CS22, CS21, and CS20
// For a given prescale value, the eight-bit number that you
// load into OCR2A determines the frequency according to the
// following formulas:
//
// With no prescaling, an ocr2val of 3 causes the output pin to
// toggle the value every four CPU clock cycles. That is, the
// period is equal to eight slock cycles.
//
// With F_CPU = 16 MHz, the result is 2 MHz.
//
// Note that the prescale value is just for printing; changing it here
// does not change the clock division ratio for the timer!  To change
// the timer prescale division, use different bits for CS22:0 below
const int prescale  = 1;
const int ocr2aval  = 3; 
// The following are scaled for convenient printing
//

// Period in microseconds
const float period    = 2.0 * prescale * (ocr2aval+1) / (F_CPU/1.0e6);

// Frequency in Hz
const float freq      = 1.0e6 / period;

void setup()
{
    pinMode(freqOutputPin, OUTPUT);
    Serial.begin(9600);
 
    // Set Timer 2 CTC mode with no prescaling.  OC2A toggles on compare match
    //
    // WGM22:0 = 010: CTC Mode, toggle OC 
    // WGM2 bits 1 and 0 are in TCCR2A,
    // WGM2 bit 2 is in TCCR2B
    // COM2A0 sets OC2A (arduino pin 11 on Uno or Duemilanove) to toggle on compare match
    //
    TCCR2A = ((1 << WGM21) | (1 << COM2A0));

    // Set Timer 2  No prescaling  (i.e. prescale division = 1)
    //
    // CS22:0 = 001: Use CPU clock with no prescaling
    // CS2 bits 2:0 are all in TCCR2B
    TCCR2B = (1 << CS20);

    // Make sure Compare-match register A interrupt for timer2 is disabled
    TIMSK2 = 0;
    // This value determines the output frequency
    OCR2A = ocr2aval;

    Serial.print("Period    = ");
    Serial.print(period); 
    Serial.println(" microseconds");
    Serial.print("Frequency = ");
    Serial.print(freq); 
    Serial.println(" Hz");
    
  //Serial.println("Hello world!");  // prints hello with ending line break 
  pinMode(0,OUTPUT);
  pinMode(1,OUTPUT);
  pinMode(2,OUTPUT);
  pinMode(3,OUTPUT);
  pinMode(4,OUTPUT);
  pinMode(5,OUTPUT);
  pinMode(6,OUTPUT);
  pinMode(7,OUTPUT);
}

void serialsend(byte red, byte green, byte blue)
{
  transmitserial(red);
  transmitserial(green);
  transmitserial(blue);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  transmitserial(0);
  digitalWrite(SIN,LOW);
  digitalWrite(SCLK,LOW);
  digitalWrite(XLAT,LOW);
}

void transmitserial(byte data) {
  byte mask;
  for (mask = 128; mask>0; mask >>= 1) { //iterate through bit mask
    if (data & mask){ // if bitwise AND resqolves to true
      digitalWrite(SIN,HIGH); // send 1
      Serial.print("1");  // to double-check what's being written
    }
    else{ //if bitwise and resolves to false
      digitalWrite(SIN,LOW); // send 0
      Serial.print("0"); // to double-check what's being written
    }
    digitalWrite(SCLK,HIGH);
    delayMicroseconds(1);
    digitalWrite(SCLK,LOW);
  }
  digitalWrite(XLAT,HIGH);
  delayMicroseconds(1);
  digitalWrite(XLAT,LOW);
}

void basicloop() {
    while(true) {
        digitalWrite(BPORT, LOW);
        digitalWrite(RPORT, HIGH);
        delay(1000);
        digitalWrite(RPORT, LOW);
        digitalWrite(GPORT, HIGH);
        delay(1000);
        digitalWrite(GPORT, LOW);
        digitalWrite(BPORT, HIGH);
        delay(1000);
    }
}

void loop()                       // run over and over again
{
  if (Serial.available() > 0) {
    Serial.read();
    serialsend(254,253,251);
    Serial.println("");
    // read the incoming byte:
    //incomingByte = Serial.read();

    // say what you got:
    //Serial.print("I received: ");
    //Serial.println(incomingByte, DEC);
  }
}


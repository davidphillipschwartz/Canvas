// firmware for canvas
// david schwartz
// 8 march 2014

byte buffer;

void setup()
{
  // MIDI over pins 0 and 1
  Serial.begin(31250);
  
  // USB - PC over pins 18 and 19
  Serial1.begin(9600);
}

void loop()
{
  // check for MIDI
  if(Serial.available())
  {
    // process MIDI
  }
  // check for data from PC
  else if(Serial1.available())
  {
    // process data from PC
  }
  
}

void setup ()
{
  Serial.begin(9600);
}

void loop ()
{
  if(Serial.available())
  {
    uint8_t serialData = Serial.read();
    Serial.write(serialData);
  }
}

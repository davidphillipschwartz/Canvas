byte commandByte;
byte noteByte;
byte velocityByte;

void setup(){
  Serial.begin(31250);
  pinMode(13,OUTPUT);
  digitalWrite(13,LOW);
}

void checkMIDI(){
  do{
    if (Serial.available()){
      digitalWrite(13,HIGH);
      commandByte = Serial.read();//read first byte
      noteByte = Serial.read();//read next byte
      velocityByte = Serial.read();//read final byte
      Serial.print(commandByte, DEC);
      Serial.print(noteByte, DEC);
      Serial.print(velocityByte, DEC);
      digitalWrite(13,LOW);
    }
  }
  while (Serial.available() > 2);//when at least three bytes available
}
    

void loop(){
  checkMIDI();
}

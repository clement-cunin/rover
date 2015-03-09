
#include <Wire.h>
#include <Arduino.h>
#include "Nunchuk.h"


#define NUNCHUK_DEVICE_ID 0x52

void Nunchuk::initialize(){
  Wire.begin();
  Wire.beginTransmission(NUNCHUK_DEVICE_ID);
  Wire.write(0x40);
  Wire.write(0x00);
  Wire.endTransmission();
  update();
}

bool Nunchuk::update(){
  // Ask for update
  Wire.beginTransmission(NUNCHUK_DEVICE_ID);
  Wire.write(0x00);
  Wire.endTransmission();

  // Waiting 10s
  delay(10);
  
  // Read 6 bytes
  Wire.requestFrom(NUNCHUK_DEVICE_ID,NUNCHUK_BUFFER_SIZE);
  int byte_counter = 0;  
  while( byte_counter<NUNCHUK_BUFFER_SIZE && Wire.available() ) {
    _buffer[byte_counter++] = decode_byte(Wire.read());
  }
  
  // Check for error
  return byte_counter == NUNCHUK_BUFFER_SIZE;
}

char Nunchuk::decode_byte(const char b){
  return (b ^ 0x17) + 0x17;
}

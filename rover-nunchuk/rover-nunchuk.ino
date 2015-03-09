
#include <Wire.h>
#include "nunchuk.h"

// Create the object
Nunchuk nunchuk;

#define RIGHT_DIRECTION 12
#define RIGHT_BREAK 9
#define RIGHT_POWER 3
#define LEFT_DIRECTION 13
#define LEFT_BREAK 8
#define LEFT_POWER 11

#define FORWARD HIGH
#define BACKWARD LOW

void setup()
{
  Serial.begin(9600); 
  Serial.println("Starting...");

  pinMode(LEFT_DIRECTION, OUTPUT); //Initiates Motor Channel A pin
  pinMode(LEFT_BREAK, OUTPUT); //Initiates Brake Channel A pin
  digitalWrite(LEFT_BREAK, HIGH);

  pinMode(RIGHT_DIRECTION, OUTPUT); //Initiates Motor Channel A pin
  pinMode(RIGHT_BREAK, OUTPUT); //Initiates Brake Channel A pin
  digitalWrite(RIGHT_BREAK, HIGH);
  
  // Start the nunchuk 
  nunchuk.initialize();
}

int cmap(int value, int fromLow, int fromHigh, int toLow, int toHigh) {
  return constrain(map(value, fromLow, fromHigh, toLow, toHigh), toLow, toHigh);
}


void loop() {
  int r = 0;
  int l = 0;
  int y = 0;
  int x = 0;
  int d = 0;
    
  // Fetch a new set of data
  if( nunchuk.update() ) {
    
    y = nunchuk.joystick_y() - 128;
    x = nunchuk.joystick_x() - 128; 
    y = abs(y)<10 ? 0 : y;
    x = abs(x)<10 ? 0 : x;
    d = sqrt(y*y + x*x);
    
   
    if( abs(y)+25 > abs(x) ) {
      if( y > 0 ) {
        r = cmap(y-x/2, 10, 90, 0, 255);
        l = cmap(y+x/2, 10, 90, 0, 255);
      } else if( y < 0 ) {
        r = -cmap(d, 10, 90, 0, 255);
        l = -cmap(d, 10, 90, 0, 255);
      }
    } else {
      if( x > 0 ) {
        r = -cmap(x, 10, 90, 0, 255);
        l =  cmap(x, 10, 90, 0, 255);
      } else if( x < 0 ) {
        r =  cmap(-x, 10, 90, 0, 255);
        l = -cmap(-x, 10, 90, 0, 255);      
      }
    }
  }

  if( nunchuk.c_button() && r!=0) {
    digitalWrite(RIGHT_DIRECTION, r>0 ? FORWARD: BACKWARD);
    
    int D=20;
    analogWrite(RIGHT_POWER, 0);
    delay(D);
    analogWrite(RIGHT_POWER, 120);

    digitalWrite(RIGHT_BREAK, LOW);
  } else if( nunchuk.z_button() && r!=0) {
    digitalWrite(RIGHT_DIRECTION, r>0 ? FORWARD: BACKWARD);
    analogWrite(RIGHT_POWER, cmap(abs(r), 0, 255, 80, 255));
    digitalWrite(RIGHT_BREAK, LOW);
  } else {
    digitalWrite(RIGHT_DIRECTION, FORWARD);
    digitalWrite(RIGHT_BREAK, HIGH);
    analogWrite(RIGHT_POWER, 0);
  }
   
  if( nunchuk.z_button() && l!=0) {
    digitalWrite(LEFT_DIRECTION, l>0 ? FORWARD: BACKWARD);
    analogWrite(LEFT_POWER, cmap(abs(l), 0, 255, 80, 255));
    digitalWrite(LEFT_BREAK, LOW);
  } else {
    digitalWrite(LEFT_DIRECTION, FORWARD);
    digitalWrite(LEFT_BREAK, HIGH);
    analogWrite(LEFT_POWER, 0);
  }
    
  Serial.print("R: ");
  Serial.print( r );
  Serial.print("\tL: ");  
  Serial.print( l );
  
  // Print the data
  Serial.print("\tX: ");
  Serial.print( x );
  Serial.print("\tY: ");  
  Serial.print( y );
  Serial.print("\tD: ");  
  Serial.print( d );
    
  if (nunchuk.c_button())
    Serial.print("-C");
  
  if (nunchuk.z_button())
    Serial.print("-Z");
    
  Serial.println("");
}

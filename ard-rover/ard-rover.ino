
#include <Wire.h>

// Motor shield PIN
#define RIGHT_DIRECTION 12
#define RIGHT_BREAK 9
#define RIGHT_POWER 3
#define LEFT_DIRECTION 13
#define LEFT_BREAK 8
#define LEFT_POWER 11

// SRF05 PIN
#define ECHOPIN 7 // GREEN
#define TRIGPIN 6 // BLUE

// Start button PIN
#define CMD_PIN 4

// MODE
#define WAITING 0
#define FORWARD 1
#define BACKWARD 2
#define ROTATE_RIGHT 3
#define ROTATE_LEFT 4
int mode = WAITING;

void setup() {
  Serial.begin(9600); 
  Serial.println("Starting...");

  // Motor shield
  pinMode(LEFT_DIRECTION, OUTPUT);
  pinMode(LEFT_BREAK, OUTPUT);
  digitalWrite(LEFT_BREAK, HIGH);
  pinMode(RIGHT_DIRECTION, OUTPUT);
  pinMode(RIGHT_BREAK, OUTPUT);
  digitalWrite(RIGHT_BREAK, HIGH);
  
  // SRF05
  pinMode(ECHOPIN, INPUT);
  pinMode(TRIGPIN, OUTPUT);
  digitalWrite(TRIGPIN, LOW);
  
  // Start Button
  pinMode(CMD_PIN, INPUT);
  delay(10);
  
  randomSeed(analogRead(0));
}

int cmap(int value, int fromLow, int fromHigh, int toLow, int toHigh) {
  return constrain(map(value, fromLow, fromHigh, toLow, toHigh), toLow, toHigh);
}

int getDistance() {
  // Send a 10uS high to trigger ranging
  digitalWrite(TRIGPIN, HIGH);                  
  delayMicroseconds(10);
  digitalWrite(TRIGPIN, LOW);
  
  // read result in cm
  return pulseIn(ECHOPIN, HIGH) / 58;
}

void motor(int power) {
  motor(power, power);
}

void motor(int l, int r) {
  // Motor set
  if( r!=0) {
    digitalWrite(RIGHT_DIRECTION, r>0 ? HIGH: LOW);
    analogWrite(RIGHT_POWER, cmap(abs(r), 0, 255, 50, 255));
    digitalWrite(RIGHT_BREAK, LOW);
  } else {
    digitalWrite(RIGHT_DIRECTION, HIGH);
    digitalWrite(RIGHT_BREAK, HIGH);
    analogWrite(RIGHT_POWER, 0);
  }
   
  if( l!=0) {
    digitalWrite(LEFT_DIRECTION, l>0 ? HIGH: LOW);
    analogWrite(LEFT_POWER, cmap(abs(l), 0, 255, 50, 255));
    digitalWrite(LEFT_BREAK, LOW);
  } else {
    digitalWrite(LEFT_DIRECTION, HIGH);
    digitalWrite(LEFT_BREAK, HIGH);
    analogWrite(LEFT_POWER, 0);
  }
}


void loop() {
  
  // Button -> Change mode
  if( digitalRead(CMD_PIN)==HIGH ) {
    while ( digitalRead(CMD_PIN)==HIGH ) {
      delay(200);
    }
    if( mode==WAITING ) {
      mode = FORWARD;
    } else {
      mode = WAITING;
    }
  }
  
  int d = getDistance(); // wall proximity
  
  if( mode==FORWARD ) {
    if (d > 18) {
      motor(constrain((d-17)*4, 0, 255));
    } else {
      motor(-255);
      delay(50);
      motor(0);
      delay(50);
      mode = BACKWARD;
    }
    
  } else if( mode==BACKWARD ) {
    if (d < 15) {
      motor(-255);
    } else {
      mode = random(2)==0 ? ROTATE_LEFT : ROTATE_RIGHT;
    }
    
  } else if( mode==ROTATE_LEFT ) {
    if( d < 75 ) {
      motor( -255, 255);
    } else {
      mode = FORWARD;
    }
  } else if( mode==ROTATE_RIGHT ) {
    if( d < 75 ) {
      motor( 255, -255);
    } else {
      mode = FORWARD;
    }
  } else {
    
    motor( 0, 0);
  }
  
  
  
  // Debug
  //Serial.print("R: ");
  //Serial.print( r );
  //Serial.print("\tL: ");  
  //Serial.print( l );
  Serial.print("\tD: ");
  Serial.print( d );
  Serial.print("\tM: ");
  Serial.print( mode );
  
  delay(100);
}

#include <SoftwareSerial.h>
#include <TimerOne.h>

#define S0 4
#define S1 5
#define S2 6
#define S3 7
#define sensorOut 8

#define LedRed    A2
#define LedGreen  A0
#define LedBlue   A1

#define BT_RX_PIN 0
#define BT_TX_PIN 1

SoftwareSerial BTSerial(BT_RX_PIN, BT_TX_PIN);

volatile int x=false;
int frequency=0;
int redfrequency = 0;
int greenfrequency = 0;
int bluefrequency = 0;

void setup() {
  pinMode(S0, OUTPUT);
  pinMode(S1, OUTPUT);
  pinMode(S2, OUTPUT);
  pinMode(S3, OUTPUT);
  pinMode(sensorOut, INPUT);

  pinMode(LedRed, OUTPUT);
  pinMode(LedGreen, OUTPUT);
  pinMode(LedBlue, OUTPUT);
  
 
  digitalWrite(S0,HIGH);
  digitalWrite(S1,LOW);
  
  Serial.begin(9600);

  Timer1.initialize(100000); // set a timer of length 100000 microseconds (or 100 ms)
  Timer1.attachInterrupt(callback); // attach the service routine here
}

void callback() {
 x=true;
}

void loop() {
  if(x)
  {
    x=false;
     // Setting red filtered photodiodes to be read
  digitalWrite(S2,LOW);
  digitalWrite(S3,LOW);
  // Reading the output frequency
  redfrequency = pulseIn(sensorOut, LOW);

  // Setting Green filtered photodiodes to be read
  digitalWrite(S2,HIGH);
  digitalWrite(S3,HIGH);
  // Reading the output frequency
  greenfrequency = pulseIn(sensorOut, LOW);

  // Setting Blue filtered photodiodes to be read
  digitalWrite(S2,LOW);
  digitalWrite(S3,HIGH);
  // Reading the output frequency
  bluefrequency = pulseIn(sensorOut, LOW);

  if (redfrequency>25 && redfrequency< 100) 
  {
    Serial.println("ROSU"); 
    digitalWrite(LedRed, HIGH);
    digitalWrite(LedBlue, LOW); 
    digitalWrite(LedGreen, LOW);
  } 
  else if (bluefrequency>44 && bluefrequency< 150) 
  {
    Serial.println("ALBASTRU");
    digitalWrite(LedBlue, HIGH);
    digitalWrite(LedGreen, LOW);
    digitalWrite(LedRed, LOW);
  }
  else if (greenfrequency>50 && greenfrequency< 180)
  {  
    Serial.println("VERDE"); 
    digitalWrite(LedGreen, HIGH);
    digitalWrite(LedBlue, LOW); 
    digitalWrite(LedRed, LOW);
  }
  else if (bluefrequency> 80 && redfrequency>150 && greenfrequency>185) 
  {
    Serial.println("NEGRU");
    digitalWrite(LedBlue, LOW);
    digitalWrite(LedGreen, LOW);
    digitalWrite(LedRed, LOW);
  }
  else if (bluefrequency> 4 && redfrequency>13 && greenfrequency>15) 
  {
    Serial.println("ALB");
    digitalWrite(LedBlue, LOW);
    digitalWrite(LedGreen, LOW);
    digitalWrite(LedRed, LOW);
  }
  else
  {
    Serial.println("NO COLOUR DETECTION");
    digitalWrite(LedBlue, LOW);
    digitalWrite(LedGreen, LOW);
    digitalWrite(LedRed, LOW);
  }
  }
}

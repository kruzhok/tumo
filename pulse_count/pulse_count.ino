int value = 0;
int previousValue = 0;

int pulseCount = 0;
int pulse = 0;

int currentTime = 0;
int lastMillis = 0;

int eachTime = 5000;

void setup() {
  Serial.begin(115200);

}

void loop() {
  value = analogRead(A0);

  if (value > 550 && previousValue < 550) {
    pulseCount++;
  }

  previousValue = value;
  currentTime = millis();

  if ((currentTime - lastMillis) > eachTime) {
    pulse = pulseCount * (60000 / eachTime);
    pulseCount = 0;
    lastMillis = currentTime;
  }

  Serial.println(pulse);

  delay(20);
}

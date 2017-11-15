#define LED_PIN 9
#define SENSOR_PIN A0

int muscle = 0;
int nextMuscle = 0;

void setup()
{
  Serial.begin(115200);
  pinMode(LED_PIN, OUTPUT);
  pinMode(SENSOR_PIN, INPUT);
}

void loop()
{
  int amplitude, brightness;
  nextMuscle = analogRead(SENSOR_PIN);
  amplitude = abs(nextMuscle - muscle);
  Serial.println(nextMuscle);

  if (amplitude > 200) {
    brightness = map(muscle, 0, 1023, 0, 255);
  } else {
    brightness = 0;
  }

  analogWrite(LED_PIN, brightness);

  muscle = nextMuscle;
  delay(10);
}

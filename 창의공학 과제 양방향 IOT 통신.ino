void setup() {
  Serial.begin(9600);
  pinMode(13, OUTPUT);
}

void loop() {
  tem_sen();
  if(Serial.available()>0)
  {
    String input = Serial.readString();
    if(input != NULL)
    {
    int sec = input.toInt();
    digitalWrite(13, HIGH);
    delay(sec);
    digitalWrite(13, LOW);
    delay(sec); 
    }
  }
}

void tem_sen()
{
  int s;
  s = analogRead(A0);
  Serial.println(th(s));
  delay(1000);
}

double th(int v) {
  double t;
  t = log(((10240000/v) - 10000));
  t = 1 /(0.001129148 + (0.000234125*t) + (0.0000000876741*t*t*t));
  t = t - 273.15;
  return t;
}
#include <arduino.h>
#include "serial-led-io.h"

int schi;
uint8_t sled, rled;

void setup()
{
    pinMode(LED1OUT, OUTPUT);
    digitalWrite(LED1OUT, LEDOFF);
    pinMode(LED2OUT, OUTPUT);
    digitalWrite(LED2OUT, LEDOFF);
    pinMode(LED1STAT, INPUT);
    pinMode(LED2STAT, INPUT);
}

void loop()
{
    while (Serial && Serial.available())
    {
        schi = Serial.read();
        if (schi >= '0' && schi < '4')
        {
            sled = (uint8_t)(schi - '0');
            setleds(sled);
        }
        rled = getleds();
        if (Serial && Serial.availableForWrite())
            Serial.write(char('0' + rled));
    }
}

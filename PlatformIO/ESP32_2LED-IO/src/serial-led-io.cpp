#include <arduino.h>
#include "serial-led-io.h"

char schi;
uint8_t sled, rled;

void setleds(uint8_t status)
{
    if (status & 0x01)
        digitalWrite(LED1OUT, LEDON);
    else
        digitalWrite(LED1OUT, LEDOFF);
    if (status & 0x02)
        digitalWrite(LED2OUT, LEDON);
    else
        digitalWrite(LED2OUT, LEDOFF);
}

uint8_t getleds()
{
    uint8_t status = 0;
    if (digitalRead(LED1STAT) == HIGH)
        status |= 0x1;
    if (digitalRead(LED2STAT) == HIGH)
        status |= 0x2;
    return status;
}

void setup()
{
    pinMode(LED1OUT, OUTPUT);
    pinMode(LED2OUT, OUTPUT);
    digitalWrite(LED1OUT, LEDOFF);
    digitalWrite(LED2OUT, LEDOFF);
    pinMode(LED1STAT, INPUT);
    pinMode(LED2STAT, INPUT);
}

void loop()
{
    while (Serial.available())
    {
        schi = (char)Serial.read();
        if (schi >= '0' && schi < '4')
        {
            sled = schi - '0';
            setleds(sled);
        }
        rled = getleds();
        Serial.write('0' + rled);
    }
}

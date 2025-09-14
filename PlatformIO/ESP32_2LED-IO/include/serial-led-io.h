#ifndef SERIAL_LED_IO_H_
#define SERIAL_LED_IO_H_

#define LED1OUT  0
#define LED1STAT 1
#define LED2OUT  2
#define LED2STAT 3

#define LEDON    LOW
#define LEDOFF   HIGH

void setleds(uint8_t status);
uint8_t getleds();

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

#endif // SERIAL_LED_IO_H_
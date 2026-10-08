#define F_CPU 16000000UL

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= (1 << DDB5);  // D11 - Red
    DDRB |= (1 << DDB6);  // D12 - Yellow
    DDRB |= (1 << DDB4);  // D10 - Green

    while (1)
    {
        // RED
        PORTB |= (1 << PORTB5);
        _delay_ms(5000);
        PORTB &= ~(1 << PORTB5);

        // YELLOW
        PORTB |= (1 << PORTB6);
        _delay_ms(2000);
        PORTB &= ~(1 << PORTB6);

        // GREEN
        PORTB |= (1 << PORTB4);
        _delay_ms(5000);
        PORTB &= ~(1 << PORTB4);
    }
}
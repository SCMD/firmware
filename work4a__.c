/*****************************************************
This program was produced by the
CodeWizardAVR V1.24.6 Evaluation
Automatic Program Generator
© Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com
e-mail:office@hpinfotech.com

Project :
Version :
Date    : 30.10.2005
Author  : Freeware, for evaluation and non-commercial use only
Company :
Comments:


Chip type           : ATmega8
Program type        : Application
Clock frequency     : 4,000000 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 256
*****************************************************/

#include <mega8.h>

// Standard Input/Output functions
#include <stdio.h>
#include <delay.h>

int result;
int counter;
int i;

// ADC interrupt service routine
interrupt [ADC_INT] void adc_isr(void){

result += ADCW;
counter++;
if (i == 3)PORTB ^= 0x01;

if (counter == 15){
result = result/15;
printf("C0.%i\n",result);
putchar(0x0D);
counter=0;
result=0;
}

}

// Declare your global variables here

void init_devices(void){
// Declare your local variables here
PORTB = 0xFF;
DDRB = 0x07;
PORTC=0x00;
DDRC=0x00;
PORTD=0x00;
DDRD=0x00;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Prescale: 1024 kHz
//TCCR0 = 0x00; //stop
//TCNT0 = 0xB8;//B8; //set count
//TCCR0 = 0x02; //start timer


// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
MCUCR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
//TIMSK=0x01;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud rate: 9600

UCSRA=0x00;
UCSRB=0x00;
UCSRC=0x86;
UBRRL = 0x19; //set baud rate lo
UBRRH = 0x00; //set baud rate hi
UCSRB = 0x08;

//UCSRA=0x02;
//UCSRB=0x00;
//UCSRC=0x86;
//UBRRH=0x00;
//UBRRL=0x0C;
//UCSRB=0x08;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 125,000 kHz
// ADC Voltage Reference: AREF pin
//ADMUX=0x00;
ADMUX=0x40;
ADCSRA=0x8D;
//ADCSRA=0x8E;
// Global enable interrupts
#asm("sei")
}


void main(void){

init_devices();
PORTB ^= 0x01;

while (1)
{
delay_ms(20);
ADCSRA |= 0x40;

if (i == 50){
PORTB ^= 0x01;
i=0;
}

i++;

};

}










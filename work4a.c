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

02.09.06 - Double LED is connected to PB0, PD7
19.10.06 - Low output at PD02 as DTR output signal
20.10.06 - Monitoring PD3 and activate device on High input

*****************************************************/

#include <mega8.h>

// Standard Input/Output functions
#include <stdio.h>
#include <delay.h>

bit sample=0, firsttime=1;


unsigned int read_adc(void)
{
unsigned int counter0 = 27, counter1 = 16;
unsigned long int result0=0, result1=0;

ADCSRA |= 0x20;
ADCSRA |= 0x40;

while (counter0){

while (counter1){
while ((ADCSRA & 0x10)==0);
ADCSRA |= 0x10;
result1 += ADCW;
counter1--;
}
result1 >>= 2;

result0 += result1;
result1 = 0;
counter1 = 16;
counter0--;
}
ADCSRA ^=0x20;
result0 /= 27;
return result0;
}

// Declare your global variables here

void init_devices(void){
// Declare your local variables here
PORTB=0x02; //pb0 - LED, pb1 - Switch
DDRB=0x01;
PORTC=0x00;
DDRC=0x00;
PORTD=0x0C; //pd7 - LED, pd2 - low, pd3 - input
DDRD=0x84;

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

//UCSRA=0x00;
//UCSRB=0x00;
//UCSRC=0x86;
//UBRRL = 0x19; //set baud rate lo
//UBRRH = 0x00; //set baud rate hi
//UCSRB = 0x08;

// USART initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART Receiver: Off
// USART Transmitter: On
// USART Mode: Asynchronous
// USART Baud rate: 19200
UCSRA=0x00;
UCSRB=0x00;
UCSRC=0x86;
UBRRH=0x00;
UBRRL=0x0C;
UCSRB=0x08;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC Clock frequency: 125,000 kHz
// ADC Voltage Reference: internal
ADMUX=0xC1; //internal reference; ADC1
//ADMUX=0xCE; //internal reference; 1.23 bg
//ADMUX=0x40; //AVCC
//ADCSRA=0x8D; // INT

ADCSRA=0x85; //freerunning

// Global enable interrupts
#asm("sei")
}


void main(void){

init_devices();

while (1)
{

 if (!PIND.3){

          if (firsttime){
          PORTB.0 = 1;
          PORTD.7 = 0;
          PORTD.2 = 0;
          firsttime=0;
          }

          if (sample){
                //delay_ms(20);
                printf("%i\n",read_adc());
                putchar(0x0D);
          }

          if (!PINB.1) {
                sample ^= 1;
                PORTB.0 ^= 1;
                PORTD.7 ^= 1;
                while (!PINB.1);
          }
  }else{
  sample = 0;
  PORTB.0 = 0;
  PORTD.7 = 0;
  PORTD.2 = 1;
  firsttime=1;
  }

}
}










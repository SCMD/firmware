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
Clock frequency     : 7,3728 MHz
Memory model        : Small
External SRAM size  : 0
Data Stack size     : 256

02.09.06 - Double LED is connected to PB0, PD7, switch is connected to PB1
19.10.06 - Low output at PD2 as DTR output signal
20.10.06 - Monitoring PD3 and activate device on High input
04.04.07 - 4 channel mode (adc0 as A, adc1 as B ... adc3 as D) swtches consequently
27.03.08 - XTAL 7.3728MHz added  (CKOPT=1;SUT=10;SKSEL=1111)
14.10.08 - button() function for clear button press detection

*****************************************************/
// CodeVisionAVR C Compiler
// (C) 1998-2004 Pavel Haiduc, HP InfoTech S.R.L.
// I/O registers definitions for the ATmega8
#pragma used+
#pragma used+
sfrb TWBR=0;
sfrb TWSR=1;
sfrb TWAR=2;
sfrb TWDR=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      // 16 bit access
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRRL=9;
sfrb UCSRB=0xa;
sfrb UCSRA=0xb;
sfrb UDR=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   // 16 bit access
sfrb UBRRH=0x20;
sfrb UCSRC=0X20;
sfrb WDTCR=0x21;
sfrb ASSR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   // 16 bit access
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  // 16 bit access
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  // 16 bit access
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  // 16 bit access
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb SFIOR=0x30;
sfrb OSCCAL=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TWCR=0x36;
sfrb SPMCR=0x37;
sfrb TIFR=0x38;
sfrb TIMSK=0x39;
sfrb GIFR=0x3a;
sfrb GICR=0x3b;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-
// Interrupt vectors definitions
// Needed by the power management functions (sleep.h)
#asm
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
#endasm
// Standard Input/Output functions
// CodeVisionAVR C Compiler
// (C) 1998-2006 Pavel Haiduc, HP InfoTech S.R.L.
// Prototypes for standard I/O functions
// CodeVisionAVR C Compiler
// (C) 1998-2002 Pavel Haiduc, HP InfoTech S.R.L.
// Variable length argument list macros
typedef char *va_list;
typedef char *va_list;
typedef char *va_list;
#pragma used+
char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
char *gets(char *str,unsigned int len);
void printf(char flash *fmtstr,...);
void sprintf(char *str, char flash *fmtstr,...);
void snprintf(char *str, unsigned int size, char flash *fmtstr,...);
void vprintf (char flash * fmtstr, va_list argptr);
void vsprintf (char *str, char flash * fmtstr, va_list argptr);
void vsnprintf (char *str, unsigned int size, char flash * fmtstr, va_list argptr);
signed char scanf(char flash *fmtstr,...);
signed char sscanf(char *str, char flash *fmtstr,...);
                                               #pragma used-
#pragma library stdio.lib
// CodeVisionAVR C Compiler
// (C) 1998-2000 Pavel Haiduc, HP InfoTech S.R.L.
#pragma used+
#pragma used+
void delay_us(unsigned int n);
void delay_ms(unsigned int n);
#pragma used-
bit sample=0, firsttime=1;
char channel[]="ABCD";
void button(void)
{
unsigned int b=0, i=0;
for (i=0; i<100; i++){
b += !PINB.1;
delay_ms(1);
}
b /= 100;
if (b == 1){
            sample ^= 1;
            PORTB.0 ^= 1;
            PORTD.7 ^= 1;
            }
}
unsigned int read_adc(void)
{
unsigned int counter0 = 6, counter1 = 16; //counter0 = 6
unsigned long int result0=0, result1=0;
// set freerunning
ADCSRA |= 0x20;
// Start the AD conversion
ADCSRA |= 0x40;
while (counter0){
while (counter1){
// Wait for the AD conversion to complete
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
result0 /= 6;
return result0;
}
// Declare your global variables here
void init_devices(void){
// all unused legs - pull-up inputs
PORTB=0b11111110; //pb0 - LED (output, low), pb1 - Switch (input, pull-up)
DDRB= 0b00000001;
PORTC=0b11110000;
DDRC= 0b00000000;
PORTD=0b01111011; //pd7 - LED (output, low), pd3 - input (input, pull-up), pd2 - DSR (output, low).
DDRD= 0b10000100;
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
// USART Baud rate: 19200
//UCSRA=0x00;
//UCSRB=0x08;
//UCSRC=0x86;
//UBRRH=0x00;
//UBRRL=0x0C;
//same for external 7.3728 XTAL, 38400 bod
UCSRA=0x00;
UCSRB=0x08;
UCSRC=0x86;
UBRRH=0x00;
//UBRRL=0x17;
UBRRL=0x0B;
// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;
// ADC initialization
// ADC Clock frequency: 125,000 kHz
// ADC Voltage Reference: internal
ADMUX=0xC0; //internal reference; ADC1
//ADMUX=0xCE; //1.23v bg, internal ref.
//ADMUX=0x40; //AVCC
//ADCSRA=0x8D; // INT
//enable ADC with 125,000 kHz (4mhz/32)
//ADCSRA=0x85;//without int
//ADCSRA=0x8D;//with int
//enable ADC with 115,000 kHz (7.3728mhz/64)
ADCSRA=0x86;//without int
//ADCSRA=0x8E;//with int
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
                printf("%c%i\r\n",channel[ADMUX&7],read_adc());
                ADMUX++;
                if (ADMUX == 0xC4) ADMUX = 0xC0;
                // Delay needed for the stabilization of the ADC input voltage
                delay_us(10);
          }
          if (!PINB.1) {
                button();
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

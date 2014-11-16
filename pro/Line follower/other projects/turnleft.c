/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.6 Evaluation
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 9/24/2011
Author  : Freeware, for evaluation and non-commercial use only
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/

#include <mega16.h>
#include <delay.h>
// Declare your global variables here
   int dif,p=0;
int del(int e)
{
  dif=((p/50)-e)*5;
  p=e*30; 
  return(dif+p);
}
void main(void)
{
// Declare your local variables here
   

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0xFF;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0x00;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x30;

// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=FFh
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0xA1;
TCCR1B=0x0A;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;


while (1)
      {
         if(PINB.0==1)
         { 
         delay_ms(100);                           
         if(PINA.2)
         {
         PORTA.0=1;
         PORTA.1=0;
         PORTA.6=0;
         PORTA.7=1;   
         
         delay_ms(del(2)); 
         PORTA=0;
         delay_ms(100000);
         }
         else if(PINA.3)     
         {
         PORTA.0=1;
         PORTA.1=0;
         PORTA.6=0;
         PORTA.7=0;   
          delay_ms(del(1)); 
         PORTA=0;
         delay_ms(100000);
         }               
         else if(PINA.4)
         {
          PORTA.0=0;
         PORTA.1=0;
         PORTA.6=1;
         PORTA.7=0;   

          delay_ms(del(1)); 
         PORTA=0;
         delay_ms(100000);
         }  
         else if(PINA.5)
         {
          PORTA.0=0;
         PORTA.1=1;
         PORTA.6=1;
         PORTA.7=0;   
         delay_ms(del(2)); 
         PORTA=0;
         delay_ms(100000);
         }                          
         else if(PIND.2)
         { 
         PORTA.0=1;
         PORTA.1=0;
         PORTA.6=1;
         PORTA.7=0;   
         delay_ms(200); 
         PORTA=0;
         delay_ms(100000);
         }
         
         }
         

      }
}

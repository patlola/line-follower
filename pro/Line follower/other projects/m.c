/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.6 Evaluation
Automatic Program Generator
� Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 9/29/2011
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
 void pullm1();  
 void pullm2();
 void relsm2();    
 void relsm1(); 
 void straight();
 void back(); 
 void right();   
 void left();
 void hit();
 
 
 
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
      OCR1A=255;
      OCR1B=255;
      if(PIND.0==0 && PIND.1==0 && PIND.2==1 && PIND.3==0) //2
      straight();
      if(PIND.0==0 && PIND.1==1 && PIND.2==0 && PIND.3==0))   //4
      left();
      if(PIND.0==0 && PIND.1==1 && PIND.2==1 && PIND.3==0)       //6
      right();
      if(PIND.0==1 && PIND.1==0 && PIND.2==0 && PIND.3==0)          //8
      back();
      if(PIND.0==0 && PIND.1==0 && PIND.2==0 && PIND.3==1)             //   1
      pullm1();                                                  
       if(PIND.0==0 && PIND.1==0 && PIND.2==1 && PIND.3==1)         //7
      relsm1();                              
      if(PIND.0==0 && PIND.1==0 && PIND.2==1 && PIND.3==1)      //3
      pullm2();
      if(PIND.0==1 && PIND.1==0 && PIND.2==0 && PIND.3==1)         //9
      relsm1(); 
      if(PIND.0==0 && PIND.1==1 && PIND.2==0 && PIND.3==1)           //5
      hit();
      
      
      
      }
}


void pullm1()
{
  PORTA.2=1;        
  PORTA.3=0;
  delay_ms(50);
  
}
void pullm2()
{
 PORTA.4=1;        
  PORTA.5=0;
  
  delay_ms(50);
}
void relsm2()
{
     PORTA.4=0;        
  PORTA.5=1;
  
  delay_ms(50);
}
void relsm1()
{
  PORTA.2=0;        
  PORTA.3=1;
  delay_ms(50);  
}
void hit()
{
  PORTA.2=0;        
  PORTA.3=1;
  PORTA.4=1;        
  PORTA.5=0;
  
  delay_ms(50);
}

void straight()
{
for(i=0;i<17;i++)
                      {
                       PORTA.0=1;        
                       PORTA.1=0;
                       PORTA.6=1;           
                        PORTA.7=0;
                        delay_ms(5); 
                        PORTA=0;    
                        delay_ms(1);
                        }  

}
}

void right()
{
  for(i=0;i<14;i++)
                      {
                       PORTA.0=1;        
   PORTA.1=0;
   PORTA.6=0;           
   PORTA.7=0;
   delay_ms(5); 
   PORTA=0;    
   delay_ms(1);
                        }
}


void left()
{
  for(i=0;i<14;i++)
                      {
                       PORTA.0=0;        
   PORTA.1=0;
   PORTA.6=1;           
   PORTA.7=0;
   delay_ms(5); 
   PORTA=0;    
   delay_ms(1);
                        }

}
void back()
{
  for(i=0;i<14;i++)
                      {
                       PORTA.0=0;        
   PORTA.1=1;
   PORTA.6=0;           
   PORTA.7=1;
   delay_ms(5); 
   PORTA=0;    
   delay_ms(1);
                        }

}


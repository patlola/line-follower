/*****************************************************
This program was produced by the
CodeWizardAVR V2.04.6 Evaluation
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 8/21/2011
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

void forward();
void turn_lft();
void turn_right();
void right();
void lft();
 int i=0;
void main(void)
{
// Declare your local variables here
   
// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

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
// Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T 
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

// Clock value: 1000.000 kHz
// Mode: Fast PWM top=00FFh
// OC1A output: Non-Inv.
// OC1B output: Non-Inv.
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

/*DDRA.0=1;           //M1
DDRA.1=1;

DDRA.6=1;           //M2
DDRA.7=1;     */

DDRA=255;

while (1)                    
      {   
           
       if(PINB.0==1)
       {     
            PORTD.4=1;
            PORTD.5=1;     
            while (1)
            {
             if(PIND.2==0)
             forward();
         /*    if(PIND.1==0 && PIND.2==1) 
             turn_right();
             if(PIND.3==0 && PIND.2==1) 
             turn_lft();
             if(PIND.0==0 && PIND.2==1)            
             right();
             if(PIND.6==0 && PIND.2==1) 
             lft(); 
             if(PIND.1==1 && PIND.2==1 && PIND.6==1 && PIND.3==1 && PIND.0==1)
             {PORTA=0;              
              delay_ms(500);                                  //back
             }   */
             PORTA=0;
             delay_ms(10000);
       }         
                                                
       }
      }

}
void forward()
    {
    for(i=0;i<10;i++)
    {   PORTA.0=1;        //lft
        PORTA.1=0;
        PORTA.6=1;           //right
        PORTA.7=0;
        delay_ms(23);
        
        PORTA=0;
        delay_ms(5);
    }
       
    }
 void turn_right()
    {
    for(i=0;i<8;i++)
    {   PORTA.0=1;        //lft
        PORTA.1=0;
        PORTA.6=0;           //right
        PORTA.7=0;
        delay_ms(23);
        
        PORTA=0;
        delay_ms(5);
    }
       
    }  
    void turn_lft()
    {
    for(i=0;i<8;i++)
    {   PORTA.0=0;        //lft
        PORTA.1=0;
        PORTA.6=1;           //right
        PORTA.7=0;
        delay_ms(23);
        
        PORTA=0;
        delay_ms(5);
    }
       
    }      
    
     void lft()
    {
    for(i=0;i<8;i++)
    {   PORTA.0=0;        //lft
        PORTA.1=1;
        PORTA.6=1;           //right
        PORTA.7=0;
        delay_ms(18);
        
        PORTA=0;
        delay_ms(7);
    }
       
    }
    
     
     void right()
    {
    for(i=0;i<8;i++)
    {   PORTA.0=1;        //lft
        PORTA.1=0;
        PORTA.6=0;           //right
        PORTA.7=1;
        delay_ms(18);
        
        PORTA=0;
        delay_ms(7);
    }
       
    }
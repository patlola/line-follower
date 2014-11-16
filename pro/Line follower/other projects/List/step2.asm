
;CodeVisionAVR C Compiler V2.04.6 Evaluation
;(C) Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type                : ATmega16
;Program type             : Application
;Clock frequency          : 8.000000 MHz
;Memory model             : Small
;Optimize for             : Size
;(s)printf features       : int, width
;(s)scanf features        : int, width
;External RAM size        : 0
;Data Stack size          : 256 byte(s)
;Heap size                : 0 byte(s)
;Promote 'char' to 'int'  : Yes
;'char' is unsigned       : Yes
;8 bit enums              : Yes
;global 'const' stored in FLASH: No
;Enhanced core instructions    : On
;Smart register allocation     : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega16
	#pragma AVRPART MEMORY PROG_FLASH 16384
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0060
	.EQU __SRAM_END=0x045F
	.EQU __DSTACK_SIZE=0x0100
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __GETD1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X+
	LD   R22,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _i=R4
	.DEF _dec=R6
	.DEF _chng=R8
	.DEF _x=R10
	.DEF _y=R12

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_0x4:
	.DB  LOW(_0x3),HIGH(_0x3)
_0x72:
	.DB  0x0,0x0
_0x0:
	.DB  0x73,0x73,0x73,0x73,0x73,0x77,0x77,0x77
	.DB  0x77,0x77,0x77,0x77,0x77,0x73,0x73,0x73
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x11
	.DW  _0x3
	.DW  _0x0*2

	.DW  0x02
	.DW  0x08
	.DW  _0x72*2

_0xFFFFFFFF:
	.DW  0

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,__SRAM_START
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.04.6 Evaluation
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 8/21/2011
;Author  : Freeware, for evaluation and non-commercial use only
;Company :
;Comments:
;
;
;Chip type               : ATmega16
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*****************************************************/
;
;#include <mega16.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x40
	.EQU __sm_mask=0xB0
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0xA0
	.EQU __sm_ext_standby=0xB0
	.EQU __sm_adc_noise_red=0x10
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;
;// Declare your global variables here
;void forward();
;void turn_right();
;void turn_lft();
;//void right();
;void back();
;//void lft();
;int i,dec,chng=0,x,y,x1,x2,y1,y2,inc=0;
;char pre,cur,p[16][16],*a="ssssswwwwwwwwsss";

	.DSEG
_0x3:
	.BYTE 0x11
;
;
;void main(void)
; 0000 0027 {

	.CSEG
_main:
; 0000 0028 // Declare your local variables here
; 0000 0029      int j=5;
; 0000 002A // Input/Output Ports initialization
; 0000 002B // Port A initialization
; 0000 002C // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 002D // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 002E PORTA=0x00;
;	j -> R16,R17
	__GETWRN 16,17,5
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 002F DDRA=0xFF;
	LDI  R30,LOW(255)
	OUT  0x1A,R30
; 0000 0030 
; 0000 0031 // Port B initialization
; 0000 0032 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0033 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 0034 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
; 0000 0035 DDRB=0x00;
	OUT  0x17,R30
; 0000 0036 
; 0000 0037 // Port C initialization
; 0000 0038 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
; 0000 0039 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
; 0000 003A PORTC=0x00;
	OUT  0x15,R30
; 0000 003B DDRC=0x00;
	OUT  0x14,R30
; 0000 003C 
; 0000 003D // Port D initialization
; 0000 003E // Func7=In Func6=In Func5=Out Func4=Out Func3=In Func2=In Func1=In Func0=In
; 0000 003F // State7=T State6=T State5=0 State4=0 State3=T State2=T State1=T State0=T
; 0000 0040 PORTD=0x00;
	OUT  0x12,R30
; 0000 0041 DDRD=0x30;
	LDI  R30,LOW(48)
	OUT  0x11,R30
; 0000 0042 
; 0000 0043 // Timer/Counter 0 initialization
; 0000 0044 // Clock source: System Clock
; 0000 0045 // Clock value: Timer 0 Stopped
; 0000 0046 // Mode: Normal top=FFh
; 0000 0047 // OC0 output: Disconnected
; 0000 0048 TCCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x33,R30
; 0000 0049 TCNT0=0x00;
	OUT  0x32,R30
; 0000 004A OCR0=0x00;
	OUT  0x3C,R30
; 0000 004B 
; 0000 004C // Timer/Counter 1 initialization
; 0000 004D // Clock source: System Clock
; 0000 004E // Clock value: 1000.000 kHz
; 0000 004F // Mode: Fast PWM top=00FFh
; 0000 0050 // OC1A output: Non-Inv.
; 0000 0051 // OC1B output: Non-Inv.
; 0000 0052 // Noise Canceler: Off
; 0000 0053 // Input Capture on Falling Edge
; 0000 0054 // Timer1 Overflow Interrupt: Off
; 0000 0055 // Input Capture Interrupt: Off
; 0000 0056 // Compare A Match Interrupt: Off
; 0000 0057 // Compare B Match Interrupt: Off
; 0000 0058 TCCR1A=0xA1;
	LDI  R30,LOW(161)
	OUT  0x2F,R30
; 0000 0059 TCCR1B=0x0A;
	LDI  R30,LOW(10)
	OUT  0x2E,R30
; 0000 005A TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
; 0000 005B TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 005C ICR1H=0x00;
	OUT  0x27,R30
; 0000 005D ICR1L=0x00;
	OUT  0x26,R30
; 0000 005E OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 005F OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 0060 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 0061 OCR1BL=0x00;
	OUT  0x28,R30
; 0000 0062 
; 0000 0063 // Timer/Counter 2 initialization
; 0000 0064 // Clock source: System Clock
; 0000 0065 // Clock value: Timer2 Stopped
; 0000 0066 // Mode: Normal top=FFh
; 0000 0067 // OC2 output: Disconnected
; 0000 0068 ASSR=0x00;
	OUT  0x22,R30
; 0000 0069 TCCR2=0x00;
	OUT  0x25,R30
; 0000 006A TCNT2=0x00;
	OUT  0x24,R30
; 0000 006B OCR2=0x00;
	OUT  0x23,R30
; 0000 006C 
; 0000 006D // External Interrupt(s) initialization
; 0000 006E // INT0: Off
; 0000 006F // INT1: Off
; 0000 0070 // INT2: Off
; 0000 0071 
; 0000 0072 MCUCR=0x00;
	OUT  0x35,R30
; 0000 0073 MCUCSR=0x00;
	OUT  0x34,R30
; 0000 0074 
; 0000 0075 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 0076 TIMSK=0x00;
	OUT  0x39,R30
; 0000 0077 
; 0000 0078 // Analog Comparator initialization
; 0000 0079 // Analog Comparator: Off
; 0000 007A // Analog Comparator Input Capture by Timer/Counter 1: Off
; 0000 007B ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 007C SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 007D 
; 0000 007E while (1)
_0x5:
; 0000 007F         {    if(PINB.0==1)
	SBIS 0x16,0
	RJMP _0x8
; 0000 0080            {
; 0000 0081 
; 0000 0082            while(1)
_0x9:
; 0000 0083             {
; 0000 0084 
; 0000 0085 
; 0000 0086              OCR1A=200;
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	OUT  0x2A+1,R31
	OUT  0x2A,R30
; 0000 0087                 OCR1B=200;
	OUT  0x28+1,R31
	OUT  0x28,R30
; 0000 0088          if(PIND.0==0 && PIND.2==1  )
	LDI  R26,0
	SBIC 0x10,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0xD
	SBIC 0x10,2
	RJMP _0xE
_0xD:
	RJMP _0xC
_0xE:
; 0000 0089               {
; 0000 008A               turn_right();
	RCALL _turn_right
; 0000 008B               delay_ms(7);
	RJMP _0x71
; 0000 008C               }else if(PIND.1==0 && PIND.0==1 )
_0xC:
	LDI  R26,0
	SBIC 0x10,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x11
	SBIC 0x10,0
	RJMP _0x12
_0x11:
	RJMP _0x10
_0x12:
; 0000 008D                 {forward();
	RCALL _forward
; 0000 008E                  delay_ms(7);
	RJMP _0x71
; 0000 008F                  }
; 0000 0090                 else if(PIND.0==0 && PIND.2==0 )
_0x10:
	LDI  R26,0
	SBIC 0x10,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x15
	LDI  R26,0
	SBIC 0x10,2
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x16
_0x15:
	RJMP _0x14
_0x16:
; 0000 0091                 {inc=inc+1;;
	LDS  R30,_inc
	LDS  R31,_inc+1
	ADIW R30,1
	STS  _inc,R30
	STS  _inc+1,R31
; 0000 0092                 if(inc%2==1)
	LDS  R26,_inc
	LDS  R27,_inc+1
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __MODW21
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x17
; 0000 0093                 turn_right();
	RCALL _turn_right
; 0000 0094                 else
	RJMP _0x18
_0x17:
; 0000 0095                 turn_lft();
	RCALL _turn_lft
; 0000 0096                 }
_0x18:
; 0000 0097 
; 0000 0098 
; 0000 0099                else if(PIND.2==0 )
	RJMP _0x19
_0x14:
	SBIC 0x10,2
	RJMP _0x1A
; 0000 009A                  { turn_lft();
	RCALL _turn_lft
; 0000 009B                   delay_ms(7);
	RJMP _0x71
; 0000 009C                   }
; 0000 009D               else if(PIND.0==1 && PIND.2==1 &&  PIND.2==1 )
_0x1A:
	SBIS 0x10,0
	RJMP _0x1D
	SBIS 0x10,2
	RJMP _0x1D
	SBIC 0x10,2
	RJMP _0x1E
_0x1D:
	RJMP _0x1C
_0x1E:
; 0000 009E                { back();
	RCALL _back
; 0000 009F                 delay_ms(7);
_0x71:
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	RCALL SUBOPT_0x0
; 0000 00A0                 }
; 0000 00A1 
; 0000 00A2 
; 0000 00A3 
; 0000 00A4              }
_0x1C:
_0x19:
	RJMP _0x9
; 0000 00A5 
; 0000 00A6 
; 0000 00A7            }
; 0000 00A8 
; 0000 00A9       }
_0x8:
	RJMP _0x5
; 0000 00AA }
_0x1F:
	RJMP _0x1F
;void forward()
; 0000 00AC {
_forward:
; 0000 00AD 
; 0000 00AE                       for(i=0;i<5;i++)
	CLR  R4
	CLR  R5
_0x21:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x22
; 0000 00AF                       {
; 0000 00B0 
; 0000 00B1                        PORTA.0=1;
	SBI  0x1B,0
; 0000 00B2 
; 0000 00B3                        PORTA.1=0;
	CBI  0x1B,1
; 0000 00B4                        if(i==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x27
; 0000 00B5                        PORTA.6=0;
	CBI  0x1B,6
; 0000 00B6                        else
	RJMP _0x2A
_0x27:
; 0000 00B7                        PORTA.6=1;
	SBI  0x1B,6
; 0000 00B8                         PORTA.7=0;
_0x2A:
	CBI  0x1B,7
; 0000 00B9                         if(i==4)
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	CP   R30,R4
	CPC  R31,R5
	BRNE _0x2F
; 0000 00BA                         delay_us(300);
	__DELAY_USW 600
; 0000 00BB                         else
	RJMP _0x30
_0x2F:
; 0000 00BC                         delay_ms(2);
	RCALL SUBOPT_0x1
; 0000 00BD                          PORTA=0;
_0x30:
	LDI  R30,LOW(0)
	OUT  0x1B,R30
; 0000 00BE                           delay_us(3750);
	__DELAY_USW 7500
; 0000 00BF                         }
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x21
_0x22:
; 0000 00C0 
; 0000 00C1                      /*  PORTA.0=1;
; 0000 00C2                        PORTA.1=0;
; 0000 00C3 
; 0000 00C4                        PORTA.6=1;
; 0000 00C5                         PORTA.7=0;
; 0000 00C6 
; 0000 00C7                         delay_ms(2);
; 0000 00C8                         PORTA.6=1;
; 0000 00C9                         PORTA.0=0;
; 0000 00CA                         delay_us(31);
; 0000 00CB                          PORTA=0;
; 0000 00CC                           delay_us(3850);
; 0000 00CD 
; 0000 00CE 
; 0000 00CF 
; 0000 00D0                        */
; 0000 00D1 
; 0000 00D2 }
	RET
; void turn_right()
; 0000 00D4     {
_turn_right:
; 0000 00D5   forward();
	RCALL _forward
; 0000 00D6 
; 0000 00D7    for(i=0;i<12;i++)
	CLR  R4
	CLR  R5
_0x32:
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x33
; 0000 00D8                       {
; 0000 00D9                        PORTA.0=1;
	SBI  0x1B,0
; 0000 00DA    PORTA.1=0;
	CBI  0x1B,1
; 0000 00DB    PORTA.6=0;
	CBI  0x1B,6
; 0000 00DC    if(i>=3 && i%3==0)
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CP   R4,R30
	CPC  R5,R31
	BRLT _0x3B
	MOVW R26,R4
	CALL __MODW21
	SBIW R30,0
	BREQ _0x3C
_0x3B:
	RJMP _0x3A
_0x3C:
; 0000 00DD    PORTA.7=1;
	SBI  0x1B,7
; 0000 00DE    else
	RJMP _0x3F
_0x3A:
; 0000 00DF    PORTA.7=0;
	CBI  0x1B,7
; 0000 00E0    delay_ms(2);
_0x3F:
	RCALL SUBOPT_0x1
; 0000 00E1    PORTA=0;
	RCALL SUBOPT_0x2
; 0000 00E2    delay_ms(4);
; 0000 00E3 
; 0000 00E4                         }
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x32
_0x33:
; 0000 00E5   forward();
	RJMP _0x2000001
; 0000 00E6 
; 0000 00E7    delay_ms(5);
; 0000 00E8 
; 0000 00E9     }
;    void turn_lft()
; 0000 00EB     {
_turn_lft:
; 0000 00EC 
; 0000 00ED 
; 0000 00EE   for(i=0;i<13;i++)
	CLR  R4
	CLR  R5
_0x43:
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x44
; 0000 00EF                       {
; 0000 00F0                        PORTA.0=0;
	CBI  0x1B,0
; 0000 00F1       if(i>=2 && i%2==0)
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CP   R4,R30
	CPC  R5,R31
	BRLT _0x48
	MOVW R26,R4
	CALL __MODW21
	SBIW R30,0
	BREQ _0x49
_0x48:
	RJMP _0x47
_0x49:
; 0000 00F2       PORTA.1=1;
	SBI  0x1B,1
; 0000 00F3       else
	RJMP _0x4C
_0x47:
; 0000 00F4       PORTA.1=0;
	CBI  0x1B,1
; 0000 00F5       PORTA.6=1;
_0x4C:
	SBI  0x1B,6
; 0000 00F6       PORTA.7=0;
	CBI  0x1B,7
; 0000 00F7       delay_ms(2);
	RCALL SUBOPT_0x1
; 0000 00F8       PORTA=0;
	RCALL SUBOPT_0x2
; 0000 00F9       delay_ms(4);
; 0000 00FA                         }
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x43
_0x44:
; 0000 00FB            forward();
_0x2000001:
	RCALL _forward
; 0000 00FC       delay_ms(5);
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	RCALL SUBOPT_0x0
; 0000 00FD 
; 0000 00FE     }
	RET
; /*     void lft()
;    {
;    for(i=0;i<10;i++)
;    {
;        PORTA.0=0;        //lft
;        PORTA.1=1;
;        PORTA.6=1;           //right
;        PORTA.7=0;
;        delay_us(400);
;
;        PORTA=0;
;        delay_us(850);
;    }
;
;    }
;
;
;     void right()
;    {
;    for(i=0;i<10;i++)
;    {
;        PORTA.0=1;        //lft
;        PORTA.1=0;
;        PORTA.6=0;           //right
;        PORTA.7=1;
;        delay_us(400);
;
;        PORTA=0;
;         delay_us(850);
;    }
;
;    }                    */
;    void back()
; 0000 0120     {  for(i=0;i<8;i++)
_back:
	CLR  R4
	CLR  R5
_0x54:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x55
; 0000 0121                       {
; 0000 0122                        PORTA.0=1;
	RCALL SUBOPT_0x3
; 0000 0123    PORTA.1=0;
; 0000 0124    PORTA.6=0;
; 0000 0125    PORTA.7=1;
; 0000 0126    delay_ms(2);
; 0000 0127    PORTA=0;
	RCALL SUBOPT_0x4
; 0000 0128    delay_ms(3);
; 0000 0129                         }
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x54
_0x55:
; 0000 012A 
; 0000 012B                        PORTA.0=0;
	CBI  0x1B,0
; 0000 012C    PORTA.1=1;
	SBI  0x1B,1
; 0000 012D    PORTA.6=0;
	CBI  0x1B,6
; 0000 012E    PORTA.7=1;
	SBI  0x1B,7
; 0000 012F    delay_ms(2);
	RCALL SUBOPT_0x1
; 0000 0130    PORTA=0;
	RCALL SUBOPT_0x4
; 0000 0131    delay_ms(3);
; 0000 0132 
; 0000 0133                         for(i=0;i<8;i++)
	CLR  R4
	CLR  R5
_0x67:
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	CP   R4,R30
	CPC  R5,R31
	BRGE _0x68
; 0000 0134                       {
; 0000 0135                        PORTA.0=1;
	RCALL SUBOPT_0x3
; 0000 0136    PORTA.1=0;
; 0000 0137    PORTA.6=0;
; 0000 0138    PORTA.7=1;
; 0000 0139    delay_ms(2);
; 0000 013A    PORTA=0;
	RCALL SUBOPT_0x4
; 0000 013B    delay_ms(3);
; 0000 013C                         }
	MOVW R30,R4
	ADIW R30,1
	MOVW R4,R30
	RJMP _0x67
_0x68:
; 0000 013D 
; 0000 013E                 }
	RET

	.DSEG
_inc:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x1:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	LDI  R30,LOW(0)
	OUT  0x1B,R30
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	RJMP SUBOPT_0x0

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	SBI  0x1B,0
	CBI  0x1B,1
	CBI  0x1B,6
	SBI  0x1B,7
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(0)
	OUT  0x1B,R30
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	RJMP SUBOPT_0x0


	.CSEG
_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

;END OF CODE MARKER
__END_OF_CODE:

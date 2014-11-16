
;CodeVisionAVR C Compiler V2.60 Evaluation
;(C) Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega16A
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#pragma AVRPART ADMIN PART_NAME ATmega16A
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

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
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
	.DEF _x=R4
	.DEF _y=R6
	.DEF _z=R8
	.DEF _w=R10
	.DEF _b=R12

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

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0


__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

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

;HARDWARE STACK POINTER INITIALIZATION
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
;/*******************************************************
;This program was created by the
;CodeWizardAVR V2.60 Evaluation
;Automatic Program Generator
;© Copyright 1998-2012 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 06-11-2012
;Author  :
;Company :
;Comments:
;
;
;Chip type               : ATmega16A
;Program type            : Application
;AVR Core Clock frequency: 8.000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 256
;*******************************************************/
;
;#include <mega16a.h>
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
;
;// Declare your global variables here
;int x = 0;
;int y = 0;
;int z = 0;
;int w = 0;
;int b = 0;
;int c = 0;
;
;void line1(void){
; 0000 0024 void line1(void){

	.CSEG
_line1:
; .FSTART _line1
; 0000 0025             if( PINA.3 == 1 && PINA.4 == 1 && PINA.5 == 1) {
	SBIS 0x19,3
	RJMP _0x4
	SBIS 0x19,4
	RJMP _0x4
	SBIC 0x19,5
	RJMP _0x5
_0x4:
	RJMP _0x3
_0x5:
; 0000 0026                   PORTD.2 = 0;
	RCALL SUBOPT_0x0
; 0000 0027                   PORTD.3 = 1;
; 0000 0028                   PORTD.7 = 0;
; 0000 0029                   PORTD.6 = 1;
; 0000 002A                   delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 002B                   PORTD.2 = 0;
; 0000 002C                   PORTD.3 = 0;
; 0000 002D                   PORTD.7 = 0;
; 0000 002E                   PORTD.6 = 0;
; 0000 002F                   delay_ms(1500);
	RJMP _0x2000003
; 0000 0030                   return;
; 0000 0031                   }         //stop at end
; 0000 0032 
; 0000 0033             if( PINA.0 == 0 & PINA.1 == 1 && PINA.2 == 0) {
_0x3:
	LDI  R26,0
	SBIC 0x19,0
	LDI  R26,1
	LDI  R30,LOW(0)
	RCALL __EQB12
	MOV  R0,R30
	LDI  R26,0
	SBIC 0x19,1
	LDI  R26,1
	LDI  R30,LOW(1)
	RCALL __EQB12
	AND  R30,R0
	BREQ _0x17
	RCALL SUBOPT_0x2
	BREQ _0x18
_0x17:
	RJMP _0x16
_0x18:
; 0000 0034                 if(x > 0 && y > 0 && w==0){
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x1A
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BRGE _0x1A
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BREQ _0x1B
_0x1A:
	RJMP _0x19
_0x1B:
; 0000 0035 
; 0000 0036                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x3
; 0000 0037                 delay_ms(1);
; 0000 0038                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0039                 delay_ms(25);
	LDI  R26,LOW(25)
	RJMP _0x2000004
; 0000 003A                 return;
; 0000 003B                 }                        //slow down speed after the second block
; 0000 003C                 else {
_0x19:
; 0000 003D                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x3
; 0000 003E                 delay_ms(1);
; 0000 003F                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0040                 delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 0041                 return;
; 0000 0042                 }                       //general speed to follow
; 0000 0043             }
; 0000 0044 
; 0000 0045             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
_0x16:
	SBIS 0x19,0
	RJMP _0x3E
	RCALL SUBOPT_0x4
	BRNE _0x3E
	SBIC 0x19,2
	RJMP _0x3F
_0x3E:
	RJMP _0x3D
_0x3F:
; 0000 0046                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 0047                 delay_ms(1);
; 0000 0048                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0049                 delay_ms(5);
	RJMP _0x2000004
; 0000 004A                 return;
; 0000 004B             }                           //condition on exception to turn left
; 0000 004C 
; 0000 004D             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0x3D:
	SBIS 0x19,0
	RJMP _0x51
	SBIS 0x19,1
	RJMP _0x51
	SBIC 0x19,2
	RJMP _0x52
_0x51:
	RJMP _0x50
_0x52:
; 0000 004E                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x3
; 0000 004F                 delay_ms(1);
; 0000 0050                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0051                 delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 0052                 return;
; 0000 0053             }
; 0000 0054             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0x50:
	RCALL SUBOPT_0x6
	BRNE _0x64
	RCALL SUBOPT_0x4
	BRNE _0x64
	RCALL SUBOPT_0x2
	BREQ _0x65
_0x64:
	RJMP _0x63
_0x65:
; 0000 0055                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x0
; 0000 0056                 delay_ms(1);
	LDI  R26,LOW(1)
	RCALL SUBOPT_0x7
; 0000 0057                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	CBI  0x12,7
	CBI  0x12,6
; 0000 0058                 delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 0059                 return;
; 0000 005A             }
; 0000 005B 
; 0000 005C              if( PINA.0 == 1 && PINA.2 == 0) {
_0x63:
	SBIS 0x19,0
	RJMP _0x77
	RCALL SUBOPT_0x2
	BREQ _0x78
_0x77:
	RJMP _0x76
_0x78:
; 0000 005D                   PORTD.6 = 0;
	RCALL SUBOPT_0x8
; 0000 005E                   PORTD.7 = 0;
; 0000 005F                   PORTD.2 = 1;
; 0000 0060                   PORTD.3 = 0;
; 0000 0061                   delay_ms(2);
; 0000 0062                   PORTD.2 = 0;
; 0000 0063                   PORTD.3 = 0;
; 0000 0064                   delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 0065                   return;
; 0000 0066               }
; 0000 0067              if( PINA.0 == 0 && PINA.2 == 1) {
_0x76:
	RCALL SUBOPT_0x6
	BRNE _0x86
	SBIC 0x19,2
	RJMP _0x87
_0x86:
	RJMP _0x85
_0x87:
; 0000 0068                 if(PINA.1 == 1 && w==0){
	SBIS 0x19,1
	RJMP _0x89
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BREQ _0x8A
_0x89:
	RJMP _0x88
_0x8A:
; 0000 0069                  PORTD.6 = 0;
	CBI  0x12,6
; 0000 006A                   PORTD.7 = 1;
	SBI  0x12,7
; 0000 006B                   PORTD.2 = 1;
	SBI  0x12,2
; 0000 006C                   PORTD.3 = 0;
	RCALL SUBOPT_0x9
; 0000 006D                   delay_ms(2);
; 0000 006E                   PORTD.6 = 0;
; 0000 006F                   PORTD.7 = 0;
; 0000 0070                   PORTD.2 = 0;
	CBI  0x12,2
; 0000 0071                   PORTD.3 = 0;
	CBI  0x12,3
; 0000 0072                   delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 0073                   return;
; 0000 0074                   }
; 0000 0075                 else{
_0x88:
; 0000 0076                 PORTD.6 = 0;
	RCALL SUBOPT_0xA
; 0000 0077                   PORTD.7 = 1;
; 0000 0078                   PORTD.2 = 0;
; 0000 0079                   PORTD.3 = 0;
; 0000 007A                   delay_ms(2);
; 0000 007B                   PORTD.6 = 0;
; 0000 007C                   PORTD.7 = 0;
; 0000 007D                   delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 007E                   return;}
; 0000 007F               }
; 0000 0080 
; 0000 0081               return;
_0x85:
	RET
; 0000 0082 }
; .FEND
;
;void line2(void){
; 0000 0084 void line2(void){
_line2:
; .FSTART _line2
; 0000 0085 
; 0000 0086 if( PINA.3 == 1 && PINA.4 == 1 && PINA.5 == 1) {
	SBIS 0x19,3
	RJMP _0xA9
	SBIS 0x19,4
	RJMP _0xA9
	SBIC 0x19,5
	RJMP _0xAA
_0xA9:
	RJMP _0xA8
_0xAA:
; 0000 0087                   PORTD.2 = 0;
	RCALL SUBOPT_0x0
; 0000 0088                   PORTD.3 = 1;
; 0000 0089                   PORTD.7 = 0;
; 0000 008A                   PORTD.6 = 1;
; 0000 008B                   delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 008C                   PORTD.2 = 0;
; 0000 008D                   PORTD.3 = 0;
; 0000 008E                   PORTD.7 = 0;
; 0000 008F                   PORTD.6 = 0;
; 0000 0090                   delay_ms(1500);
	RJMP _0x2000003
; 0000 0091                   return;
; 0000 0092                   }
; 0000 0093 
; 0000 0094 if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0xA8:
	RCALL SUBOPT_0x6
	BRNE _0xBC
	SBIS 0x19,1
	RJMP _0xBC
	RCALL SUBOPT_0x2
	BREQ _0xBD
_0xBC:
	RJMP _0xBB
_0xBD:
; 0000 0095                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x3
; 0000 0096                 delay_ms(1);
; 0000 0097                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0098                 delay_ms(5);
	LDI  R26,LOW(5)
	RJMP _0x2000004
; 0000 0099                 return;
; 0000 009A             }
; 0000 009B 
; 0000 009C             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
_0xBB:
	SBIS 0x19,0
	RJMP _0xCF
	RCALL SUBOPT_0x4
	BRNE _0xCF
	SBIC 0x19,2
	RJMP _0xD0
_0xCF:
	RJMP _0xCE
_0xD0:
; 0000 009D                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 009E                 delay_ms(1);
; 0000 009F                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 00A0                 delay_ms(5);
	RJMP _0x2000004
; 0000 00A1                 return;
; 0000 00A2             }
; 0000 00A3 
; 0000 00A4             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0xCE:
	SBIS 0x19,0
	RJMP _0xE2
	SBIS 0x19,1
	RJMP _0xE2
	SBIC 0x19,2
	RJMP _0xE3
_0xE2:
	RJMP _0xE1
_0xE3:
; 0000 00A5                 if(b>0 && w>0){
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BRGE _0xE5
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRLT _0xE6
_0xE5:
	RJMP _0xE4
_0xE6:
; 0000 00A6                       PORTD.2 = 1;
	RCALL SUBOPT_0xB
; 0000 00A7                       PORTD.3 = 0;
; 0000 00A8                       PORTD.7 = 0;
; 0000 00A9                       PORTD.6 = 0;
; 0000 00AA                       delay_ms(4);
	LDI  R26,LOW(4)
	RCALL SUBOPT_0x7
; 0000 00AB                       PORTD.2 = 0;
; 0000 00AC                       PORTD.3 = 0;
; 0000 00AD                       delay_ms(6);
	LDI  R26,LOW(6)
	RJMP _0x230
; 0000 00AE                 }   //after wall...
; 0000 00AF                 else { PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
_0xE4:
	RCALL SUBOPT_0x3
; 0000 00B0                 delay_ms(1);
; 0000 00B1                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 00B2                 delay_ms(4);}
	LDI  R26,LOW(4)
_0x230:
	LDI  R27,0
	RCALL _delay_ms
; 0000 00B3                 return;
	RET
; 0000 00B4             }
; 0000 00B5             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0xE1:
	RCALL SUBOPT_0x6
	BRNE _0x105
	RCALL SUBOPT_0x4
	BRNE _0x105
	RCALL SUBOPT_0x2
	BREQ _0x106
_0x105:
	RJMP _0x104
_0x106:
; 0000 00B6                 //if(x>0 && y>0 && c==0 && b==0 && z>0 ){
; 0000 00B7                 if(w>0 && (b>0 || c>0)){
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRGE _0x108
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BRLT _0x109
	RCALL SUBOPT_0xC
	BRGE _0x108
_0x109:
	RJMP _0x10B
_0x108:
	RJMP _0x107
_0x10B:
; 0000 00B8                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x0
; 0000 00B9                 delay_ms(2);
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x7
; 0000 00BA                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	CBI  0x12,7
	CBI  0x12,6
; 0000 00BB                 delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 00BC                 return;
; 0000 00BD                 }
; 0000 00BE 
; 0000 00BF 
; 0000 00C0                    if(PINA.4 == 0 && PINA.5 == 0 && b==0 && w>0) {
_0x107:
	RCALL SUBOPT_0xD
	BRNE _0x11D
	RCALL SUBOPT_0xE
	BRNE _0x11D
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BRNE _0x11D
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRLT _0x11E
_0x11D:
	RJMP _0x11C
_0x11E:
; 0000 00C1                       PORTD.2 = 1;
	RCALL SUBOPT_0xB
; 0000 00C2                       PORTD.3 = 0;
; 0000 00C3                       PORTD.7 = 0;
; 0000 00C4                       PORTD.6 = 0;
; 0000 00C5                       delay_ms(6);
	LDI  R26,LOW(6)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00C6                       PORTD.2 = 0;
	CBI  0x12,2
; 0000 00C7                       delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00C8                       }
; 0000 00C9                   /*
; 0000 00CA                         if(PINA.4 == 0 && PINA.5 == 0 && w == 0) {
; 0000 00CB                       PORTD.2 = 1;
; 0000 00CC                       PORTD.3 = 0;
; 0000 00CD                       PORTD.7 = 1;
; 0000 00CE                       PORTD.6 = 0;
; 0000 00CF                       delay_ms(1);
; 0000 00D0                       PORTD.2 = 0;
; 0000 00D1                       PORTD.3 = 0;
; 0000 00D2                       PORTD.7 = 0;
; 0000 00D3                       PORTD.6 = 0;
; 0000 00D4                       delay_ms(2);
; 0000 00D5                       }
; 0000 00D6 
; 0000 00D7                 }   */
; 0000 00D8                     else{
	RJMP _0x129
_0x11C:
; 0000 00D9                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x0
; 0000 00DA                 delay_ms(2);
	LDI  R26,LOW(2)
	RCALL SUBOPT_0x7
; 0000 00DB                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	CBI  0x12,7
	CBI  0x12,6
; 0000 00DC                 delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 00DD                 return;
; 0000 00DE                 }
_0x129:
; 0000 00DF                 return;
	RET
; 0000 00E0                // }
; 0000 00E1             }
; 0000 00E2 
; 0000 00E3              if( PINA.0 == 1 && PINA.2 == 0) {
_0x104:
	SBIS 0x19,0
	RJMP _0x13B
	RCALL SUBOPT_0x2
	BREQ _0x13C
_0x13B:
	RJMP _0x13A
_0x13C:
; 0000 00E4                   PORTD.6 = 0;
	RCALL SUBOPT_0x8
; 0000 00E5                   PORTD.7 = 0;
; 0000 00E6                   PORTD.2 = 1;
; 0000 00E7                   PORTD.3 = 0;
; 0000 00E8                   delay_ms(2);
; 0000 00E9                   PORTD.2 = 0;
; 0000 00EA                   PORTD.3 = 0;
; 0000 00EB                   delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 00EC                     return;
; 0000 00ED               }
; 0000 00EE              if( PINA.0 == 0 && PINA.2 == 1) {
_0x13A:
	RCALL SUBOPT_0x6
	BRNE _0x14A
	SBIC 0x19,2
	RJMP _0x14B
_0x14A:
	RJMP _0x149
_0x14B:
; 0000 00EF                   PORTD.6 = 0;
	RCALL SUBOPT_0xA
; 0000 00F0                   PORTD.7 = 1;
; 0000 00F1                   PORTD.2 = 0;
; 0000 00F2                   PORTD.3 = 0;
; 0000 00F3                   delay_ms(2);
; 0000 00F4                   PORTD.6 = 0;
; 0000 00F5                   PORTD.7 = 0;
; 0000 00F6                   delay_ms(1);
	LDI  R26,LOW(1)
	RJMP _0x2000004
; 0000 00F7                   return;
; 0000 00F8               }
; 0000 00F9               return;
_0x149:
	RET
; 0000 00FA }
; .FEND
;
;
;void wall(void){
; 0000 00FD void wall(void){
_wall:
; .FSTART _wall
; 0000 00FE if( PINA.3 == 1 && PINA.4 == 0 && PINA.5 == 0) {
	SBIS 0x19,3
	RJMP _0x159
	RCALL SUBOPT_0xD
	BRNE _0x159
	RCALL SUBOPT_0xE
	BREQ _0x15A
_0x159:
	RJMP _0x158
_0x15A:
; 0000 00FF                   PORTD.2 = 1;
	RCALL SUBOPT_0x3
; 0000 0100                   PORTD.3 = 0;
; 0000 0101                   PORTD.7 = 1;
; 0000 0102                   PORTD.6 = 0;
; 0000 0103                   delay_ms(1);
; 0000 0104                   PORTD.2 = 0;
; 0000 0105                   PORTD.3 = 0;
; 0000 0106                   PORTD.7 = 0;
; 0000 0107                   PORTD.6 = 0;
; 0000 0108                   delay_ms(4);
	LDI  R26,LOW(4)
	RJMP _0x2000004
; 0000 0109                   return;
; 0000 010A                   }
; 0000 010B                   if( PINA.3 == 1 && PINA.4 == 0 && PINA.5 == 1) {
_0x158:
	SBIS 0x19,3
	RJMP _0x16C
	RCALL SUBOPT_0xD
	BRNE _0x16C
	SBIC 0x19,5
	RJMP _0x16D
_0x16C:
	RJMP _0x16B
_0x16D:
; 0000 010C                   PORTD.2 = 1;
	RCALL SUBOPT_0x3
; 0000 010D                   PORTD.3 = 0;
; 0000 010E                   PORTD.7 = 1;
; 0000 010F                   PORTD.6 = 0;
; 0000 0110                   delay_ms(1);
; 0000 0111                   PORTD.2 = 0;
; 0000 0112                   PORTD.3 = 0;
; 0000 0113                   PORTD.7 = 0;
; 0000 0114                   PORTD.6 = 0;
; 0000 0115                   delay_ms(4);
	LDI  R26,LOW(4)
	RJMP _0x2000004
; 0000 0116                   return;
; 0000 0117                   }
; 0000 0118 
; 0000 0119                   if( PINA.3 == 1 && PINA.4 == 1 && PINA.5 == 1) {
_0x16B:
	SBIS 0x19,3
	RJMP _0x17F
	SBIS 0x19,4
	RJMP _0x17F
	SBIC 0x19,5
	RJMP _0x180
_0x17F:
	RJMP _0x17E
_0x180:
; 0000 011A                   PORTD.2 = 0;
	RCALL SUBOPT_0x0
; 0000 011B                   PORTD.3 = 1;
; 0000 011C                   PORTD.7 = 0;
; 0000 011D                   PORTD.6 = 1;
; 0000 011E                   delay_ms(5);
	RCALL SUBOPT_0x1
; 0000 011F                   PORTD.2 = 0;
; 0000 0120                   PORTD.3 = 0;
; 0000 0121                   PORTD.7 = 0;
; 0000 0122                   PORTD.6 = 0;
; 0000 0123                   delay_ms(1500);
	RJMP _0x2000003
; 0000 0124                   return;
; 0000 0125                   }
; 0000 0126 
; 0000 0127                   if( PINA.3 == 0 && PINA.4 == 0 && PINA.5 == 0) {
_0x17E:
	RCALL SUBOPT_0xF
	BRNE _0x192
	RCALL SUBOPT_0xD
	BRNE _0x192
	RCALL SUBOPT_0xE
	BREQ _0x193
_0x192:
	RJMP _0x191
_0x193:
; 0000 0128                   PORTD.2 = 1;
	SBI  0x12,2
; 0000 0129                   PORTD.3 = 0;
	CBI  0x12,3
; 0000 012A                   PORTD.7 = 0;
	CBI  0x12,7
; 0000 012B                   PORTD.6 = 0;
	RJMP _0x2000002
; 0000 012C                   delay_ms(6);
; 0000 012D                   PORTD.2 = 0;
; 0000 012E                   PORTD.3 = 0;
; 0000 012F                   PORTD.7 = 0;
; 0000 0130                   PORTD.6 = 0;
; 0000 0131                   delay_ms(2);
; 0000 0132                   return;
; 0000 0133                   }
; 0000 0134 
; 0000 0135                    if( PINA.3 == 0 && PINA.4 == 0 && PINA.5 == 1) {
_0x191:
	RCALL SUBOPT_0xF
	BRNE _0x1A5
	RCALL SUBOPT_0xD
	BRNE _0x1A5
	SBIC 0x19,5
	RJMP _0x1A6
_0x1A5:
	RJMP _0x1A4
_0x1A6:
; 0000 0136                   PORTD.2 = 1;
	SBI  0x12,2
; 0000 0137                   PORTD.3 = 0;
	CBI  0x12,3
; 0000 0138                   PORTD.7 = 0;
	CBI  0x12,7
; 0000 0139                   PORTD.6 = 0;
	RJMP _0x2000002
; 0000 013A                   delay_ms(6);
; 0000 013B                   PORTD.2 = 0;
; 0000 013C                   PORTD.3 = 0;
; 0000 013D                   PORTD.7 = 0;
; 0000 013E                   PORTD.6 = 0;
; 0000 013F                   delay_ms(2);
; 0000 0140                   return;
; 0000 0141                   }
; 0000 0142 
; 0000 0143 
; 0000 0144                   if( PINA.3 == 0 && PINA.4 == 1 && PINA.5 == 1) {
_0x1A4:
	RCALL SUBOPT_0xF
	BRNE _0x1B8
	SBIS 0x19,4
	RJMP _0x1B8
	SBIC 0x19,5
	RJMP _0x1B9
_0x1B8:
	RJMP _0x1B7
_0x1B9:
; 0000 0145                   PORTD.2 = 1;
	SBI  0x12,2
; 0000 0146                   PORTD.3 = 0;
	CBI  0x12,3
; 0000 0147                   PORTD.7 = 0;
	CBI  0x12,7
; 0000 0148                   PORTD.6 = 0;
	RJMP _0x2000002
; 0000 0149                   delay_ms(6);
; 0000 014A                   PORTD.2 = 0;
; 0000 014B                   PORTD.3 = 0;
; 0000 014C                   PORTD.7 = 0;
; 0000 014D                   PORTD.6 = 0;
; 0000 014E                   delay_ms(2);
; 0000 014F                   return;
; 0000 0150                   }
; 0000 0151                   if( PINA.3 == 0 && PINA.4 == 1 && PINA.5 == 0) {
_0x1B7:
	RCALL SUBOPT_0xF
	BRNE _0x1CB
	SBIS 0x19,4
	RJMP _0x1CB
	RCALL SUBOPT_0xE
	BREQ _0x1CC
_0x1CB:
	RJMP _0x1CA
_0x1CC:
; 0000 0152                   PORTD.2 = 0;
	RJMP _0x2000001
; 0000 0153                   PORTD.3 = 0;
; 0000 0154                   PORTD.7 = 1;
; 0000 0155                   PORTD.6 = 0;
; 0000 0156                   delay_ms(6);
; 0000 0157                   PORTD.2 = 0;
; 0000 0158                   PORTD.3 = 0;
; 0000 0159                   PORTD.7 = 0;
; 0000 015A                   PORTD.6 = 0;
; 0000 015B                   delay_ms(2);
; 0000 015C                   return;
; 0000 015D                   }
; 0000 015E                   if( PINA.3 == 1 && PINA.4 == 1 && PINA.5 == 0) {
_0x1CA:
	SBIS 0x19,3
	RJMP _0x1DE
	SBIS 0x19,4
	RJMP _0x1DE
	RCALL SUBOPT_0xE
	BREQ _0x1DF
_0x1DE:
	RJMP _0x1DD
_0x1DF:
; 0000 015F                   PORTD.2 = 0;
_0x2000001:
	CBI  0x12,2
; 0000 0160                   PORTD.3 = 0;
	CBI  0x12,3
; 0000 0161                   PORTD.7 = 1;
	SBI  0x12,7
; 0000 0162                   PORTD.6 = 0;
_0x2000002:
	CBI  0x12,6
; 0000 0163                   delay_ms(6);
	LDI  R26,LOW(6)
	RCALL SUBOPT_0x7
; 0000 0164                   PORTD.2 = 0;
; 0000 0165                   PORTD.3 = 0;
; 0000 0166                   PORTD.7 = 0;
	CBI  0x12,7
; 0000 0167                   PORTD.6 = 0;
	CBI  0x12,6
; 0000 0168                   delay_ms(2);
	LDI  R26,LOW(2)
_0x2000004:
	LDI  R27,0
_0x2000003:
	RCALL _delay_ms
; 0000 0169                   return;
	RET
; 0000 016A                   }
; 0000 016B                   return;
_0x1DD:
	RET
; 0000 016C }
; .FEND
;
;
;void main(void)
; 0000 0170 {
_main:
; .FSTART _main
; 0000 0171 // Declare your local variables here
; 0000 0172 
; 0000 0173 // Input/Output Ports initialization
; 0000 0174 // Port A initialization
; 0000 0175 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0176 DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 0177 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0178 PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 0179 
; 0000 017A // Port B initialization
; 0000 017B // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 017C DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 017D // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 017E PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 017F 
; 0000 0180 // Port C initialization
; 0000 0181 // Function: Bit7=In Bit6=In Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0182 DDRC=(0<<DDC7) | (0<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(63)
	OUT  0x14,R30
; 0000 0183 // State: Bit7=T Bit6=T Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0184 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0185 
; 0000 0186 // Port D initialization
; 0000 0187 // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0188 DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 0189 // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 018A PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 018B 
; 0000 018C // Timer/Counter 0 initialization
; 0000 018D // Clock source: System Clock
; 0000 018E // Clock value: Timer 0 Stopped
; 0000 018F // Mode: Normal top=0xFF
; 0000 0190 // OC0 output: Disconnected
; 0000 0191 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0192 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0193 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0194 
; 0000 0195 // Timer/Counter 1 initialization
; 0000 0196 // Clock source: System Clock
; 0000 0197 // Clock value: Timer1 Stopped
; 0000 0198 // Mode: Normal top=0xFFFF
; 0000 0199 // OC1A output: Disconnected
; 0000 019A // OC1B output: Disconnected
; 0000 019B // Noise Canceler: Off
; 0000 019C // Input Capture on Falling Edge
; 0000 019D // Timer1 Overflow Interrupt: Off
; 0000 019E // Input Capture Interrupt: Off
; 0000 019F // Compare A Match Interrupt: Off
; 0000 01A0 // Compare B Match Interrupt: Off
; 0000 01A1 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 01A2 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 01A3 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 01A4 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 01A5 ICR1H=0x00;
	OUT  0x27,R30
; 0000 01A6 ICR1L=0x00;
	OUT  0x26,R30
; 0000 01A7 OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 01A8 OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 01A9 OCR1BH=0x00;
	OUT  0x29,R30
; 0000 01AA OCR1BL=0x00;
	OUT  0x28,R30
; 0000 01AB 
; 0000 01AC // Timer/Counter 2 initialization
; 0000 01AD // Clock source: System Clock
; 0000 01AE // Clock value: Timer2 Stopped
; 0000 01AF // Mode: Normal top=0xFF
; 0000 01B0 // OC2 output: Disconnected
; 0000 01B1 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 01B2 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 01B3 TCNT2=0x00;
	OUT  0x24,R30
; 0000 01B4 OCR2=0x00;
	OUT  0x23,R30
; 0000 01B5 
; 0000 01B6 // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 01B7 TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 01B8 
; 0000 01B9 // External Interrupt(s) initialization
; 0000 01BA // INT0: Off
; 0000 01BB // INT1: Off
; 0000 01BC // INT2: Off
; 0000 01BD MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 01BE MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 01BF 
; 0000 01C0 // USART initialization
; 0000 01C1 // USART disabled
; 0000 01C2 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 01C3 
; 0000 01C4 // Analog Comparator initialization
; 0000 01C5 // Analog Comparator: Off
; 0000 01C6 ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 01C7 SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 01C8 
; 0000 01C9 // ADC initialization
; 0000 01CA // ADC disabled
; 0000 01CB ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 01CC 
; 0000 01CD // SPI initialization
; 0000 01CE // SPI disabled
; 0000 01CF SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 01D0 
; 0000 01D1 // TWI initialization
; 0000 01D2 // TWI disabled
; 0000 01D3 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 01D4 
; 0000 01D5 PORTD.4 = 1;
	SBI  0x12,4
; 0000 01D6 PORTD.5 = 1;
	SBI  0x12,5
; 0000 01D7 delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01D8 
; 0000 01D9 while (1)
_0x1F4:
; 0000 01DA {
; 0000 01DB //0th part
; 0000 01DC  if( PINA.3 == 0 && w==0){
	RCALL SUBOPT_0xF
	BRNE _0x1F8
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BREQ _0x1F9
_0x1F8:
	RJMP _0x1F7
_0x1F9:
; 0000 01DD         z=0;
	CLR  R8
	CLR  R9
; 0000 01DE        if(x>0 && y>0 && w==0) line1();
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x1FB
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BRGE _0x1FB
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BREQ _0x1FC
_0x1FB:
	RJMP _0x1FA
_0x1FC:
	RCALL _line1
; 0000 01DF         line2();}
_0x1FA:
	RCALL _line2
; 0000 01E0  //1ST PART
; 0000 01E1  else{
	RJMP _0x1FD
_0x1F7:
; 0000 01E2                 //PORTD.1 = 1;
; 0000 01E3         if(w==0 && PINA.3 == 1){
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRNE _0x1FF
	SBIC 0x19,3
	RJMP _0x200
_0x1FF:
	RJMP _0x1FE
_0x200:
; 0000 01E4             if(x==0){
	MOV  R0,R4
	OR   R0,R5
	BRNE _0x201
; 0000 01E5                 x=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
; 0000 01E6                 z=1;
	MOVW R8,R30
; 0000 01E7                 PORTD.1 = 1;
	SBI  0x12,1
; 0000 01E8 
; 0000 01E9                 line1();
	RCALL _line1
; 0000 01EA             }
; 0000 01EB 
; 0000 01EC 
; 0000 01ED             if( x>0 && z>0 && y == 0){
_0x201:
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x205
	CLR  R0
	CP   R0,R8
	CPC  R0,R9
	BRGE _0x205
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BREQ _0x206
_0x205:
	RJMP _0x204
_0x206:
; 0000 01EE                 line1();
	RCALL _line1
; 0000 01EF             }
; 0000 01F0 //2nd part
; 0000 01F1             if( x>0 && z==0 && y==0){
_0x204:
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x208
	CLR  R0
	CP   R0,R8
	CPC  R0,R9
	BRNE _0x208
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BREQ _0x209
_0x208:
	RJMP _0x207
_0x209:
; 0000 01F2                 z=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R8,R30
; 0000 01F3                 y=1;
	MOVW R6,R30
; 0000 01F4                 PORTC.1 = 1;
	SBI  0x15,1
; 0000 01F5                 line1();}
	RCALL _line1
; 0000 01F6 
; 0000 01F7             if( x>0 && z>0 && y > 0){
_0x207:
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x20D
	CLR  R0
	CP   R0,R8
	CPC  R0,R9
	BRGE _0x20D
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BRLT _0x20E
_0x20D:
	RJMP _0x20C
_0x20E:
; 0000 01F8                 line1();
	RCALL _line1
; 0000 01F9             }
; 0000 01FA 
; 0000 01FB         }
_0x20C:
; 0000 01FC         if(w>0 && PINA.3 == 1){
_0x1FE:
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRGE _0x210
	SBIC 0x19,3
	RJMP _0x211
_0x210:
	RJMP _0x20F
_0x211:
; 0000 01FD             if(PINA.0 == 1 || PINA.1 ==1 || PINA.2 == 1){
	SBIC 0x19,0
	RJMP _0x213
	SBIC 0x19,1
	RJMP _0x213
	SBIS 0x19,2
	RJMP _0x212
_0x213:
; 0000 01FE                 if( x>0 && w>0 && b==0){
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x216
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRGE _0x216
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BREQ _0x217
_0x216:
	RJMP _0x215
_0x217:
; 0000 01FF                     b=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R12,R30
; 0000 0200                     z=1;
	MOVW R8,R30
; 0000 0201                     line1();
	RCALL _line1
; 0000 0202                 }
; 0000 0203                 if( x>0 && w>0 && b>0 && z==0){
_0x215:
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRGE _0x219
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRGE _0x219
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BRGE _0x219
	CLR  R0
	CP   R0,R8
	CPC  R0,R9
	BREQ _0x21A
_0x219:
	RJMP _0x218
_0x21A:
; 0000 0204                     c=1;
	RCALL SUBOPT_0x10
; 0000 0205                     PORTC.0 = 1;
	SBI  0x15,0
; 0000 0206                     line1();
; 0000 0207                 }
; 0000 0208                 else line1();
_0x218:
_0x231:
	RCALL _line1
; 0000 0209             }
; 0000 020A             else {
	RJMP _0x21E
_0x212:
; 0000 020B                 z=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R8,R30
; 0000 020C                 wall();
	RCALL _wall
; 0000 020D                 }
_0x21E:
; 0000 020E         }
; 0000 020F         if(w>0 && PINA.3 == 0){
_0x20F:
	CLR  R0
	CP   R0,R10
	CPC  R0,R11
	BRGE _0x220
	RCALL SUBOPT_0xF
	BREQ _0x221
_0x220:
	RJMP _0x21F
_0x221:
; 0000 0210             z=0;
	CLR  R8
	CLR  R9
; 0000 0211             if(PINA.0 ==1 || PINA.1 == 1 || PINA.2 == 1) {
	SBIC 0x19,0
	RJMP _0x223
	SBIC 0x19,1
	RJMP _0x223
	SBIS 0x19,2
	RJMP _0x222
_0x223:
; 0000 0212                     c = 1;
	RCALL SUBOPT_0x10
; 0000 0213                     line2();
	RCALL _line2
; 0000 0214                     }
; 0000 0215             else {if(b>0 || c>0) line2();
	RJMP _0x225
_0x222:
	CLR  R0
	CP   R0,R12
	CPC  R0,R13
	BRLT _0x227
	RCALL SUBOPT_0xC
	BRGE _0x226
_0x227:
	RCALL _line2
; 0000 0216                     else wall();
	RJMP _0x229
_0x226:
	RCALL _wall
; 0000 0217                     }
_0x229:
_0x225:
; 0000 0218         }
; 0000 0219 
; 0000 021A 
; 0000 021B }//else ends here
_0x21F:
_0x1FD:
; 0000 021C 
; 0000 021D 
; 0000 021E 
; 0000 021F //3rd Part......wall
; 0000 0220 if(PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0 && (PINA.3 == 1 || PINA.4 == 1 || PINA.5 == 1)){
	RCALL SUBOPT_0x6
	BRNE _0x22B
	RCALL SUBOPT_0x4
	BRNE _0x22B
	RCALL SUBOPT_0x2
	BRNE _0x22B
	SBIC 0x19,3
	RJMP _0x22C
	SBIC 0x19,4
	RJMP _0x22C
	SBIS 0x19,5
	RJMP _0x22B
_0x22C:
	RJMP _0x22E
_0x22B:
	RJMP _0x22A
_0x22E:
; 0000 0221             w=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R10,R30
; 0000 0222             wall();
	RCALL _wall
; 0000 0223 }
; 0000 0224 
; 0000 0225 
; 0000 0226 }}
_0x22A:
	RJMP _0x1F4
_0x22F:
	RJMP _0x22F
; .FEND

	.DSEG
_c:
	.BYTE 0x2

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x0:
	CBI  0x12,2
	SBI  0x12,3
	CBI  0x12,7
	SBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:14 WORDS
SUBOPT_0x1:
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(1500)
	LDI  R27,HIGH(1500)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x2:
	LDI  R26,0
	SBIC 0x19,2
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:58 WORDS
SUBOPT_0x3:
	SBI  0x12,2
	CBI  0x12,3
	SBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x4:
	LDI  R26,0
	SBIC 0x19,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5:
	SBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(5)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x6:
	LDI  R26,0
	SBIC 0x19,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x7:
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x8:
	CBI  0x12,6
	CBI  0x12,7
	SBI  0x12,2
	CBI  0x12,3
	LDI  R26,LOW(2)
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x9:
	CBI  0x12,3
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,6
	CBI  0x12,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	CBI  0x12,6
	SBI  0x12,7
	CBI  0x12,2
	RJMP SUBOPT_0x9

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	SBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0xC:
	LDS  R26,_c
	LDS  R27,_c+1
	RCALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xD:
	LDI  R26,0
	SBIC 0x19,4
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0xE:
	LDI  R26,0
	SBIC 0x19,5
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xF:
	LDI  R26,0
	SBIC 0x19,3
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _c,R30
	STS  _c+1,R31
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__EQB12:
	CP   R30,R26
	LDI  R30,1
	BREQ __EQB12T
	CLR  R30
__EQB12T:
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

;END OF CODE MARKER
__END_OF_CODE:


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


__GLOBAL_INI_TBL:
	.DW  0x08
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
;Date    : 07-02-2013
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
;int x=0;
;int y=0;
;int z=0;
;int w=0;
;void line(void){
; 0000 0021 void line(void){

	.CSEG
_line:
; .FSTART _line
; 0000 0022             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
	SBIS 0x19,0
	RJMP _0x4
	RCALL SUBOPT_0x0
	BRNE _0x4
	SBIC 0x19,2
	RJMP _0x5
_0x4:
	RJMP _0x3
_0x5:
; 0000 0023                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 0024                 delay_ms(1);
; 0000 0025                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0026                 delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0027             }
; 0000 0028             if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0x3:
	RCALL SUBOPT_0x2
	BRNE _0x17
	SBIS 0x19,1
	RJMP _0x17
	RCALL SUBOPT_0x3
	BREQ _0x18
_0x17:
	RJMP _0x16
_0x18:
; 0000 0029                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 002A                 delay_ms(1);
; 0000 002B                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 002C                 delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 002D             }
; 0000 002E 
; 0000 002F             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0x16:
	RCALL SUBOPT_0x2
	BRNE _0x2A
	RCALL SUBOPT_0x0
	BRNE _0x2A
	RCALL SUBOPT_0x3
	BREQ _0x2B
_0x2A:
	RJMP _0x29
_0x2B:
; 0000 0030                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 0031                 delay_ms(1);
; 0000 0032                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0033                 delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0034                 z=0;
	CLR  R8
	CLR  R9
; 0000 0035             }
; 0000 0036             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0x29:
	SBIS 0x19,0
	RJMP _0x3D
	SBIS 0x19,1
	RJMP _0x3D
	SBIC 0x19,2
	RJMP _0x3E
_0x3D:
	RJMP _0x3C
_0x3E:
; 0000 0037                   PORTD.2 = 0;
	RCALL SUBOPT_0x4
; 0000 0038                   PORTD.3 = 1;
; 0000 0039                   PORTD.7 = 0;
; 0000 003A                   PORTD.6 = 1;
; 0000 003B                   delay_ms(1);
; 0000 003C                   PORTD.2 = 0;
; 0000 003D                   PORTD.3 = 0;
; 0000 003E                   PORTD.7 = 0;
; 0000 003F                   PORTD.6 = 0;
; 0000 0040                   delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0041              }
; 0000 0042 
; 0000 0043               if( PINA.0 == 0 && PINA.2 == 1) {
_0x3C:
	RCALL SUBOPT_0x2
	BRNE _0x50
	SBIC 0x19,2
	RJMP _0x51
_0x50:
	RJMP _0x4F
_0x51:
; 0000 0044 
; 0000 0045                   PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 0046                   PORTD.7 = 0;
; 0000 0047                   PORTD.2 = 1;
; 0000 0048                   PORTD.3 = 0;
; 0000 0049                   delay_ms(1);
; 0000 004A                   PORTD.2 = 0;
; 0000 004B                   PORTD.3 = 0;
; 0000 004C                   delay_ms(3);
; 0000 004D               }
; 0000 004E              if( PINA.0 == 1 && PINA.2 == 0) {
_0x4F:
	SBIS 0x19,0
	RJMP _0x5F
	RCALL SUBOPT_0x3
	BREQ _0x60
_0x5F:
	RJMP _0x5E
_0x60:
; 0000 004F                   PORTD.6 = 0;
	RCALL SUBOPT_0x6
; 0000 0050                   PORTD.7 = 1;
; 0000 0051                   PORTD.2 = 0;
; 0000 0052                   PORTD.3 = 0;
; 0000 0053                   delay_ms(1);
; 0000 0054                   PORTD.6 = 0;
; 0000 0055                   PORTD.7 = 0;
; 0000 0056                   delay_ms(3);
; 0000 0057               }
; 0000 0058               return;
_0x5E:
	RET
; 0000 0059 }
; .FEND
;
;void linen(void){
; 0000 005B void linen(void){
_linen:
; .FSTART _linen
; 0000 005C             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
	SBIS 0x19,0
	RJMP _0x6E
	RCALL SUBOPT_0x0
	BRNE _0x6E
	SBIC 0x19,2
	RJMP _0x6F
_0x6E:
	RJMP _0x6D
_0x6F:
; 0000 005D                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 005E                 delay_ms(1);
; 0000 005F                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0060                 delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0061             }
; 0000 0062             if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0x6D:
	RCALL SUBOPT_0x2
	BRNE _0x81
	SBIS 0x19,1
	RJMP _0x81
	RCALL SUBOPT_0x3
	BREQ _0x82
_0x81:
	RJMP _0x80
_0x82:
; 0000 0063                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 0064                 delay_ms(1);
; 0000 0065                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0066                 delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0067             }
; 0000 0068             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0x80:
	RCALL SUBOPT_0x2
	BRNE _0x94
	RCALL SUBOPT_0x0
	BRNE _0x94
	RCALL SUBOPT_0x3
	BREQ _0x95
_0x94:
	RJMP _0x93
_0x95:
; 0000 0069                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 006A                 delay_ms(1);
; 0000 006B                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 006C                 delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 006D             }
; 0000 006E             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0x93:
	SBIS 0x19,0
	RJMP _0xA7
	SBIS 0x19,1
	RJMP _0xA7
	SBIC 0x19,2
	RJMP _0xA8
_0xA7:
	RJMP _0xA6
_0xA8:
; 0000 006F                   PORTD.2 = 0;
	RCALL SUBOPT_0x4
; 0000 0070                   PORTD.3 = 1;
; 0000 0071                   PORTD.7 = 0;
; 0000 0072                   PORTD.6 = 1;
; 0000 0073                   delay_ms(1);
; 0000 0074                   PORTD.2 = 0;
; 0000 0075                   PORTD.3 = 0;
; 0000 0076                   PORTD.7 = 0;
; 0000 0077                   PORTD.6 = 0;
; 0000 0078                   delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0079              }
; 0000 007A             if( PINA.0 == 0 && PINA.2 == 1) {
_0xA6:
	RCALL SUBOPT_0x2
	BRNE _0xBA
	SBIC 0x19,2
	RJMP _0xBB
_0xBA:
	RJMP _0xB9
_0xBB:
; 0000 007B 
; 0000 007C                   PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 007D                   PORTD.7 = 0;
; 0000 007E                   PORTD.2 = 1;
; 0000 007F                   PORTD.3 = 0;
; 0000 0080                   delay_ms(1);
; 0000 0081                   PORTD.2 = 0;
; 0000 0082                   PORTD.3 = 0;
; 0000 0083                   delay_ms(3);
; 0000 0084               }
; 0000 0085              if( PINA.0 == 1 && PINA.2 == 0) {
_0xB9:
	SBIS 0x19,0
	RJMP _0xC9
	RCALL SUBOPT_0x3
	BREQ _0xCA
_0xC9:
	RJMP _0xC8
_0xCA:
; 0000 0086                   PORTD.6 = 0;
	RCALL SUBOPT_0x6
; 0000 0087                   PORTD.7 = 1;
; 0000 0088                   PORTD.2 = 0;
; 0000 0089                   PORTD.3 = 0;
; 0000 008A                   delay_ms(1);
; 0000 008B                   PORTD.6 = 0;
; 0000 008C                   PORTD.7 = 0;
; 0000 008D                   delay_ms(3);
; 0000 008E               }
; 0000 008F 
; 0000 0090               return;
_0xC8:
	RET
; 0000 0091 }
; .FEND
;
;void linel(void){
; 0000 0093 void linel(void){
_linel:
; .FSTART _linel
; 0000 0094             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
	SBIS 0x19,0
	RJMP _0xD8
	RCALL SUBOPT_0x0
	BRNE _0xD8
	SBIC 0x19,2
	RJMP _0xD9
_0xD8:
	RJMP _0xD7
_0xD9:
; 0000 0095                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 0096                 delay_ms(1);
; 0000 0097                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0098                 delay_ms(6);
	LDI  R26,LOW(6)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0099             }
; 0000 009A 
; 0000 009B             if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0xD7:
	RCALL SUBOPT_0x2
	BRNE _0xEB
	SBIS 0x19,1
	RJMP _0xEB
	RCALL SUBOPT_0x3
	BREQ _0xEC
_0xEB:
	RJMP _0xEA
_0xEC:
; 0000 009C                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 009D                 delay_ms(1);
; 0000 009E                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 009F                 delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00A0             }
; 0000 00A1 
; 0000 00A2             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0xEA:
	RCALL SUBOPT_0x2
	BRNE _0xFE
	RCALL SUBOPT_0x0
	BRNE _0xFE
	RCALL SUBOPT_0x3
	BREQ _0xFF
_0xFE:
	RJMP _0xFD
_0xFF:
; 0000 00A3                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x7
; 0000 00A4                 delay_ms(8);
	LDI  R26,LOW(8)
	RCALL SUBOPT_0x8
; 0000 00A5                 for(w=0;w<22;w++){PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
_0x109:
	RCALL SUBOPT_0x9
	BRGE _0x10A
	SBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	RCALL SUBOPT_0xA
; 0000 00A6                 delay_ms(1);
; 0000 00A7                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 00A8                 delay_ms(4);      }
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x109
_0x10A:
; 0000 00A9                 x=0;
	CLR  R4
	CLR  R5
; 0000 00AA             }
; 0000 00AB             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0xFD:
	SBIS 0x19,0
	RJMP _0x11C
	SBIS 0x19,1
	RJMP _0x11C
	SBIC 0x19,2
	RJMP _0x11D
_0x11C:
	RJMP _0x11B
_0x11D:
; 0000 00AC                   PORTD.2 = 0;
	RCALL SUBOPT_0x4
; 0000 00AD                   PORTD.3 = 1;
; 0000 00AE                   PORTD.7 = 0;
; 0000 00AF                   PORTD.6 = 1;
; 0000 00B0                   delay_ms(1);
; 0000 00B1                   PORTD.2 = 0;
; 0000 00B2                   PORTD.3 = 0;
; 0000 00B3                   PORTD.7 = 0;
; 0000 00B4                   PORTD.6 = 0;
; 0000 00B5                   delay_ms(3);
	LDI  R26,LOW(3)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00B6              }
; 0000 00B7              if( PINA.0 == 0 && PINA.2 == 1) {
_0x11B:
	RCALL SUBOPT_0x2
	BRNE _0x12F
	SBIC 0x19,2
	RJMP _0x130
_0x12F:
	RJMP _0x12E
_0x130:
; 0000 00B8                   PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 00B9                   PORTD.7 = 0;
; 0000 00BA                   PORTD.2 = 1;
; 0000 00BB                   PORTD.3 = 0;
; 0000 00BC                   delay_ms(1);
; 0000 00BD                   PORTD.2 = 0;
; 0000 00BE                   PORTD.3 = 0;
; 0000 00BF                   delay_ms(3);
; 0000 00C0               }
; 0000 00C1              if( PINA.0 == 1 && PINA.2 == 0) {
_0x12E:
	SBIS 0x19,0
	RJMP _0x13E
	RCALL SUBOPT_0x3
	BREQ _0x13F
_0x13E:
	RJMP _0x13D
_0x13F:
; 0000 00C2                   PORTD.6 = 0;
	RCALL SUBOPT_0x6
; 0000 00C3                   PORTD.7 = 1;
; 0000 00C4                   PORTD.2 = 0;
; 0000 00C5                   PORTD.3 = 0;
; 0000 00C6                   delay_ms(1);
; 0000 00C7                   PORTD.6 = 0;
; 0000 00C8                   PORTD.7 = 0;
; 0000 00C9                   delay_ms(3);
; 0000 00CA               }
; 0000 00CB               return;
_0x13D:
	RET
; 0000 00CC }
; .FEND
;void lined(void){
; 0000 00CD void lined(void){
_lined:
; .FSTART _lined
; 0000 00CE             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
	SBIS 0x19,0
	RJMP _0x14D
	RCALL SUBOPT_0x0
	BRNE _0x14D
	SBIC 0x19,2
	RJMP _0x14E
_0x14D:
	RJMP _0x14C
_0x14E:
; 0000 00CF                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 00D0                 delay_ms(1);
; 0000 00D1                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 00D2                 delay_ms(2);
	LDI  R26,LOW(2)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00D3             }
; 0000 00D4 
; 0000 00D5             if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0x14C:
	RCALL SUBOPT_0x2
	BRNE _0x160
	SBIS 0x19,1
	RJMP _0x160
	RCALL SUBOPT_0x3
	BREQ _0x161
_0x160:
	RJMP _0x15F
_0x161:
; 0000 00D6                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 00D7                 delay_ms(1);
; 0000 00D8                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 00D9                 delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00DA             }
; 0000 00DB 
; 0000 00DC             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0x15F:
	RCALL SUBOPT_0x2
	BRNE _0x173
	RCALL SUBOPT_0x0
	BRNE _0x173
	RCALL SUBOPT_0x3
	BREQ _0x174
_0x173:
	RJMP _0x172
_0x174:
; 0000 00DD                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x7
; 0000 00DE                 delay_ms(6);
	LDI  R26,LOW(6)
	RCALL SUBOPT_0x8
; 0000 00DF                 for(w=0;w<24;w++){PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 1;
_0x17E:
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	CP   R10,R30
	CPC  R11,R31
	BRGE _0x17F
	SBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	SBI  0x12,6
; 0000 00E0                 delay_ms(1);
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00E1                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
; 0000 00E2                 delay_ms(4);      }
	LDI  R26,LOW(4)
	LDI  R27,0
	RCALL _delay_ms
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x17E
_0x17F:
; 0000 00E3                 x=0;
	CLR  R4
	CLR  R5
; 0000 00E4                 y=0;
	CLR  R6
	CLR  R7
; 0000 00E5             }
; 0000 00E6             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0x172:
	SBIS 0x19,0
	RJMP _0x191
	SBIS 0x19,1
	RJMP _0x191
	SBIC 0x19,2
	RJMP _0x192
_0x191:
	RJMP _0x190
_0x192:
; 0000 00E7                   PORTD.2 = 0;
	RCALL SUBOPT_0x4
; 0000 00E8                   PORTD.3 = 1;
; 0000 00E9                   PORTD.7 = 0;
; 0000 00EA                   PORTD.6 = 1;
; 0000 00EB                   delay_ms(1);
; 0000 00EC                   PORTD.2 = 0;
; 0000 00ED                   PORTD.3 = 0;
; 0000 00EE                   PORTD.7 = 0;
; 0000 00EF                   PORTD.6 = 0;
; 0000 00F0                   delay_ms(3);
	LDI  R26,LOW(3)
	LDI  R27,0
	RCALL _delay_ms
; 0000 00F1              }
; 0000 00F2              if( PINA.0 == 0 && PINA.2 == 1) {
_0x190:
	RCALL SUBOPT_0x2
	BRNE _0x1A4
	SBIC 0x19,2
	RJMP _0x1A5
_0x1A4:
	RJMP _0x1A3
_0x1A5:
; 0000 00F3                   PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 00F4                   PORTD.7 = 0;
; 0000 00F5                   PORTD.2 = 1;
; 0000 00F6                   PORTD.3 = 0;
; 0000 00F7                   delay_ms(1);
; 0000 00F8                   PORTD.2 = 0;
; 0000 00F9                   PORTD.3 = 0;
; 0000 00FA                   delay_ms(3);
; 0000 00FB               }
; 0000 00FC              if( PINA.0 == 1 && PINA.2 == 0) {
_0x1A3:
	SBIS 0x19,0
	RJMP _0x1B3
	RCALL SUBOPT_0x3
	BREQ _0x1B4
_0x1B3:
	RJMP _0x1B2
_0x1B4:
; 0000 00FD                   PORTD.6 = 0;
	RCALL SUBOPT_0x6
; 0000 00FE                   PORTD.7 = 1;
; 0000 00FF                   PORTD.2 = 0;
; 0000 0100                   PORTD.3 = 0;
; 0000 0101                   delay_ms(1);
; 0000 0102                   PORTD.6 = 0;
; 0000 0103                   PORTD.7 = 0;
; 0000 0104                   delay_ms(3);
; 0000 0105               }
; 0000 0106               return;
_0x1B2:
	RET
; 0000 0107 }
; .FEND
;
;void liner(void){
; 0000 0109 void liner(void){
_liner:
; .FSTART _liner
; 0000 010A             if( PINA.0 == 1 && PINA.1 == 0 && PINA.2 == 1) {
	SBIS 0x19,0
	RJMP _0x1C2
	RCALL SUBOPT_0x0
	BRNE _0x1C2
	SBIC 0x19,2
	RJMP _0x1C3
_0x1C2:
	RJMP _0x1C1
_0x1C3:
; 0000 010B                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 010C                 delay_ms(1);
; 0000 010D                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 010E                 delay_ms(6);
	LDI  R26,LOW(6)
	LDI  R27,0
	RCALL _delay_ms
; 0000 010F             }
; 0000 0110             if( PINA.0 == 0 && PINA.1 == 1 && PINA.2 == 0) {
_0x1C1:
	RCALL SUBOPT_0x2
	BRNE _0x1D5
	SBIS 0x19,1
	RJMP _0x1D5
	RCALL SUBOPT_0x3
	BREQ _0x1D6
_0x1D5:
	RJMP _0x1D4
_0x1D6:
; 0000 0111                 PORTD.2 = 1;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
	RCALL SUBOPT_0x1
; 0000 0112                 delay_ms(1);
; 0000 0113                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 0114                 delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 0115             }
; 0000 0116             if( PINA.0 == 0 && PINA.1 == 0 && PINA.2 == 0) {
_0x1D4:
	RCALL SUBOPT_0x2
	BRNE _0x1E8
	RCALL SUBOPT_0x0
	BRNE _0x1E8
	RCALL SUBOPT_0x3
	BREQ _0x1E9
_0x1E8:
	RJMP _0x1E7
_0x1E9:
; 0000 0117                 PORTD.2 = 0;  PORTD.3 = 1;    PORTD.7 = 0;    PORTD.6 = 1;
	RCALL SUBOPT_0x7
; 0000 0118                 delay_ms(6);
	LDI  R26,LOW(6)
	RCALL SUBOPT_0x8
; 0000 0119                 for(w=0;w<22;w++){PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 1;    PORTD.6 = 0;
_0x1F3:
	RCALL SUBOPT_0x9
	BRGE _0x1F4
	CBI  0x12,2
	CBI  0x12,3
	SBI  0x12,7
	RCALL SUBOPT_0xA
; 0000 011A                 delay_ms(1);
; 0000 011B                 PORTD.2 = 0;  PORTD.3 = 0;    PORTD.7 = 0;    PORTD.6 = 0;
; 0000 011C                 delay_ms(4);}
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	RJMP _0x1F3
_0x1F4:
; 0000 011D                 y=0;
	CLR  R6
	CLR  R7
; 0000 011E             }
; 0000 011F             if( PINA.0 == 1 && PINA.1 == 1 && PINA.2 == 1) {
_0x1E7:
	SBIS 0x19,0
	RJMP _0x206
	SBIS 0x19,1
	RJMP _0x206
	SBIC 0x19,2
	RJMP _0x207
_0x206:
	RJMP _0x205
_0x207:
; 0000 0120                   PORTD.2 = 0;
	RCALL SUBOPT_0x4
; 0000 0121                   PORTD.3 = 1;
; 0000 0122                   PORTD.7 = 0;
; 0000 0123                   PORTD.6 = 1;
; 0000 0124                   delay_ms(1);
; 0000 0125                   PORTD.2 = 0;
; 0000 0126                   PORTD.3 = 0;
; 0000 0127                   PORTD.7 = 0;
; 0000 0128                   PORTD.6 = 0;
; 0000 0129                   delay_ms(5);
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _delay_ms
; 0000 012A              }
; 0000 012B              if( PINA.0 == 0 && PINA.2 == 1) {
_0x205:
	RCALL SUBOPT_0x2
	BRNE _0x219
	SBIC 0x19,2
	RJMP _0x21A
_0x219:
	RJMP _0x218
_0x21A:
; 0000 012C                   PORTD.6 = 0;
	RCALL SUBOPT_0x5
; 0000 012D                   PORTD.7 = 0;
; 0000 012E                   PORTD.2 = 1;
; 0000 012F                   PORTD.3 = 0;
; 0000 0130                   delay_ms(1);
; 0000 0131                   PORTD.2 = 0;
; 0000 0132                   PORTD.3 = 0;
; 0000 0133                   delay_ms(3);
; 0000 0134               }
; 0000 0135              if( PINA.0 == 1 && PINA.2 == 0) {
_0x218:
	SBIS 0x19,0
	RJMP _0x228
	RCALL SUBOPT_0x3
	BREQ _0x229
_0x228:
	RJMP _0x227
_0x229:
; 0000 0136                   PORTD.6 = 0;
	RCALL SUBOPT_0x6
; 0000 0137                   PORTD.7 = 1;
; 0000 0138                   PORTD.2 = 0;
; 0000 0139                   PORTD.3 = 0;
; 0000 013A                   delay_ms(1);
; 0000 013B                   PORTD.6 = 0;
; 0000 013C                   PORTD.7 = 0;
; 0000 013D                   delay_ms(3);
; 0000 013E               }
; 0000 013F               return;
_0x227:
	RET
; 0000 0140 }
; .FEND
;
;
;void main(void)
; 0000 0144 {
_main:
; .FSTART _main
; 0000 0145 // Declare your local variables here
; 0000 0146 
; 0000 0147 // Input/Output Ports initialization
; 0000 0148 // Port A initialization
; 0000 0149 // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 014A DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
	LDI  R30,LOW(0)
	OUT  0x1A,R30
; 0000 014B // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 014C PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);
	OUT  0x1B,R30
; 0000 014D 
; 0000 014E // Port B initialization
; 0000 014F // Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In
; 0000 0150 DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
	OUT  0x17,R30
; 0000 0151 // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T
; 0000 0152 PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);
	OUT  0x18,R30
; 0000 0153 
; 0000 0154 // Port C initialization
; 0000 0155 // Function: Bit7=In Bit6=In Bit5=In Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 0156 DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
	LDI  R30,LOW(31)
	OUT  0x14,R30
; 0000 0157 // State: Bit7=T Bit6=T Bit5=T Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 0158 PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0000 0159 
; 0000 015A // Port D initialization
; 0000 015B // Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out
; 0000 015C DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
	LDI  R30,LOW(255)
	OUT  0x11,R30
; 0000 015D // State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0
; 0000 015E PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0000 015F 
; 0000 0160 // Timer/Counter 0 initialization
; 0000 0161 // Clock source: System Clock
; 0000 0162 // Clock value: Timer 0 Stopped
; 0000 0163 // Mode: Normal top=0xFF
; 0000 0164 // OC0 output: Disconnected
; 0000 0165 TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
	OUT  0x33,R30
; 0000 0166 TCNT0=0x00;
	OUT  0x32,R30
; 0000 0167 OCR0=0x00;
	OUT  0x3C,R30
; 0000 0168 
; 0000 0169 // Timer/Counter 1 initialization
; 0000 016A // Clock source: System Clock
; 0000 016B // Clock value: Timer1 Stopped
; 0000 016C // Mode: Normal top=0xFFFF
; 0000 016D // OC1A output: Disconnected
; 0000 016E // OC1B output: Disconnected
; 0000 016F // Noise Canceler: Off
; 0000 0170 // Input Capture on Falling Edge
; 0000 0171 // Timer1 Overflow Interrupt: Off
; 0000 0172 // Input Capture Interrupt: Off
; 0000 0173 // Compare A Match Interrupt: Off
; 0000 0174 // Compare B Match Interrupt: Off
; 0000 0175 TCCR1A=(0<<COM1A1) | (0<<COM1A0) | (0<<COM1B1) | (0<<COM1B0) | (0<<WGM11) | (0<<WGM10);
	OUT  0x2F,R30
; 0000 0176 TCCR1B=(0<<ICNC1) | (0<<ICES1) | (0<<WGM13) | (0<<WGM12) | (0<<CS12) | (0<<CS11) | (0<<CS10);
	OUT  0x2E,R30
; 0000 0177 TCNT1H=0x00;
	OUT  0x2D,R30
; 0000 0178 TCNT1L=0x00;
	OUT  0x2C,R30
; 0000 0179 ICR1H=0x00;
	OUT  0x27,R30
; 0000 017A ICR1L=0x00;
	OUT  0x26,R30
; 0000 017B OCR1AH=0x00;
	OUT  0x2B,R30
; 0000 017C OCR1AL=0x00;
	OUT  0x2A,R30
; 0000 017D OCR1BH=0x00;
	OUT  0x29,R30
; 0000 017E OCR1BL=0x00;
	OUT  0x28,R30
; 0000 017F 
; 0000 0180 // Timer/Counter 2 initialization
; 0000 0181 // Clock source: System Clock
; 0000 0182 // Clock value: Timer2 Stopped
; 0000 0183 // Mode: Normal top=0xFF
; 0000 0184 // OC2 output: Disconnected
; 0000 0185 ASSR=0<<AS2;
	OUT  0x22,R30
; 0000 0186 TCCR2=(0<<PWM2) | (0<<COM21) | (0<<COM20) | (0<<CTC2) | (0<<CS22) | (0<<CS21) | (0<<CS20);
	OUT  0x25,R30
; 0000 0187 TCNT2=0x00;
	OUT  0x24,R30
; 0000 0188 OCR2=0x00;
	OUT  0x23,R30
; 0000 0189 
; 0000 018A // Timer(s)/Counter(s) Interrupt(s) initialization
; 0000 018B TIMSK=(0<<OCIE2) | (0<<TOIE2) | (0<<TICIE1) | (0<<OCIE1A) | (0<<OCIE1B) | (0<<TOIE1) | (0<<OCIE0) | (0<<TOIE0);
	OUT  0x39,R30
; 0000 018C 
; 0000 018D // External Interrupt(s) initialization
; 0000 018E // INT0: Off
; 0000 018F // INT1: Off
; 0000 0190 // INT2: Off
; 0000 0191 MCUCR=(0<<ISC11) | (0<<ISC10) | (0<<ISC01) | (0<<ISC00);
	OUT  0x35,R30
; 0000 0192 MCUCSR=(0<<ISC2);
	OUT  0x34,R30
; 0000 0193 
; 0000 0194 // USART initialization
; 0000 0195 // USART disabled
; 0000 0196 UCSRB=(0<<RXCIE) | (0<<TXCIE) | (0<<UDRIE) | (0<<RXEN) | (0<<TXEN) | (0<<UCSZ2) | (0<<RXB8) | (0<<TXB8);
	OUT  0xA,R30
; 0000 0197 
; 0000 0198 // Analog Comparator initialization
; 0000 0199 // Analog Comparator: Off
; 0000 019A ACSR=(1<<ACD) | (0<<ACBG) | (0<<ACO) | (0<<ACI) | (0<<ACIE) | (0<<ACIC) | (0<<ACIS1) | (0<<ACIS0);
	LDI  R30,LOW(128)
	OUT  0x8,R30
; 0000 019B SFIOR=(0<<ACME);
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0000 019C 
; 0000 019D // ADC initialization
; 0000 019E // ADC disabled
; 0000 019F ADCSRA=(0<<ADEN) | (0<<ADSC) | (0<<ADATE) | (0<<ADIF) | (0<<ADIE) | (0<<ADPS2) | (0<<ADPS1) | (0<<ADPS0);
	OUT  0x6,R30
; 0000 01A0 
; 0000 01A1 // SPI initialization
; 0000 01A2 // SPI disabled
; 0000 01A3 SPCR=(0<<SPIE) | (0<<SPE) | (0<<DORD) | (0<<MSTR) | (0<<CPOL) | (0<<CPHA) | (0<<SPR1) | (0<<SPR0);
	OUT  0xD,R30
; 0000 01A4 
; 0000 01A5 // TWI initialization
; 0000 01A6 // TWI disabled
; 0000 01A7 TWCR=(0<<TWEA) | (0<<TWSTA) | (0<<TWSTO) | (0<<TWEN) | (0<<TWIE);
	OUT  0x36,R30
; 0000 01A8 PORTD.4 = 1;
	SBI  0x12,4
; 0000 01A9 PORTD.5 = 1;
	SBI  0x12,5
; 0000 01AA 
; 0000 01AB delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01AC while (1)
_0x23A:
; 0000 01AD       {
; 0000 01AE       if(z==0){
	MOV  R0,R8
	OR   R0,R9
	BRNE _0x23D
; 0000 01AF       if( PINA.3 == 1){
	SBIS 0x19,3
	RJMP _0x23E
; 0000 01B0 
; 0000 01B1             x=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
; 0000 01B2             z=1;
	RCALL SUBOPT_0xB
; 0000 01B3             PORTD.2 = 0;
; 0000 01B4                   PORTD.3 = 1;
; 0000 01B5                   PORTD.7 = 0;
; 0000 01B6                   PORTD.6 = 1;
; 0000 01B7                   delay_ms(4);
	LDI  R26,LOW(4)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01B8       }
; 0000 01B9 
; 0000 01BA       if( PINA.5 == 1){
_0x23E:
	SBIS 0x19,5
	RJMP _0x247
; 0000 01BB             y=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R6,R30
; 0000 01BC             z=1;
	RCALL SUBOPT_0xB
; 0000 01BD 
; 0000 01BE          PORTD.2 = 0;
; 0000 01BF                   PORTD.3 = 1;
; 0000 01C0                   PORTD.7 = 0;
; 0000 01C1                   PORTD.6 = 1;
; 0000 01C2                   delay_ms(4);
	LDI  R26,LOW(4)
	LDI  R27,0
	RCALL _delay_ms
; 0000 01C3       }
; 0000 01C4 
; 0000 01C5       if(PINA.3 == 0 && PINA.5 == 0){
_0x247:
	LDI  R26,0
	SBIC 0x19,3
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BRNE _0x251
	LDI  R26,0
	SBIC 0x19,5
	LDI  R26,1
	CPI  R26,LOW(0x0)
	BREQ _0x252
_0x251:
	RJMP _0x250
_0x252:
; 0000 01C6             linen();
	RCALL _linen
; 0000 01C7       }
; 0000 01C8 
; 0000 01C9             }
_0x250:
; 0000 01CA       if( z == 1 && x==1 && PINA.5==1) y=1;
_0x23D:
	RCALL SUBOPT_0xC
	BRNE _0x254
	RCALL SUBOPT_0xD
	BRNE _0x254
	SBIC 0x19,5
	RJMP _0x255
_0x254:
	RJMP _0x253
_0x255:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R6,R30
; 0000 01CB       if( z == 1 && y==1 && PINA.3==1) x=1;
_0x253:
	RCALL SUBOPT_0xC
	BRNE _0x257
	RCALL SUBOPT_0xE
	BRNE _0x257
	SBIC 0x19,3
	RJMP _0x258
_0x257:
	RJMP _0x256
_0x258:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R4,R30
; 0000 01CC       if(z==1){
_0x256:
	RCALL SUBOPT_0xC
	BRNE _0x259
; 0000 01CD             if(x==1 && y==1){
	RCALL SUBOPT_0xD
	BRNE _0x25B
	RCALL SUBOPT_0xE
	BREQ _0x25C
_0x25B:
	RJMP _0x25A
_0x25C:
; 0000 01CE                 lined();
	RCALL _lined
; 0000 01CF                 continue;
	RJMP _0x23A
; 0000 01D0              }
; 0000 01D1 
; 0000 01D2             if(x==0 && y==0) line();
_0x25A:
	CLR  R0
	CP   R0,R4
	CPC  R0,R5
	BRNE _0x25E
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BREQ _0x25F
_0x25E:
	RJMP _0x25D
_0x25F:
	RCALL _line
; 0000 01D3             if(x==1) linel();
_0x25D:
	RCALL SUBOPT_0xD
	BRNE _0x260
	RCALL _linel
; 0000 01D4             if(y==1) liner();
_0x260:
	RCALL SUBOPT_0xE
	BRNE _0x261
	RCALL _liner
; 0000 01D5             else line();
	RJMP _0x262
_0x261:
	RCALL _line
; 0000 01D6             }
_0x262:
; 0000 01D7 
; 0000 01D8 
; 0000 01D9 
; 0000 01DA      }
_0x259:
	RJMP _0x23A
; 0000 01DB 
; 0000 01DC }
_0x263:
	RJMP _0x263
; .FEND

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x0:
	LDI  R26,0
	SBIC 0x19,1
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:108 WORDS
SUBOPT_0x1:
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

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:40 WORDS
SUBOPT_0x2:
	LDI  R26,0
	SBIC 0x19,0
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:40 WORDS
SUBOPT_0x3:
	LDI  R26,0
	SBIC 0x19,2
	LDI  R26,1
	CPI  R26,LOW(0x0)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:38 WORDS
SUBOPT_0x4:
	CBI  0x12,2
	SBI  0x12,3
	CBI  0x12,7
	SBI  0x12,6
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x5:
	CBI  0x12,6
	CBI  0x12,7
	SBI  0x12,2
	CBI  0x12,3
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0x6:
	CBI  0x12,6
	SBI  0x12,7
	CBI  0x12,2
	CBI  0x12,3
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,6
	CBI  0x12,7
	LDI  R26,LOW(3)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x7:
	CBI  0x12,2
	SBI  0x12,3
	CBI  0x12,7
	SBI  0x12,6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDI  R27,0
	RCALL _delay_ms
	CLR  R10
	CLR  R11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(22)
	LDI  R31,HIGH(22)
	CP   R10,R30
	CPC  R11,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xA:
	CBI  0x12,6
	LDI  R26,LOW(1)
	LDI  R27,0
	RCALL _delay_ms
	CBI  0x12,2
	CBI  0x12,3
	CBI  0x12,7
	CBI  0x12,6
	LDI  R26,LOW(4)
	LDI  R27,0
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	MOVW R8,R30
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R8
	CPC  R31,R9
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R4
	CPC  R31,R5
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R6
	CPC  R31,R7
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

;END OF CODE MARKER
__END_OF_CODE:

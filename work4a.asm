
;CodeVisionAVR C Compiler V1.25.9 Evaluation
;(C) Copyright 1998-2008 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 7.372800 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int
;(s)scanf features      : int, width
;External SRAM size     : 0
;Data Stack size        : 256 byte(s)
;Heap size              : 0 byte(s)
;Promote char to int    : No
;char is unsigned       : Yes
;8 bit enums            : Yes
;Word align FLASH struct: No
;Enhanced core instructions    : On
;Smart register allocation : On
;Automatic register allocation : On

	#pragma AVRPART ADMIN PART_NAME ATmega8
	#pragma AVRPART MEMORY PROG_FLASH 8192
	#pragma AVRPART MEMORY EEPROM 512
	#pragma AVRPART MEMORY INT_SRAM SIZE 1024
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x60

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
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+@1
	ANDI R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ANDI R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+@1
	ORI  R30,LOW(@2)
	STS  @0+@1,R30
	LDS  R30,@0+@1+1
	ORI  R30,HIGH(@2)
	STS  @0+@1+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
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

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
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

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	LDI  R22,BYTE3(2*@0+@1)
	LDI  R23,BYTE4(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+@3)
	LDI  R@1,HIGH(@2*2+@3)
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

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+@2
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+@3
	LDS  R@1,@2+@3+1
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
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+@1,R0
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
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
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	RCALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	RCALL __EEPROMRDW
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
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
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
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

	.CSEG
	.ORG 0

	.INCLUDE "work4a.vec"
	.INCLUDE "work4a.inc"

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
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
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
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x160)
	LDI  R29,HIGH(0x160)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x160
;       1 /*****************************************************
;       2 This program was produced by the
;       3 CodeWizardAVR V1.24.6 Evaluation
;       4 Automatic Program Generator
;       5 © Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
;       6 http://www.hpinfotech.com
;       7 e-mail:office@hpinfotech.com
;       8
;       9 Project :
;      10 Version :
;      11 Date    : 30.10.2005
;      12 Author  : Freeware, for evaluation and non-commercial use only
;      13 Company :
;      14 Comments:
;      15
;      16
;      17 Chip type           : ATmega8
;      18 Program type        : Application
;      19 Clock frequency     : 7,3728 MHz
;      20 Memory model        : Small
;      21 External SRAM size  : 0
;      22 Data Stack size     : 256
;      23
;      24 02.09.06 - Double LED is connected to PB0, PD7, switch is connected to PB1
;      25 19.10.06 - Low output at PD2 as DTR output signal
;      26 20.10.06 - Monitoring PD3 and activate device on High input
;      27 04.04.07 - 4 channel mode (adc0 as A, adc1 as B ... adc3 as D) swtches consequently
;      28 27.03.08 - XTAL 7.3728MHz added  (CKOPT=1;SUT=10;SKSEL=1111)
;      29 14.10.08 - button() function for clear button press detection
;      30
;      31 *****************************************************/
;      32
;      33 #include <mega8.h>
;      34 	#ifndef __SLEEP_DEFINED__
	#ifndef __SLEEP_DEFINED__
;      35 	#define __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
;      36 	.EQU __se_bit=0x80
	.EQU __se_bit=0x80
;      37 	.EQU __sm_mask=0x70
	.EQU __sm_mask=0x70
;      38 	.EQU __sm_powerdown=0x20
	.EQU __sm_powerdown=0x20
;      39 	.EQU __sm_powersave=0x30
	.EQU __sm_powersave=0x30
;      40 	.EQU __sm_standby=0x60
	.EQU __sm_standby=0x60
;      41 	.EQU __sm_ext_standby=0x70
	.EQU __sm_ext_standby=0x70
;      42 	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_adc_noise_red=0x10
;      43 	.SET power_ctrl_reg=mcucr
	.SET power_ctrl_reg=mcucr
;      44 	#endif
	#endif
;      45
;      46 // Standard Input/Output functions
;      47 #include <stdio.h>
;      48 #include <delay.h>
;      49
;      50 bit sample=0, firsttime=1;
;      51 char channel[]="ABCD";
_channel:
	.BYTE 0x5
;      52
;      53
;      54 void button(void)
;      55 {

	.CSEG
_button:
;      56 unsigned int b=0, i=0;
;      57
;      58 for (i=0; i<100; i++){
	RCALL __SAVELOCR4
;	b -> R16,R17
;	i -> R18,R19
	LDI  R16,0
	LDI  R17,0
	LDI  R18,0
	LDI  R19,0
	__GETWRN 18,19,0
_0x4:
	__CPWRN 18,19,100
	BRSH _0x5
;      59 b += !PINB.1;
	LDI  R30,0
	SBIS 0x16,1
	LDI  R30,1
	LDI  R31,0
	__ADDWRR 16,17,30,31
;      60 delay_ms(1);
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RCALL SUBOPT_0x0
	RCALL _delay_ms
;      61 }
	__ADDWRN 18,19,1
	RJMP _0x4
_0x5:
;      62 b /= 100;
	MOVW R26,R16
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL __DIVW21U
	MOVW R16,R30
;      63 if (b == 1){
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R16
	CPC  R31,R17
	BRNE _0x6
;      64             sample ^= 1;
	LDI  R30,0
	SBRC R2,0
	LDI  R30,1
	LDI  R26,LOW(1)
	EOR  R30,R26
	RCALL __BSTB1
	BLD  R2,0
;      65             PORTB.0 ^= 1;
	LDI  R30,0
	SBIC 0x18,0
	LDI  R30,1
	EOR  R30,R26
	BRNE _0x7
	CBI  0x18,0
	RJMP _0x8
_0x7:
	SBI  0x18,0
_0x8:
;      66             PORTD.7 ^= 1;
	LDI  R30,0
	SBIC 0x12,7
	LDI  R30,1
	LDI  R26,LOW(1)
	EOR  R30,R26
	BRNE _0x9
	CBI  0x12,7
	RJMP _0xA
_0x9:
	SBI  0x12,7
_0xA:
;      67             }
;      68 }
_0x6:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
;      69
;      70 unsigned int read_adc(void)
;      71 {
_read_adc:
;      72 unsigned int counter0 = 6, counter1 = 16; //counter0 = 6
;      73 unsigned long int result0=0, result1=0;
;      74
;      75 // set freerunning
;      76 ADCSRA |= 0x20;
	SBIW R28,8
	LDI  R24,8
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0xB*2)
	LDI  R31,HIGH(_0xB*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR4
;	counter0 -> R16,R17
;	counter1 -> R18,R19
;	result0 -> Y+8
;	result1 -> Y+4
	LDI  R16,6
	LDI  R17,0
	LDI  R18,16
	LDI  R19,0
	SBI  0x6,5
;      77
;      78 // Start the AD conversion
;      79 ADCSRA |= 0x40;
	SBI  0x6,6
;      80
;      81 while (counter0){
_0xC:
	MOV  R0,R16
	OR   R0,R17
	BREQ _0xE
;      82
;      83 while (counter1){
_0xF:
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x11
;      84
;      85 // Wait for the AD conversion to complete
;      86 while ((ADCSRA & 0x10)==0);
_0x12:
	SBIS 0x6,4
	RJMP _0x12
;      87 ADCSRA |= 0x10;
	SBI  0x6,4
;      88 result1 += ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	RCALL SUBOPT_0x1
	CLR  R22
	CLR  R23
	RCALL __ADDD12
	RCALL SUBOPT_0x2
;      89 counter1--;
	__SUBWRN 18,19,1
;      90 }
	RJMP _0xF
_0x11:
;      91 result1 >>= 2;
	RCALL SUBOPT_0x1
	LDI  R30,LOW(2)
	RCALL __LSRD12
	RCALL SUBOPT_0x2
;      92
;      93 result0 += result1;
	__GETD1S 4
	RCALL SUBOPT_0x3
	RCALL __ADDD12
	RCALL SUBOPT_0x4
;      94 result1 = 0;
	__CLRD1S 4
;      95 counter1 = 16;
	__GETWRN 18,19,16
;      96 counter0--;
	__SUBWRN 16,17,1
;      97 }
	RJMP _0xC
_0xE:
;      98 ADCSRA ^=0x20;
	IN   R30,0x6
	LDI  R26,LOW(32)
	EOR  R30,R26
	OUT  0x6,R30
;      99 result0 /= 6;
	RCALL SUBOPT_0x3
	__GETD1N 0x6
	RCALL __DIVD21U
	RCALL SUBOPT_0x4
;     100 return result0;
	__GETD1S 8
	RCALL __LOADLOCR4
	ADIW R28,12
	RET
;     101 }
;     102
;     103 // Declare your global variables here
;     104
;     105 void init_devices(void){
_init_devices:
;     106 // all unused legs - pull-up inputs
;     107
;     108 PORTB=0b11111110; //pb0 - LED (output, low), pb1 - Switch (input, pull-up)
	LDI  R30,LOW(254)
	OUT  0x18,R30
;     109 DDRB= 0b00000001;
	LDI  R30,LOW(1)
	OUT  0x17,R30
;     110
;     111 PORTC=0b11110000;
	LDI  R30,LOW(240)
	OUT  0x15,R30
;     112 DDRC= 0b00000000;
	LDI  R30,LOW(0)
	OUT  0x14,R30
;     113
;     114 PORTD=0b01111011; //pd7 - LED (output, low), pd3 - input (input, pull-up), pd2 - DSR (output, low).
	LDI  R30,LOW(123)
	OUT  0x12,R30
;     115 DDRD= 0b10000100;
	LDI  R30,LOW(132)
	OUT  0x11,R30
;     116
;     117
;     118 // Timer/Counter 0 initialization
;     119 // Clock source: System Clock
;     120 // Prescale: 1024 kHz
;     121 //TCCR0 = 0x00; //stop
;     122 //TCNT0 = 0xB8;//B8; //set count
;     123 //TCCR0 = 0x02; //start timer
;     124
;     125
;     126 // External Interrupt(s) initialization
;     127 // INT0: Off
;     128 // INT1: Off
;     129 MCUCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x35,R30
;     130
;     131 // Timer(s)/Counter(s) Interrupt(s) initialization
;     132 //TIMSK=0x01;
;     133
;     134 // USART initialization
;     135 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     136 // USART Receiver: Off
;     137 // USART Transmitter: On
;     138 // USART Mode: Asynchronous
;     139 // USART Baud rate: 19200
;     140 //UCSRA=0x00;
;     141 //UCSRB=0x08;
;     142 //UCSRC=0x86;
;     143 //UBRRH=0x00;
;     144 //UBRRL=0x0C;
;     145
;     146 //same for external 7.3728 XTAL, 38400 bod
;     147 UCSRA=0x00;
	OUT  0xB,R30
;     148 UCSRB=0x08;
	LDI  R30,LOW(8)
	OUT  0xA,R30
;     149 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     150 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     151 //UBRRL=0x17;
;     152 UBRRL=0x0B;
	LDI  R30,LOW(11)
	OUT  0x9,R30
;     153
;     154
;     155 // Analog Comparator initialization
;     156 // Analog Comparator: Off
;     157 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     158 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     159 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;     160
;     161 // ADC initialization
;     162 // ADC Clock frequency: 125,000 kHz
;     163 // ADC Voltage Reference: internal
;     164 ADMUX=0xC0; //internal reference; ADC1
	LDI  R30,LOW(192)
	OUT  0x7,R30
;     165 //ADMUX=0xCE; //1.23v bg, internal ref.
;     166 //ADMUX=0x40; //AVCC
;     167 //ADCSRA=0x8D; // INT
;     168
;     169 //enable ADC with 125,000 kHz (4mhz/32)
;     170 //ADCSRA=0x85;//without int
;     171 //ADCSRA=0x8D;//with int
;     172 //enable ADC with 115,000 kHz (7.3728mhz/64)
;     173 ADCSRA=0x86;//without int
	LDI  R30,LOW(134)
	OUT  0x6,R30
;     174 //ADCSRA=0x8E;//with int
;     175
;     176
;     177 // Global enable interrupts
;     178 #asm("sei")
	sei
;     179 }
	RET
;     180
;     181
;     182 void main(void){
_main:
;     183
;     184 init_devices();
	RCALL _init_devices
;     185
;     186 while (1)
_0x15:
;     187 {
;     188
;     189   if (!PIND.3){
	SBIC 0x10,3
	RJMP _0x18
;     190
;     191           if (firsttime){
	SBRS R2,1
	RJMP _0x19
;     192           PORTB.0 = 1;
	SBI  0x18,0
;     193           PORTD.7 = 0;
	CBI  0x12,7
;     194           PORTD.2 = 0;
	CBI  0x12,2
;     195           firsttime=0;
	CLT
	BLD  R2,1
;     196           }
;     197
;     198           if (sample){
_0x19:
	SBRS R2,0
	RJMP _0x20
;     199
;     200                 printf("%c%i\r\n",channel[ADMUX&7],read_adc());
	__POINTW1FN _0,5
	RCALL SUBOPT_0x0
	IN   R30,0x7
	ANDI R30,LOW(0x7)
	LDI  R31,0
	SUBI R30,LOW(-_channel)
	SBCI R31,HIGH(-_channel)
	LD   R30,Z
	CLR  R31
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	RCALL _read_adc
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,8
	RCALL _printf
	ADIW R28,10
;     201
;     202                 ADMUX++;
	IN   R30,0x7
	SUBI R30,-LOW(1)
	OUT  0x7,R30
;     203                 if (ADMUX == 0xC4) ADMUX = 0xC0;
	IN   R30,0x7
	CPI  R30,LOW(0xC4)
	BRNE _0x21
	LDI  R30,LOW(192)
	OUT  0x7,R30
;     204                 // Delay needed for the stabilization of the ADC input voltage
;     205                 delay_us(10);
_0x21:
	__DELAY_USB 25
;     206           }
;     207
;     208           if (!PINB.1) {
_0x20:
	SBIC 0x16,1
	RJMP _0x22
;     209                 button();
	RCALL _button
;     210                 while (!PINB.1);
_0x23:
	SBIS 0x16,1
	RJMP _0x23
;     211           }
;     212   }else{
_0x22:
	RJMP _0x26
_0x18:
;     213   sample = 0;
	CLT
	BLD  R2,0
;     214   PORTB.0 = 0;
	CBI  0x18,0
;     215   PORTD.7 = 0;
	CBI  0x12,7
;     216   PORTD.2 = 1;
	SBI  0x12,2
;     217   firsttime=1;
	SET
	BLD  R2,1
;     218   }
_0x26:
;     219
;     220 }
	RJMP _0x15
;     221 }
_0x2D:
	RJMP _0x2D
;     222
;     223
;     224
;     225
;     226
;     227
;     228
;     229
;     230

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
_getchar:
     sbis usr,rxc
     rjmp _getchar
     in   r30,udr
	RET
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET
__put_G2:
	RCALL __SAVELOCR2
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	RCALL __GETW1P
	SBIW R30,0
	BREQ _0x3B
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x3D
	__CPWRN 16,17,2
	BRLO _0x3E
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	ST   X+,R30
	ST   X,R31
_0x3D:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+6
	STD  Z+0,R26
_0x3E:
	RJMP _0x3F
_0x3B:
	LDD  R30,Y+6
	ST   -Y,R30
	RCALL _putchar
_0x3F:
	RCALL __LOADLOCR2
	ADIW R28,7
	RET
__print_G2:
	SBIW R28,4
	RCALL __SAVELOCR6
	LDI  R17,0
_0x40:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	ADIW R30,1
	STD  Y+16,R30
	STD  Y+16+1,R31
	RCALL SUBOPT_0x5
	BRNE PC+2
	RJMP _0x42
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x46
	CPI  R19,37
	BRNE _0x47
	LDI  R17,LOW(1)
	RJMP _0x48
_0x47:
	RCALL SUBOPT_0x6
_0x48:
	RJMP _0x45
_0x46:
	CPI  R30,LOW(0x1)
	BRNE _0x49
	CPI  R19,37
	BRNE _0x4A
	RCALL SUBOPT_0x6
	RJMP _0xCD
_0x4A:
	LDI  R17,LOW(2)
	LDI  R18,LOW(0)
	LDI  R16,LOW(0)
	CPI  R19,43
	BRNE _0x4B
	LDI  R18,LOW(43)
	RJMP _0x45
_0x4B:
	CPI  R19,32
	BRNE _0x4C
	LDI  R18,LOW(32)
	RJMP _0x45
_0x4C:
	RJMP _0x4D
_0x49:
	CPI  R30,LOW(0x2)
	BRNE _0x4E
_0x4D:
	CPI  R19,48
	BRNE _0x4F
	ORI  R16,LOW(16)
	LDI  R17,LOW(5)
	RJMP _0x45
_0x4F:
	RJMP _0x50
_0x4E:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x45
_0x50:
	MOV  R30,R19
	CPI  R30,LOW(0x63)
	BRNE _0x55
	RCALL SUBOPT_0x7
	LD   R30,X
	ST   -Y,R30
	RCALL SUBOPT_0x8
	RJMP _0x56
_0x55:
	CPI  R30,LOW(0x73)
	BRNE _0x58
	RCALL SUBOPT_0x7
	RCALL __GETW1P
	RCALL SUBOPT_0x9
_0x59:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
	MOV  R19,R30
	CPI  R30,0
	BREQ _0x5B
	RCALL SUBOPT_0x6
	RJMP _0x59
_0x5B:
	RJMP _0x56
_0x58:
	CPI  R30,LOW(0x70)
	BRNE _0x5D
	RCALL SUBOPT_0x7
	RCALL __GETW1P
	RCALL SUBOPT_0x9
_0x5E:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	RCALL SUBOPT_0x9
	RCALL SUBOPT_0x5
	BREQ _0x60
	RCALL SUBOPT_0x6
	RJMP _0x5E
_0x60:
	RJMP _0x56
_0x5D:
	CPI  R30,LOW(0x64)
	BREQ _0x63
	CPI  R30,LOW(0x69)
	BRNE _0x64
_0x63:
	ORI  R16,LOW(1)
	RJMP _0x65
_0x64:
	CPI  R30,LOW(0x75)
	BRNE _0x66
_0x65:
	LDI  R30,LOW(_tbl10_G2*2)
	LDI  R31,HIGH(_tbl10_G2*2)
	RJMP _0xCE
_0x66:
	CPI  R30,LOW(0x58)
	BRNE _0x69
	ORI  R16,LOW(2)
	RJMP _0x6A
_0x69:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x7C
_0x6A:
	LDI  R30,LOW(_tbl16_G2*2)
	LDI  R31,HIGH(_tbl16_G2*2)
_0xCE:
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBRS R16,0
	RJMP _0x6C
	RCALL SUBOPT_0x7
	LD   R20,X+
	LD   R21,X
	SUBI R20,0
	SBCI R21,0
	BRGE _0x6D
	MOVW R30,R20
	RCALL __ANEGW1
	MOVW R20,R30
	LDI  R18,LOW(45)
_0x6D:
	CPI  R18,0
	BREQ _0x6E
	ST   -Y,R18
	RCALL SUBOPT_0x8
_0x6E:
	RJMP _0x6F
_0x6C:
	RCALL SUBOPT_0x7
	LD   R20,X+
	LD   R21,X
_0x6F:
_0x71:
	LDI  R19,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	RCALL SUBOPT_0x9
	SBIW R30,2
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
_0x73:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	CP   R20,R30
	CPC  R21,R31
	BRLO _0x75
	SUBI R19,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	__SUBWRR 20,21,26,27
	RJMP _0x73
_0x75:
	SBRC R16,4
	RJMP _0x77
	CPI  R19,49
	BRSH _0x77
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x76
_0x77:
	ORI  R16,LOW(16)
	CPI  R19,58
	BRLO _0x79
	SBRS R16,1
	RJMP _0x7A
	SUBI R19,-LOW(7)
	RJMP _0x7B
_0x7A:
	SUBI R19,-LOW(39)
_0x7B:
_0x79:
	RCALL SUBOPT_0x6
_0x76:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRSH _0x71
_0x7C:
_0x56:
_0xCD:
	LDI  R17,LOW(0)
_0x45:
	RJMP _0x40
_0x42:
	RCALL __LOADLOCR6
	ADIW R28,18
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	MOVW R16,R26
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	RCALL __GETW1P
	RCALL SUBOPT_0x0
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	RCALL SUBOPT_0x0
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RCALL SUBOPT_0x0
	RCALL __print_G2
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET

	.DSEG
_p_S47:
	.BYTE 0x2

	.CSEG

;OPTIMIZER ADDED SUBROUTINE, CALLED 19 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x0:
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	__GETD2S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4:
	__PUTD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	SBIW R30,1
	LPM  R30,Z
	MOV  R19,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x6:
	ST   -Y,R19
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	RCALL SUBOPT_0x0
	MOVW R30,R28
	ADIW R30,13
	RCALL SUBOPT_0x0
	RJMP __put_G2

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x7:
	LDD  R26,Y+14
	LDD  R27,Y+14+1
	SBIW R26,4
	STD  Y+14,R26
	STD  Y+14+1,R27
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x8:
	LDD  R30,Y+13
	LDD  R31,Y+13+1
	RCALL SUBOPT_0x0
	MOVW R30,R28
	ADIW R30,13
	RCALL SUBOPT_0x0
	RJMP __put_G2

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x733
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__LSRD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSRD12R
__LSRD12L:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRD12L
__LSRD12R:
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

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R20
	CLR  R21
	LDI  R19,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R20
	ROL  R21
	SUB  R0,R30
	SBC  R1,R31
	SBC  R20,R22
	SBC  R21,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R20,R22
	ADC  R21,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R19
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOVW R24,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__BSTB1:
	CLT
	TST  R30
	BREQ PC+2
	SET
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

;END OF CODE MARKER
__END_OF_CODE:

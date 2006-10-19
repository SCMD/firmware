;CodeVisionAVR C Compiler V1.24.6 Evaluation
;(C) Copyright 1998-2005 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;e-mail:office@hpinfotech.com

;Chip type              : ATmega8
;Program type           : Application
;Clock frequency        : 4,000000 MHz
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
;Automatic register allocation : On

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

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

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

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
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

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
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
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
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
;      19 Clock frequency     : 4,000000 MHz
;      20 Memory model        : Small
;      21 External SRAM size  : 0
;      22 Data Stack size     : 256
;      23 *****************************************************/
;      24
;      25 #include <mega8.h>
;      26
;      27 // Standard Input/Output functions
;      28 #include <stdio.h>
;      29 #include <delay.h>
;      30
;      31 bit sample=0;
;      32
;      33
;      34 unsigned int read_adc(void)
;      35 {

	.CSEG
_read_adc:
;      36 unsigned int counter0 = 27, counter1 = 16;
;      37 unsigned long int result0=0, result1=0;
;      38
;      39 ADCSRA |= 0x20;
	SBIW R28,8
	LDI  R24,8
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x3*2)
	LDI  R31,HIGH(_0x3*2)
	RCALL __INITLOCB
	RCALL __SAVELOCR4
;	counter0 -> R16,R17
;	counter1 -> R18,R19
;	result0 -> Y+8
;	result1 -> Y+4
	LDI  R16,27
	LDI  R17,0
	LDI  R18,16
	LDI  R19,0
	SBI  0x6,5
;      40 ADCSRA |= 0x40;
	SBI  0x6,6
;      41
;      42 while (counter0){
_0x4:
	MOV  R0,R16
	OR   R0,R17
	BREQ _0x6
;      43
;      44 while (counter1){
_0x7:
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x9
;      45 while ((ADCSRA & 0x10)==0);
_0xA:
	SBIS 0x6,4
	RJMP _0xA
;      46 ADCSRA |= 0x10;
	SBI  0x6,4
;      47 result1 += ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	__GETD2S 4
	CLR  R22
	CLR  R23
	RCALL __ADDD12
	__PUTD1S 4
;      48 counter1--;
	__SUBWRN 18,19,1
;      49 }
	RJMP _0x7
_0x9:
;      50 result1 >>= 2;
	__GETD2S 4
	LDI  R30,LOW(2)
	RCALL __LSRD12
	__PUTD1S 4
;      51
;      52 result0 += result1;
	__GETD2S 8
	RCALL __ADDD12
	__PUTD1S 8
;      53 result1 = 0;
	__CLRD1S 4
;      54 counter1 = 16;
	__GETWRN 18,19,16
;      55 counter0--;
	__SUBWRN 16,17,1
;      56 }
	RJMP _0x4
_0x6:
;      57 ADCSRA ^=0x20;
	IN   R30,0x6
	LDI  R26,LOW(32)
	EOR  R30,R26
	OUT  0x6,R30
;      58 result0 /= 27;
	__GETD2S 8
	__GETD1N 0x1B
	RCALL __DIVD21U
	__PUTD1S 8
;      59 return result0;
	RCALL __LOADLOCR4
	ADIW R28,12
	RET
;      60 }
;      61
;      62 // Declare your global variables here
;      63
;      64 void init_devices(void){
_init_devices:
;      65 // Declare your local variables here
;      66 PORTB=0x03; //pb0 - LED, pb1 - Switch
	LDI  R30,LOW(3)
	OUT  0x18,R30
;      67 DDRB=0x01;
	LDI  R30,LOW(1)
	OUT  0x17,R30
;      68 PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;      69 DDRC=0x00;
	OUT  0x14,R30
;      70 PORTD=0x80; //pd7 - LED, pd2 - low
	LDI  R30,LOW(128)
	OUT  0x12,R30
;      71 DDRD=0x84;
	LDI  R30,LOW(132)
	OUT  0x11,R30
;      72
;      73 // Timer/Counter 0 initialization
;      74 // Clock source: System Clock
;      75 // Prescale: 1024 kHz
;      76 //TCCR0 = 0x00; //stop
;      77 //TCNT0 = 0xB8;//B8; //set count
;      78 //TCCR0 = 0x02; //start timer
;      79
;      80
;      81 // External Interrupt(s) initialization
;      82 // INT0: Off
;      83 // INT1: Off
;      84 MCUCR=0x00;
	LDI  R30,LOW(0)
	OUT  0x35,R30
;      85
;      86 // Timer(s)/Counter(s) Interrupt(s) initialization
;      87 //TIMSK=0x01;
;      88
;      89 // USART initialization
;      90 // Communication Parameters: 8 Data, 1 Stop, No Parity
;      91 // USART Receiver: Off
;      92 // USART Transmitter: On
;      93 // USART Mode: Asynchronous
;      94 // USART Baud rate: 9600
;      95
;      96 //UCSRA=0x00;
;      97 //UCSRB=0x00;
;      98 //UCSRC=0x86;
;      99 //UBRRL = 0x19; //set baud rate lo
;     100 //UBRRH = 0x00; //set baud rate hi
;     101 //UCSRB = 0x08;
;     102
;     103 // USART initialization
;     104 // Communication Parameters: 8 Data, 1 Stop, No Parity
;     105 // USART Receiver: Off
;     106 // USART Transmitter: On
;     107 // USART Mode: Asynchronous
;     108 // USART Baud rate: 19200
;     109 UCSRA=0x00;
	OUT  0xB,R30
;     110 UCSRB=0x00;
	OUT  0xA,R30
;     111 UCSRC=0x86;
	LDI  R30,LOW(134)
	OUT  0x20,R30
;     112 UBRRH=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     113 UBRRL=0x0C;
	LDI  R30,LOW(12)
	OUT  0x9,R30
;     114 UCSRB=0x08;
	LDI  R30,LOW(8)
	OUT  0xA,R30
;     115
;     116 // Analog Comparator initialization
;     117 // Analog Comparator: Off
;     118 // Analog Comparator Input Capture by Timer/Counter 1: Off
;     119 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     120 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;     121
;     122 // ADC initialization
;     123 // ADC Clock frequency: 125,000 kHz
;     124 // ADC Voltage Reference: internal
;     125 ADMUX=0xC1; //internal reference; ADC1
	LDI  R30,LOW(193)
	OUT  0x7,R30
;     126 //ADMUX=0x40; //AVCC
;     127 //ADCSRA=0x8D; // INT
;     128
;     129 ADCSRA=0x85; //freerunning
	LDI  R30,LOW(133)
	OUT  0x6,R30
;     130
;     131 // Global enable interrupts
;     132 #asm("sei")
	sei
;     133 }
	RET
;     134
;     135
;     136 void main(void){
_main:
;     137
;     138 init_devices();
	RCALL _init_devices
;     139 PORTB.0 = 1;
	SBI  0x18,0
;     140 PORTD.7 = 0;
	CBI  0x12,7
;     141
;     142
;     143 while (1)
_0xD:
;     144 {
;     145
;     146   if (sample){
	SBRS R2,0
	RJMP _0x10
;     147         //delay_ms(20);
;     148         printf("%i\n",read_adc());
	__POINTW1FN _0,0
	ST   -Y,R31
	ST   -Y,R30
	RCALL _read_adc
	CLR  R22
	CLR  R23
	RCALL __PUTPARD1
	LDI  R24,4
	RCALL _printf
	ADIW R28,6
;     149         putchar(0x0D);
	LDI  R30,LOW(13)
	RCALL SUBOPT_0x0
;     150   }
;     151
;     152   if (!PINB.1) {
_0x10:
	SBIC 0x16,1
	RJMP _0x11
;     153         sample ^= 1;
	LDI  R30,0
	SBRC R2,0
	LDI  R30,1
	RCALL SUBOPT_0x1
	BLD  R2,0
;     154         PORTB.0 ^= 1;
	LDI  R30,0
	SBIC 0x18,0
	LDI  R30,1
	RCALL SUBOPT_0x1
	IN   R26,0x18
	BLD  R26,0
	OUT  0x18,R26
;     155         PORTD.7 ^= 1;
	LDI  R30,0
	SBIC 0x12,7
	LDI  R30,1
	RCALL SUBOPT_0x1
	IN   R26,0x12
	BLD  R26,7
	OUT  0x12,R26
;     156         while (!PINB.1);
_0x12:
	SBIS 0x16,1
	RJMP _0x12
;     157   }
;     158
;     159
;     160 }
_0x11:
	RJMP _0xD
;     161 }
_0x15:
	RJMP _0x15
;     162
;     163
;     164
;     165
;     166
;     167
;     168
;     169
;     170

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
	put:
	RCALL SUBOPT_0x2
	SBIW R30,0
	BREQ _0x16
	RCALL SUBOPT_0x2
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
	SBIW R30,1
	LDD  R26,Y+2
	STD  Z+0,R26
	RJMP _0x17
_0x16:
	LDD  R30,Y+2
	RCALL SUBOPT_0x0
_0x17:
	ADIW R28,3
	RET
__print_G2:
	SBIW R28,4
	RCALL __SAVELOCR6
	LDI  R16,0
_0x18:
	LDD  R30,Y+14
	LDD  R31,Y+14+1
	ADIW R30,1
	STD  Y+14,R30
	STD  Y+14+1,R31
	RCALL SUBOPT_0x3
	BRNE PC+2
	RJMP _0x1A
	MOV  R30,R16
	CPI  R30,0
	BRNE _0x1E
	CPI  R18,37
	BRNE _0x1F
	LDI  R16,LOW(1)
	RJMP _0x20
_0x1F:
	RCALL SUBOPT_0x4
_0x20:
	RJMP _0x1D
_0x1E:
	CPI  R30,LOW(0x1)
	BRNE _0x21
	CPI  R18,37
	BRNE _0x22
	RCALL SUBOPT_0x4
	LDI  R16,LOW(0)
	RJMP _0x1D
_0x22:
	LDI  R16,LOW(2)
	LDI  R19,LOW(0)
	LDI  R17,LOW(0)
	CPI  R18,43
	BRNE _0x23
	LDI  R19,LOW(43)
	RJMP _0x1D
_0x23:
	CPI  R18,32
	BRNE _0x24
	LDI  R19,LOW(32)
	RJMP _0x1D
_0x24:
	RJMP _0x25
_0x21:
	CPI  R30,LOW(0x2)
	BRNE _0x26
_0x25:
	CPI  R18,48
	BRNE _0x27
	ORI  R17,LOW(16)
	LDI  R16,LOW(5)
	RJMP _0x1D
_0x27:
	RJMP _0x28
_0x26:
	CPI  R30,LOW(0x5)
	BREQ PC+2
	RJMP _0x1D
_0x28:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x2D
	RCALL SUBOPT_0x5
	LD   R30,X
	ST   -Y,R30
	RCALL SUBOPT_0x6
	RJMP _0x2E
_0x2D:
	CPI  R30,LOW(0x73)
	BRNE _0x30
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x7
_0x31:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
	MOV  R18,R30
	CPI  R30,0
	BREQ _0x33
	RCALL SUBOPT_0x4
	RJMP _0x31
_0x33:
	RJMP _0x2E
_0x30:
	CPI  R30,LOW(0x70)
	BRNE _0x35
	RCALL SUBOPT_0x5
	RCALL SUBOPT_0x7
_0x36:
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	RCALL SUBOPT_0x3
	BREQ _0x38
	RCALL SUBOPT_0x4
	RJMP _0x36
_0x38:
	RJMP _0x2E
_0x35:
	CPI  R30,LOW(0x64)
	BREQ _0x3B
	CPI  R30,LOW(0x69)
	BRNE _0x3C
_0x3B:
	ORI  R17,LOW(1)
	RJMP _0x3D
_0x3C:
	CPI  R30,LOW(0x75)
	BRNE _0x3E
_0x3D:
	LDI  R30,LOW(_tbl10_G2*2)
	LDI  R31,HIGH(_tbl10_G2*2)
	RJMP _0x52
_0x3E:
	CPI  R30,LOW(0x58)
	BRNE _0x41
	ORI  R17,LOW(2)
	RJMP _0x42
_0x41:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x51
_0x42:
	LDI  R30,LOW(_tbl16_G2*2)
	LDI  R31,HIGH(_tbl16_G2*2)
_0x52:
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBRS R17,0
	RJMP _0x44
	RCALL SUBOPT_0x5
	LD   R20,X+
	LD   R21,X
	SUBI R20,0
	SBCI R21,0
	BRGE _0x45
	__GETW1R 20,21
	RCALL __ANEGW1
	__PUTW1R 20,21
	LDI  R19,LOW(45)
_0x45:
	CPI  R19,0
	BREQ _0x46
	ST   -Y,R19
	RCALL SUBOPT_0x6
_0x46:
	RJMP _0x47
_0x44:
	RCALL SUBOPT_0x5
	LD   R20,X+
	LD   R21,X
_0x47:
_0x49:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,2
	RCALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
                              calc_digit:
                                  cp   r20,r30
                                  cpc  r21,r31
                                  brlo calc_digit_done
	SUBI R18,-LOW(1)
	                              sub  r20,r30
	                              sbc  r21,r31
	                              brne calc_digit
                              calc_digit_done:
	SBRC R17,4
	RJMP _0x4C
	LDI  R30,LOW(48)
	CP   R30,R18
	BRLO _0x4C
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	CPI  R26,LOW(0x1)
	LDI  R30,HIGH(0x1)
	CPC  R27,R30
	BRNE _0x4B
_0x4C:
	ORI  R17,LOW(16)
	LDI  R30,LOW(57)
	CP   R30,R18
	BRSH _0x4E
	SBRS R17,1
	RJMP _0x4F
	SUBI R18,-LOW(7)
	RJMP _0x50
_0x4F:
	SUBI R18,-LOW(39)
_0x50:
_0x4E:
	RCALL SUBOPT_0x4
_0x4B:
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x4A
	RJMP _0x49
_0x4A:
_0x51:
_0x2E:
	LDI  R16,LOW(0)
_0x1D:
	RJMP _0x18
_0x1A:
	RCALL __LOADLOCR6
	ADIW R28,16
	RET
_printf:
	PUSH R15
	MOV  R15,R24
	SBIW R28,2
	RCALL __SAVELOCR2
	MOVW R26,R28
	RCALL __ADDW2R15
	__PUTW2R 16,17
	LDI  R30,0
	STD  Y+2,R30
	STD  Y+2+1,R30
	MOVW R26,R28
	ADIW R26,4
	RCALL __ADDW2R15
	RCALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	RCALL __print_G2
	RCALL __LOADLOCR2
	ADIW R28,4
	POP  R15
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x0:
	ST   -Y,R30
	RJMP _putchar

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1:
	LDI  R26,LOW(1)
	EOR  R30,R26
	RCALL __BSTB1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2:
	LD   R26,Y
	LDD  R27,Y+1
	RCALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x4:
	ST   -Y,R18
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G2

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x5:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	SBIW R26,4
	STD  Y+12,R26
	STD  Y+12+1,R27
	ADIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6:
	LDD  R30,Y+11
	LDD  R31,Y+11+1
	ST   -Y,R31
	ST   -Y,R30
	RJMP __put_G2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	RCALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

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
	COM  R30
	COM  R31
	ADIW R30,1
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

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R19
	CLR  R20
	LDI  R21,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R19
	ROL  R20
	SUB  R0,R30
	SBC  R1,R31
	SBC  R19,R22
	SBC  R20,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R19,R22
	ADC  R20,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R21
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOV  R24,R19
	MOV  R25,R20
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
	CLR  R0
	CPSE R30,R0
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

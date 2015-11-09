TITLE Set Rounding Mode Macro (SetRoundingModes.asm)

INCLUDE C:\Irvine\Irvine32.inc

; Prints a very excited message when the IFIDNI statement is tripped.
mPrintTripped MACRO
	LOCAL trip
	.data
	trip BYTE 1,1,1,1,1,1,1,1,1," IFIDNI Tripped! YAY! ", 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0
	.code
	push edx
	mov edx, OFFSET trip
	call WriteString
	call Crlf
	pop edx
ENDM

;---------------------------------------------------------------
mRound MACRO roundParam
; Uses EAX
; Input: RZ, RE, RU, RD (Case insensitive)
; Sets rounding method based on input.
; RZ = Round Zero, RE = Round Even, RU = Round Up, RD = Round Down

	LOCAL ctrlWord
	.data
		ctrlWord WORD ?
	.code
	push eax

	fstcw ctrlWord			; Gets current FPU settings
	
	IFIDNI <&roundParam>, <RZ>
		or ctrlWord, 110000000000b	; sets bits 10 and 11 to 11
	ELSEIFIDNI <&roundParam>, <RE>
		and ctrlWord, 001111111111b	; sets bits 10 and 11 to 00
	ELSEIFIDNI <&roundParam>, <RU>
		or ctrlWord, 101111111111b	; sets bits 10 and 11 to (10 or 11)
		and ctrlWord, 101111111111b	; sets bits 10 and 11 to 10
	ELSEIFIDNI <&roundParam>, <RD>
		or ctrlWord, 011111111111b	; sets bits 10 and 11 to (01 or 11)
		and ctrlWord, 011111111111b	; sets bits 10 and 11 to 01
	ELSE
		ECHO Warning: Invalid rounding method specified.
		ECHO Warning: Must choose RZ, RE, RU, or RD
		ECHO ******************************************************
		EXITM
	ENDIF
	fldcw ctrlWord		; Saves altered FPU settings
	pop eax
ENDM
;----------------------------END mRound--------------------

;----------------------------------------------------------
mPrintControls MACRO
; Uses EAX
; Obtains FPU settings and prints binary representation
; For debugging purposes

	LOCAL control
	.data
	control WORD ?

	.code
	push eax
	fstcw control
	movzx eax, control
	call WriteBin
	call Crlf
	pop eax
ENDM
;----------------------END mPrintControls------------------

testmRound MACRO vA, vB, vC
	fild vA
	fadd vB
	call WriteFloat
	call Crlf
	fistp vC
	movzx eax, vC
	call WriteDec
	call Crlf
ENDM

testIntRound MACRO vFloat

	LOCAL fLabel, iLabel, tempInt
	.data
		fLabel BYTE "Float Value: ",0
		iLabel BYTE " Integer Value: ",0
		tempInt DWORD ?

	.code

	fld vFloat
	mov edx, OFFSET fLabel
	call Crlf
	call WriteString
	call WriteFloat
	fistp tempInt
	mov edx, OFFSET iLabel
	call WriteString
	mov eax, tempInt
	call WriteInt
ENDM


.data

	valB REAL8 3.334

.code

Main PROC
FINIT
	
	mPrintControls
	mRound rz
	testIntRound valB
	mRound re
	testIntRound valB
	mRound ru
	testIntRound valB
	mRound rd
	testIntRound valB
	call Crlf

exit
Main ENDP

END Main

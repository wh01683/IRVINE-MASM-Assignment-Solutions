TITLE Display Floating-Point Binary (DisplayFloatingBinary.asm)

INCLUDE C:\Irvine\Irvine32.inc

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


.data

DisplayFloatingPointBinary PROTO num: REAL4

var1 REAL4 1213.75

nmInt DWORD 1

.code

Main PROC
	FINIT
	mRound rz

	
	INVOKE DisplayFloatingPointBinary, var1

exit
Main ENDP


DisplayFloatingPointBinary PROC USES ecx, 
	num: REAL4,

	.data

	two REAL4 2.0
	twoB WORD 10b
	offSetPosition BYTE ?
	one DWORD 1
	numInt DWORD ?
	firstNumInt DWORD ?
	temp DWORD ?
	tempECX DWORD ?
	res BYTE ?
	decim BYTE ".",0
	numBin DWORD ?
	position DWORD 10000000000000000000000b ; 23rd position is start
	

	.code

	mov ecx, 22			; Max precision places

						; Put number in FPU stack, truncate, and place 
						; integer val in numInt local variable
	fld num
	mRound rz
	fistp firstNumInt
	mov res, 43

						; Check if Negative, replace sign if negative (default +)
	fldz
	fild firstNumInt
	fcompp
	jl NegL

	Process:
		fld num				; Put num on stack (ST(0))
		fistp numInt		; Get the integer and pop
		fld num				; Put num back on stack at (ST(1))
		fild numInt			; Put integer on stack (ST(0))
		fsub				; Subtract to get fraction
		fmul two			; multiply by two
		call ShowFPUStack
		fstp num			; Store result in num and pop


		; Calculate position inner loop. Raises 2 to power N (count)
		mov position, 0
		mov tempECX, ecx


		push eax
		push ebx
		push ecx
		mov eax, 1
		mov ebx, 2
		mov ecx, tempECX
			RaisePower:
				mul ebx
			Loop RaisePower
		mov position, eax
		pop ecx
		pop ebx
		pop eax
		mov ecx, tempECX

		
		; Incrementing binary
		mov eax, numInt		; Place integer result in eax
		mul position		; multiply eax by current position (will result in 0 if no integer)
		add numBin, eax		; Add this product to numBin to increment it.

	Loop Process
	jmp Done

	NegL:
		mov res, 45
		jmp Process

	Done:
		call Crlf
		mov al, res
		call WriteChar
		mov edx, OFFSET decim	; Needs to go to the right by 9 bits
		call WriteString
		mov eax, numBin
		call WriteBin
		call Crlf
		ret

	exit
DisplayFloatingPointBinary ENDP

END Main


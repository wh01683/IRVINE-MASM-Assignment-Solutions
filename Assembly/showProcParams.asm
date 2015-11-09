TITLE Show Procedure Parameters	(showProcParams.asm)
;	--------------------
;	Ch. 8, number 10
;	--------------------
INCLUDE C:/Irvine/Irvine32.inc

.data
	header BYTE "---------------Stack Parameters:--------------------", 0
	lines BYTE  "----------------------------------------------------", 0
	address BYTE "Address: ", 0
	equals BYTE " = ", 0
	
	SampleProc PROTO, var1: DWORD, var2: DWORD, var3: DWORD, var4: DWORD, var5: DWORD, var6: DWORD,
		var7: DWORD, var8:DWORD, var9: DWORD
	ShowParameters PROTO, pCount: DWORD
	
.code

main PROC
		
	INVOKE SampleProc, 9999h, 3636h, 1h, 5432h, 12323h, 213h, 35321h, 90932h, 2109h
main ENDP

SampleProc PROC,
	var1: DWORD,			; ebp+24
	var2: DWORD,			; ebp+28
	var3: DWORD, 			; ebp+32
	var4: DWORD,
	var5: DWORD,
	var6: DWORD,
	var7: DWORD,
	var8: DWORD,
	var9: DWORD


	paramCount = 9			; ebp+12
	INVOKE ShowParameters, paramCount
	ret
SampleProc ENDP

ShowParameters PROC,
	 pCount:DWORD

		
		mov ecx, pCount

		enter 0, 0				; no local variables declared
		add ebp, 24				; 24 is currently a "magic constant", and shows all parameters regardless of amount
		push eax

		mov edx, OFFSET header
		call WriteString
		call Crlf
		mov edx, OFFSET lines
		call WriteString
		call Crlf
		
		pop eax

		Process:
	
			mov edx, OFFSET address
			call WriteString
			mov eax, ebp
			call writeHex
			mov edx, OFFSET equals
			call WriteString
			mov eax, [ebp]			; move stack contents to eax and print
			call WriteHex			
			call Crlf
			add ebp, SIZEOF DWORD	; increment by size of DWORD to get to the next params

		Loop Process
	leave
	ret
ShowParameters ENDP

end Main
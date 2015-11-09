TITLE FrequencyTable		(FreqTable.asm)

INCLUDE C:/Irvine/Irvine32.inc

Get_frequencies PROTO targ: PTR BYTE, fTable: PTR DWORD
PrintArray PROTO pArray: PTR DWORD, Count: DWORD

.data

target BYTE "AAEBDCFBBC",0
freqTable DWORD 256 DUP(0)
com BYTE ", ",0
col BYTE "Index: ",0

.code

Main PROC

INVOKE Get_frequencies, ADDR target, ADDR freqTable

INVOKE PrintArray, ADDR freqTable, 256


exit
Main ENDP

Get_frequencies PROC USES edi esi ebx,
	targ: PTR BYTE,
	fTable: PTR DWORD

	mov esi, targ
	mov edi, fTable
	mov bl, SIZEOF DWORD
	cld
	
		Cycle:

		mov al, [esi]
		call WriteChar
		; Move current character to eax

		cmp al, 0		; If null termination char encountered, exit
		je Terminate

		; Add the value to edx to get to desired index
		mul bl
		
		add edi, eax

				push ebx
				; Increment contents in Frequency Table by 1
					mov ebx, [edi]	; store contents in esi
					add ebx, 1		; Increment by 1
					mov [edi], ebx	; Move result back to edx
				pop ebx
	
		
		jmp Cycle

	Terminate:
	ret 

Get_frequencies ENDP


PrintArray PROC uses eax ecx edx esi,
	pArray: PTR DWORD,
	Count: DWORD
	LOCAL counter: DWORD

	cld

	mov esi, pArray
	mov ecx, Count
	mov edx, SIZEOF DWORD
	
	Print: lodsd		; Load [ESI] into EAX
		call WriteChar
	
		mov edx, OFFSET com
		call WriteString

		mov edx, OFFSET col
		call WriteString

		mov eax, count
		call WriteInt
	
		add counter, 1
		call Crlf
	Loop Print

	call Crlf
	ret
PrintArray ENDP

end Get_frequencies
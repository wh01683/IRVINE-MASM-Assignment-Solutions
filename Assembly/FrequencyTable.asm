TITLE FrequencyTable		(FrequencyTable.asm)

INCLUDE C:/Irvine/Irvine32.inc

Get_frequencies PROTO targ: PTR BYTE, fTable: PTR DWORD
PrintArray PROTO pArray: PTR DWORD, Count: DWORD

.data

target BYTE """00000",0
freqTable DWORD 256 DUP(0)
com BYTE ", ",0
col BYTE "Index: ",0

.code

Main PROC


mov edx, OFFSET target
call WriteString

INVOKE Get_frequencies, ADDR target, ADDR freqTable

INVOKE PrintArray, ADDR freqTable, 256

exit
Main ENDP

Get_frequencies PROC USES esi,
	targ: PTR BYTE,
	fTable: PTR DWORD
	LOCAL curChar : BYTE
	mov esi, targ
	mov edi, fTable
	mov ebx, SIZEOF DWORD

	cld
	
		Cycle: lodsb

		call WriteChar
		movzx eax, al
		; Move current character to eax
		mov curChar, al

		cmp al, 0		; If null termination char encountered, exit
		je Terminate
		
		mul ebx
		add edi, eax

		; Increment contents in Frequency Table by 1
		push eax
			mov eax, [edi]	; store contents in ebx
			add eax, 1		; Increment by 1
			mov [edi], eax	; Move result back to edi
		pop eax

		sub edi, eax

		jmp Cycle

	Terminate:
	mov fTable, edi
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
	mov counter, 0
	call Crlf

	Print: lodsd		; Load [ESI] into EAX
		call WriteInt
	
		mov edx, OFFSET com
		call WriteString

		mov edx, OFFSET col
		call WriteString

		mov eax, counter
		call WriteInt
	
		add counter, 1
		call Crlf
	Loop Print

	call Crlf
	ret
PrintArray ENDP

end Main
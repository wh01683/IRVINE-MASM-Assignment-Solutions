

TITLE FrequencyTable		(FrequencyTable.asm)

INCLUDE C:/Irvine/Irvine32.inc

Pour_Sieve PROTO upperBound:DWORD, primeArray: PTR DWORD
PrintArray PROTO pArray: PTR DWORD, Count: DWORD
SieveLoop PROTO upperBound:DWORD, primeArray: PTR DWORD, curPrime: DWORD

MAX = 255

.data

primTable DWORD 65000 DUP(0)
com BYTE ", ",0
col BYTE "Index: ",0
pri BYTE "Prime Number: ", 0

.code

Main PROC



INVOKE Pour_Sieve, 255, ADDR primTable

INVOKE PrintArray, ADDR primTable, 255

exit
Main ENDP

Pour_Sieve PROC USES esi edi,
	upperBound:DWORD,
	primeArray: PTR DWORD

	LOCAL indexCounter : DWORD,
			innerLoopMax: DWORD,
			innerLoopCounter: DWORD,
			iTwo: DWORD
	
	mov edi, primeArray
	mov indexCounter, 2
	mov ecx, upperBound
	add edi, 8
	mov al, 0
	mov dh, 1
	cld
	rep stosb

	mov dl, 0
	
	OuterLoop:
		mov ebx, [esi]
		cmp bl, dl
		je InnerLoop

		InnerLoop:
			mov ecx, indexCounter
			mov innerLoopMax, ecx
			push eax
			mov eax, ecx
			mul eax
			mov iTwo, eax
			pop eax
			push ebx
			mov eax, ecx
			mov ebx, innerLoopCounter
			mul ebx
			mov ebx, SIZEOF DWORD
			mul ebx
			pop ebx
			add eax, iTwo
			add esi, eax
			mov [esi], dh
			push ebx
			mov ebx, innerLoopCounter
			add innerLoopCounter, 1
			cmp ebx, innerLoopMax
			pop ebx
			jl InnerLoop

		add esi, 4
		add indexCounter, 1
	cmp indexCounter, MAX
	jl OuterLoop



	ret

Pour_Sieve ENDP


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

	
	PrintPrimes: lodsd ; Load [ESI] into EAX

		cmp al, '0'
			je prime
		add counter, 1
		cmp counter, ecx
			je quit
			jne PrintPrimes

		prime:
			mov edx, OFFSET pri
			call WriteString
			mov eax, counter
			call WriteInt
			call Crlf
			add counter, 1
			cmp counter, ecx
			je quit
			jne PrintPrimes

		quit:
		call Crlf
		ret
PrintArray ENDP



end Main
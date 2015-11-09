TITLE FrequencyTable		(FrequencyTable.asm)

INCLUDE C:/Irvine/Irvine32.inc

Pour_Sieve PROTO upperBound:DWORD, primeArray: PTR DWORD
PrintArray PROTO pArray: PTR DWORD, Count: DWORD
SieveLoop PROTO upperBound:DWORD, primeArray: PTR DWORD, curPrime: DWORD


.data

primTable DWORD 65000 DUP(0)
com BYTE ", ",0
col BYTE "Index: ",0
pri BYTE "Prime Number: ", 0

.code




INVOKE Pour_Sieve, 65000, ADDR primTable

INVOKE PrintArray, ADDR primTable, 65000

exit
Main ENDP

Pour_Sieve PROC USES esi edi,
	upperBound:DWORD,
	primeArray: PTR DWORD

	LOCAL indexCounter : DWORD
	
	mov edi, primeArray

	mov ecx, upperBound
	mov al, '0'
	cld
	rep stosb
	
	mov edx, 1

	mov indexCounter, 8
	add edi, 8
	MulTwoLoop:
		add edi, 8
		add indexCounter, 8
		mov [edi], edx
		mov ebx, indexCounter
		cmp ebx, upperBound
		jl MulTwoLoop
	
	mov edi, primeArray
	mov indexCounter, 12
	add edi, 12

	MulThreeLoop:
		add edi, 12
		add indexCounter, 12
		mov [edi], edx
		mov ebx, indexCounter
		cmp ebx, upperBound
		jl MulThreeLoop

	mov edi, primeArray
	mov indexCounter, 20
	add edi, 20

	MulFiveLoop:
		add edi, 20
		add indexCounter, 20
		mov [edi], edx
		mov ebx, indexCounter
		cmp ebx, upperBound
		jl MulFiveLoop
	
	mov edi, primeArray
	mov indexCounter, 24
	add edi, 24


	MulSevenLoop:
		add edi, 24
		add indexCounter, 24
		mov [edi], edx
		mov ebx, indexCounter
		cmp ebx, upperBound
		jl MulSevenLoop
						
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
TITLE FrequencyTable		(FrequencyTable.asm)

INCLUDE C:/Irvine/Irvine32.inc

Pour_Sieve PROTO upperBound:DWORD, primeArray: PTR DWORD
PrintArray PROTO pArray: PTR DWORD, Count: DWORD
SieveLoop PROTO uBound:DWORD, prArray: PTR DWORD, curPrime: DWORD


.data

primTable DWORD 5 DUP(0)
com BYTE ", ",0
col BYTE "Index: ",0
pri BYTE "Prime Number: ", 0

.code

Main PROC



INVOKE Pour_Sieve, 5, ADDR primTable

INVOKE PrintArray, ADDR primTable, 5

exit
Main ENDP

Pour_Sieve PROC USES esi edi,
	upperBound:DWORD,
	primeArray: PTR DWORD

	LOCAL currentPrime: DWORD,
			count:DWORD


	mov esi, primeArray		; ESI storing pointer to primeArray
	mov ecx, upperBound		; Loop counter to fill array with 0
	mov eax, 0				; Storing 0 in al
	cld						; Set direction forward
	rep stosb				; Fill array with 0
	
	mov ecx, upperBound		; Moving upperBound back to ECX
	add esi, 4				; Increment esi once
	mov currentPrime, 2		; Store first prime = 2 in currentPrime
	mov count, 1			; Initialize count to 1
	
		Pouring: lodsd		; Load [ESI] to EAX

		add count, 1		; Increment count
	
		cmp al, 0			; Comparing contents to 0
		je Sieve			; If 0, it's new prime
	
		cmp count, ecx		; Comparing count to bound
		jl Pouring			; If count is still less than limit, repeat loop
		jmp Done			; Otherwise, we're done
	
	Sieve:
		mov edx, count		; Set new currentPrime to count
		mov currentPrime, edx
		INVOKE SieveLoop, upperBound, ADDR primeArray, currentPrime
		jmp Pouring
			
	Done:			
		ret 

Pour_Sieve ENDP


SieveLoop PROC USES edi edx eax ecx,
	uBound:DWORD,
	prArray: PTR DWORD,
	curPrime: DWORD

	LOCAL indCounter:DWORD

	mov esi, prArray	; moving array pointer to esi
	mov bl, 1			; Store Prime Flag in bl
	mov edx, curPrime	; Store current prime number in edx
	mov indCounter, 0	; initialize counter to 0
	mov al, 1
	jmp ValidIncrement	; Jump to ValidIncrement to check if address has more room

	ValidIncrement:
		push ecx
		mov ecx, edx
		add ecx, edx
		add ecx, edx
		add ecx, edx
		add ecx, indCounter
		cmp ecx, uBound
		pop ecx
		jl IncrementArray		; Is Valid
		jge Done				; Is Not Valid
	
	IncrementArray:
		add esi, edx
		add esi, edx
		add esi, edx
		add esi, edx
		cmp al, 1			; Will need to increment array one extra time per SieveLoop call
		mov al, 0
		je IncrementArray
		jmp MarkMultiples
	
	MarkMultiples:

		add indCounter, edx
		mov [esi], bl
		push ebx
		mov ebx, indCounter
		cmp ebx, uBound
		pop ebx
		jl MarkMultiples
		

	Done:
		mov edi, prArray
		ret

SieveLoop ENDP

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
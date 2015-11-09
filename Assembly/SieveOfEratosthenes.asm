TITLE Sieve Demonstration (SieveOfEratosthenes.asm)

Include C:\Irvine\Irvine32.inc

VARSIZE = 4
PRIME = 0
NOTPRIME = 1

.data

InnerSieveLoop PROTO inrArr: PTR DWORD, iVal:DWORD, maxN:DWORD
OuterSieveLoop PROTO pArray: PTR DWORD, sizeArray:DWORD

PrintArray PROTO pArray: PTR DWORD, Count: DWORD

com BYTE ", ",0
col BYTE "Index: ",0
pri BYTE "Prime Number: ", 0

PrimaryArray DWORD 100 DUP(?)


.code
Main PROC
	

	INVOKE OuterSieveLoop, ADDR PrimaryArray, 99
	INVOKE PrintArray, ADDR PrimaryArray, 99

exit
Main ENDP

OuterSieveLoop PROC USES ecx eax edx ebx,
		pArray: PTR DWORD,
		sizeArray: DWORD

LOCAL outerLimit:DWORD,		; Square root of n (sizeArray)
	  outerCounter:DWORD,
	  outerInc:DWORD

	mov edi, pArray
	mov outerCounter, 1
	mov outerLimit, 10		; set 255 for now

	; Initializing Array
		mov ecx, sizeArray
		mov al, PRIME
		cld
		rep stosb
	; Done Initializing Array

	L1:
		add outerCounter, 1
		mov eax, outerCounter		; eax = counter(i)
		mov ebx, VARSIZE
		mul ebx						; eax = i*4

		cmp eax, outerLimit			; compare eax to outer limit
		jge OuterDone				; If eax is >= outer limit, exit
		
		add edi, eax				; otherwise, increment array pointer by eax
		mov outerInc, eax
		mov edx, [edi]				; place contents into edx
		cmp edx, PRIME
		je L2
		jne L1
	L2:
		INVOKE InnerSieveLoop, ADDR pArray, eax, sizeArray
		mov eax, outerInc
		jmp L1

	OuterDone:
		ret

OuterSieveLoop ENDP

InnerSieveLoop PROC uses eax edx,
	inrArr: PTR DWORD,
	iVal:DWORD,
	maxN:DWORD

	LOCAL innerCounter:DWORD,
		  iSqrd:DWORD,
		  jCounter:DWORD

	mov edi, inrArr			; Store array in edi
	;Might not need this if outer loop already moves it there

	mov ebx, VARSIZE
	mov eax, iVal
	div ebx
	mov iVal, eax

	mov eax, iVal
	mul iVal				; i^2

	mov iSqrd, eax			; initialized at i^2
	mov innerCounter, eax 	; initialized at i^2

	mov jCounter, 0			; initialized at 0

	L1:
		mov eax, iVal		; eax = i
		mul jCounter		; eax = i*j
		add eax, iSqrd		; eax = (i^2 + i*j)

		mov edx, eax		; move eax to edx for checking
		cmp edx, maxN		; compare to max N
		jge Done			; if (i^2 + i*j) >= Max N, exit
		
		add edi, eax		; increment edi by (i^2 + i*j)
		mov edx, NOTPRIME
			
		

		mov [edi], edx		; replace array contents with 1 (not prime)
		push eax
		mov eax, [edi]		; write prime to 
		call WriteInt
		pop eax
		push eax
		mov eax, jCounter
		call Crlf
		call WriteInt
		pop eax
		add jCounter, 1		; increment counter
		jmp L1				; loop

	Done:
		ret

InnerSieveLoop ENDP













































































































































































































































































PrintArray PROC uses eax ecx edx,
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

		cmp al, 0
			je prime1
		add counter, 1
		cmp counter, ecx
			je quit
			jne PrintPrimes

		prime1:
			mov edx, OFFSET pri
			call WriteString
			mov edx, OFFSET com
			call WriteString
			call WriteInt
			push eax
			mov eax, counter
			call WriteInt
			pop eax
			call Crlf
			add counter, 1
			cmp counter, ecx
			je quit
			jne PrintPrimes

		quit:
		call Crlf
		ret
PrintArray ENDP

END Main
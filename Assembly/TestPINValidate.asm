TITLE Test PIN Validate (TestPINValidate.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data
	upperArray BYTE 9, 5, 8, 4, 6
	lowerArray BYTE 5, 2, 4, 1, 3

	testPin1 BYTE 2, 4, 9, 1, 0
	testPin2 BYTE 5, 2, 4, 1, 3
	testPin3 BYTE 9, 5, 8, 4, 6
	testPin4 BYTE 7, 4, 5, 3, 9
	testPin5 BYTE 6, 3, 0, 0, 0

.code
	main PROC

	mov esi, OFFSET testPin1
	
	call Validate_PIN
	call WriteDec
	call Crlf
	
	mov esi, OFFSET testPin2
	
	call Validate_PIN
	call WriteDec
	call Crlf
	
	mov esi, OFFSET testPin3
	
	call Validate_PIN
	call WriteDec
	call Crlf

	mov esi, OFFSET testPin4
	
	call Validate_PIN
	call WriteDec
	call Crlf

	mov esi, OFFSET testPin5
	
	call Validate_PIN
	call WriteDec
	call Crlf


exit
main ENDP

Validate_PIN PROC

	mov ecx, 1
	mov ebx, 0

	CheckLower:

		mov al, lowerArray[ebx]
		cmp [esi], al
		jge CheckUpper
		jl Invalid

	CheckUpper:
		
		mov al, upperArray[ebx]
		cmp [esi], al
		jle Valid
		jg Invalid

	Invalid:
		mov eax, ecx
		ret

	Valid:
		add esi, TYPE BYTE
		add ebx, TYPE BYTE

		inc ecx
		cmp ecx, 6
		jne CheckLower
		je Done

	Done:
		mov eax, 0
		ret

Validate_PIN ENDP

END main
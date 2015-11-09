TITLE Finite State Machine

INCLUDE C:\Irvine\Irvine32.inc

ENTER_KEY = 13

.data
InvalidInputMsg BYTE "Invalid input", 13, 10, 0

.code

main PROC

	call Clrscr

StateA:
	call Getnext

	cmp al, '+'
	je StateB

	cmp al, '-'
	je StateB
	
	cmp al, '0'
	je StateD


	call IsDigit
	jz StateC

	call DisplayErrorMessage
	jmp Quit

StateB:
	call Getnext
	cmp al, '0'
	je StateD
	call IsDigit
	jz StateC
	call DisplayErrorMessage
	jmp Quit

StateC:
	call Getnext
	call IsDigit
	jz StateC
	cmp al, ENTER_KEY
	je Quit
	call DisplayErrorMessage
	jmp Quit

StateD:
	call Getnext
	cmp al, ENTER_KEY
	je Quit
	call DisplayErrorMessage
	jmp Quit

Quit:
	call Crlf
	exit

main ENDP

;---------------------------------------
GetNext PROC

	call ReadChar
	call WriteChar
	ret
Getnext ENDP


;--------------------------------------
DisplayErrorMessage PROC


	push edx
	mov edx, OFFSET InvalidInputMsg
	call WriteString
	pop edx
	ret

DisplayErrorMessage ENDP
END main


/*

-02Invalid input

Press any key to continue . . .

00Invalid input

Press any key to continue . . .

+01Invalid input

Press any key to continue . . .


*/
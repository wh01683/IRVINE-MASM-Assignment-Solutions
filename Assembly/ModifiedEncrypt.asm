TITLE Modified Encryption Program (ModifiedEncrypt.asm)

INCLUDE C:\Irvine\Irvine32.inc

KEY = 236
BUFMAX = 128


.data
sPrompt BYTE "Enter the plain text: ", 0
sEncrypt BYTE "Cipher Text: ", 0
sDecrypt BYTE "Decrypted: ", 0
keyArray BYTE 236, 200, 1, 10, 50, 100, 59
keySize DWORD ?
buffer BYTE BUFMAX+1 DUP(0)
bufSize DWORD ?

.code

main PROC
	mov keySize, LENGTHOF keyArray
	call InputTheString
	call TranslateBuffer
	mov edx, OFFSET sEncrypt
	call DisplayMessage
	call TranslateBuffer
	mov edx, OFFSET sDecrypt
	call DisplayMessage
	exit
main ENDP

;-------------------------------------------
InputTheString PROC
; Prompts user for string
;-------------------------------------------

pushad
mov edx, OFFSET sPrompt
call WriteString
mov ecx, BUFMAX
mov edx, OFFSET buffer
call ReadString
mov bufSize, eax
call Crlf
popad
ret
InputTheString ENDP

;-----------------------------------------
DisplayMessage PROC
; Displays encryped/decrypted message
;-----------------------------------------

pushad
	call WriteString
	mov edx, OFFSET buffer
	call WriteString
	call Crlf
	call Crlf
	popad
	ret
DisplayMessage ENDP

;-----------------------------------------
TranslateBuffer PROC
; Translates String by XORing each element
; in the message with each element in the keyArray
;-----------------------------------------

pushad
mov esi, 0
mov ebx, 0

OuterLoop:
		
		   
           cmp esi, bufSize	; Loop1 iterates between 0 and 15, compares counter to 15.
           je done			; jumps to :done: when ecx contents hit 15
           mov ebx, 0		; start inner loop at 0

InnerLoop:
		   mov al, keyArray[ebx]
		   xor buffer[esi], al
		   

           cmp ebx, keySize	    ; compares current counter to 15
           je InnerLoopComplete	; jump out if loop is finished
           inc ebx		 ; increment inner loop counter
           jmp InnerLoop ; starts over

InnerLoopComplete:	; End of inner loop

           inc esi	; increment outer loop counter
           jmp OuterLoop ; goes back to beginning of OuterLoop
done:

	popad
	ret
TranslateBuffer ENDP
END main
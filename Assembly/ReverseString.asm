TITLE Lab5_A(Lab5_A.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data

source BYTE "This is the source string",0
target BYTE SIZEOF source DUP('#')

.code
main PROC
call DumpRegs
mov ecx, LENGTHOF source			; move length of source string to loop counter
mov esi, OFFSET source				; store source string in esi reg

L1:
mov al,[esi]						; moving elements of source string to al
push ax								; push onto ax stack
inc esi								; increment to next element
Loop L1

mov ecx, LENGTHOF source			; reset loop counter
mov edi, OFFSET target				; move target string to edi

L2:
pop ax								; popping elements of source string
mov [edi], al						; placing popped elements into edi
call writeChar						; writing each char in reversed order for verification
inc edi								; increment to next spot in target
Loop L2

exit
main ENDP
END main
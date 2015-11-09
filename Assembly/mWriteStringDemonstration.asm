TITLE Demonstrate Write String Macro (mWriteStringDemonstration.asm)

INCLUDE C:\Irvine\Irvine32.inc



mWriteString MACRO str:REQ, color:REQ

	push edx
	push eax

	mov ax, color
	mov edx, OFFSET str
	call SetTextColor
	call WriteString
	call Crlf

	pop edx
	pop eax

ENDM

.data
	
	string1 db "String1: Here is my string", 0
	string2 db "String2: String number 2 is a little longer.", 0
	string3 db "String3: String 3 has a new line", 
				13, 10, "this is the new line", 0
	string4 db "This is the fourth string and it is also defined as string the fourth", 0
	string5 db "This string is invisibdle.", 0

.code


Main PROC

	mWriteString string1, cyan
	mWriteString string2, blue
	mWriteString string3, red
	mWriteString string4, lightGreen
	mWriteString string5, black

exit
Main ENDP

END Main
TITLE Lab5_A(Lab5_A.asm)
INCLUDE C:\Irvine\Irvine32.inc

;	A Program used to obtain address information from the user and display it 
;	in the form of a letter salutation.

;		Robert Howerton
;		10/01/2015



.data

nameVar BYTE 25 DUP(0)						; variable for name
nameCount DWORD ?

addrVar BYTE 25 DUP(0)						; variable for address
addrCount DWORD ?

cityVar BYTE 25 DUP(0)						; variable for city
cityCount DWORD ?

stateVar BYTE 25 DUP(0)						; variable for state
stateCount DWORD ?

zipVar BYTE 25 DUP(0)						; variable for zipcode
zipCount DWORD ?

capName BYTE "Please enter your name: ", 0	; name prompt variable
capAddr BYTE "Enter address: ", 0			; addr prompt variable
capCity BYTE "Enter city: ", 0				; city prompt variable
capState BYTE "Enter State: ", 0			; state prompt variable
capZip BYTE "Enter zipcode: ", 0			; zip prompt variable

commaSpace BYTE ", ",0						; variable for holding ,_
space BYTE " ",0



.code
main PROC

;=========================INPUT==========================

;							Get name from user
mov edx, OFFSET capName
call writeString
mov edx, OFFSET nameVar
mov ecx, SIZEOF nameVar
call ReadString
mov nameCount, eax

;							Get address from user
mov edx, OFFSET capAddr
call writeString
mov edx, OFFSET addrVar
mov ecx, SIZEOF addrVar
call ReadString
mov addrCount, eax

;							Get city from user
mov edx, OFFSET capCity
call writeString
mov edx, OFFSET cityVar
mov ecx, SIZEOF cityVar
call ReadString
mov cityCount, eax
;							Get state from user
mov edx, OFFSET capState
call writeString
mov edx, OFFSET stateVar
mov ecx, SIZEOF stateVar
call ReadString
mov stateCount, eax

;							Get zipcode from user
mov edx, OFFSET capZip
call writeString
mov edx, OFFSET zipVar
mov ecx, SIZEOF zipVar
call ReadString
mov zipCount, eax

;							Make new line and pause before clearing crean and showing output
call Crlf					
call WaitMsg
call ClrScr

;=================================OUTPUT==============================

;							Print name information and makes new line
mov edx, OFFSET nameVar
call WriteString
call Crlf
;							Print address information and starts new line
mov edx, OFFSET addrVar
call WriteString
call Crlf
;							Print city information and ,_
mov edx, OFFSET cityVar
call WriteString
mov edx, OFFSET commaSpace
call WriteString
;							Print state information and a space
mov edx, OFFSET stateVar
call WriteString
mov edx, OFFSET space
call WriteString
;							Print zipcode information and makes new line
mov edx, OFFSET zipVar
call WriteString
call Crlf
;							End program.
exit
main ENDP
END main


/*		=== Pre - Output ===


Please enter your name: Robert Howerton
Enter address: 104 King Drive
Enter city: Statesboro
Enter State: GA
Enter zipcode: 30458

*/

/*		=== Post - Output ===

Robert Howerton
104 King Drive
Statesboro, GA 30458
Press any key to continue . . .

*/
TITLE Lab5_A(Lab5_A.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data
arrayA DWORD 0h,2h,5h,9h,10h
elementB DWORD ?
off = SIZEOF DWORD
sum DWORD 0
.code

main PROC

mov ecx, LENGTHOF arrayA - 1	; for looping
mov eax, OFFSET arrayA			; move array to eax
mov ebx, [eax]					; move n to ebx
mov edi, sum
mov edx, SIZEOF DWORD
call DumpRegs
L1 :
;inc eax								; loop ++

mov esi, [eax + edx]				; move n+1 to esi
mov elementB, esi					; store n+1 in elementB
sub esi, ebx						; subtract n+1 from n
add edi, esi						; add edx to sum
mov ebx, elementB					; move n+1 to ebx

add edx, off						; increment offset

call DumpRegs
Loop L1

call DumpRegs
exit
main ENDP
END main

TITLE Lab5_A(Lab5_A.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data
arrayA WORD 0,2,5,9,10
arrayB DWORD 0,0,0,0,0

.code

main2 PROC


mov ebx, OFFSET arrayA
mov edi, OFFSET arrayB
mov eax, SIZEOF WORD			; WORD
mov esi, SIZEOF DWORD			; DWORD
mov ecx, LENGTHOF arrayA - 1


L1 :
call Crlf

mov edx, [ebx + eax]	; move arrayA to ecx
mov [edi + esi], edx	; move edx to B

add eax, SIZEOF WORD
add esi, SIZEOF DWORD

call dumpRegs
call DumpMem

Loop L1



exit
main2 ENDP
END main2

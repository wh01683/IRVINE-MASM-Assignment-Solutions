TITLE FibTest				(FibTest.asm)
INCLUDE C:/Irvine/Irvine32.inc

FIB_ARR_COUNT = 47
.data
	
	elements DWORD 47
	nMinusOne DWORD ?
	nMinusTwo DWORD ?
	arr DWORD FIB_ARR_COUNT DUP(?)

.code 

FibTest PROC

mov esi, OFFSET arr
mov ecx, FIB_ARR_COUNT

call FibArray

mov ecx, FIB_ARR_COUNT
mov arr, esi


mov ebx, SIZEOF DWORD

Loop1:

mov eax, ecx
call WriteDec

mov eax, '_'
call WriteChar

mov eax, arr[ebx]
call WriteDec

call Crlf

add ebx, SIZEOF DWORD

Loop Loop1
FibTest ENDP

;---------------------------------------------------------------------
FibArray PROC USES esi ecx
;
; Calculates a fibonacci sequence between 1 and n and stores the sequence
; in an array of DWORDs.
; Receives: ESI = pointer to the DWORD array
;			ECX = number of fibonacci elements to calculate.
;----------------------------------------------------------------------


mov nMinusTwo, 0
mov nMinusOne, 1
;mov esi, OFFSET arr

MainLoop:
	
	mov eax, nMinusTwo			; put n-2 in eax
	mov ebx, nMinusOne			; mov n-1 to ebx

	mov nMinusTwo, ebx			; replace n-2 with n-1 
	add eax, ebx				; add n-1 to n-2
	mov nMinusOne, eax			; replace n-1 with n
	mov [esi], eax
	mov ebx, [esi]				; stores n in ebx
	add esi, TYPE DWORD			; incremenet

	Loop MainLoop

ret
FibArray ENDP

exit
END FibTest
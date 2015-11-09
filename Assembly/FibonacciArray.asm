TITLE Fibonacci Array						(FibonacciArray.asm)
INCLUDE C:/Irvine/Irvine32.inc

.data

	elements DWORD ?
	nMinusOne DWORD ?
	nMinusTwo DWORD ?

.code 

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


MainLoop:
	
	mov eax, nMinusTwo		; put n-2 in eax
	mov ebx, nMinusOne		; mov n-1 to ebx

	mov nMinusTwo, ebx		; replace n-2 with n-1 
	add eax, ebx			; add n-1 to n-2
	
	mov [esi], eax			; n = n-1 + n-2
	mov ebx, [esi]			; stores n in ebx
	mov nMinusOne, ebx		; replace n-1 with n
	
	add esi, TYPE DWORD		; incremenet

	Loop MainLoop

ret

FibArray ENDP
END FibArray
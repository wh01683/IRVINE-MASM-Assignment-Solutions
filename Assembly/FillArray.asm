TITLE Fill Array (FillArray.asm)

INCLUDE C:/Irvine/Irvine32.inc

UPPER = 100
LOWER = 20
ELEMENTS = 20

.data

array DWORD ELEMENTS DUP(?)
upperb DWORD ?
lowerb DWORD ?

.code

main PROC

	call Randomize
	mov esi, OFFSET array
	mov edx, LOWER
	mov eax, UPPER
	mov ecx, ELEMENTS

	call FillArray

	mov ecx, ELEMENTS

	mov ebx, TYPE DWORD

Loop1:
	
	mov eax, array[ebx]
	call WriteDec
	
	call Crlf
	add ebx, TYPE DWORD
	Loop Loop1
	
main ENDP

;------------------------------------------------------------------
FillArray PROC
; Fills array of size N with random values ranging from j...k inclusive
; Receives:	ESI = array to fill
;			EDX = Lower bounds
;			EAX = Upper bounds
;			ECX = number of elements
; Returns:  ESI = Filled array
;------------------------------------------------------------------

	mov upperb, eax
	mov lowerb, edx
	call Randomize

FillArrayLoop:

	mov eax, upperb            
	sub eax, lowerb            
	add eax, 1                    
    call RandomRange
	add eax, lowerb
	
	mov [esi], eax

	add esi, TYPE DWORD

	Loop FillArrayLoop

ret

FillArray ENDP
	
END main
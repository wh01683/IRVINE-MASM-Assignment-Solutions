TITLE BubbleSort		(BubbleSort.asm)

INCLUDE C:\Irvine\Irvine32.inc



.data

BubbleSort PROTO pArray: PTR DWORD, Count: DWORD
PrintArray PROTO pArr: PTR DWORD, Count: DWORD

array DWORD 12309, 12398, 222, 199, 0, -123, 222
array1 DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
com BYTE ", ",0
col BYTE "Index: ",0

.code
Main PROC

INVOKE PrintArray, ADDR array, 7
INVOKE BubbleSort, ADDR array, 7
INVOKE PrintArray, ADDR array, 7
exit
Main ENDP



BubbleSort PROC USES eax ecx esi edx,
	pArray: PTR DWORD,
	Count: DWORD
	LOCAL xFlag:BYTE

	mov ecx, Count
	mov xFlag, 0
	dec ecx

	L1: push ecx
		mov esi, pArray

	L2: mov eax, [esi]
		cmp [esi+4], eax
		jge L3
		mov xFlag, 1
		xchg eax, [esi+4]
		mov [esi], eax
	L3: add esi, 4
		loop L2
		pop ecx
		cmp xFlag, 0
		je L4
		loop L1

	L4: ret

BubbleSort ENDP

PrintArray PROC uses eax ecx edx esi,
	pArr: PTR DWORD,
	Count: DWORD
	LOCAL counter: DWORD

	cld

	mov esi, pArr
	mov ecx, Count
	mov edx, SIZEOF DWORD
	mov counter, 0
	
	Print: lodsd		; Load [ESI] into EAX
		call WriteInt
	
		mov edx, OFFSET com
		call WriteString

		mov edx, OFFSET col
		call WriteString

		mov eax, counter
		call WriteInt
	
		add counter, 1
		call Crlf
	Loop Print

	call Crlf
	ret
PrintArray ENDP

END Main
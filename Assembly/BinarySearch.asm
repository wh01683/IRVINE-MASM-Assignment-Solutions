TITLE BinarySearch		(BinarySearch.asm)

INCLUDE C:\Irvine\Irvine32.inc

.data

BinarySearch PROTO pArray: PTR DWORD, Count: DWORD, searchVal: DWORD
PrintArray PROTO pArr: PTR DWORD, Count: DWORD

array DWORD "Bob", 39482348, "3423",  "A", "Buil", "der"
com BYTE ", ",0
col BYTE "Index: ",0
results BYTE "Search results: ", 0

.code
Main PROC

INVOKE PrintArray, ADDR array, 5
mov edx, OFFSET results
call WriteString
INVOKE BinarySearch, ADDR array, 5, "Buil"
call WriteInt
call Crlf
call Crlf
INVOKE PrintArray, ADDR array, 5
exit
Main ENDP



BinarySearch PROC USES ebx edx esi edi ecx,
	pArray: PTR DWORD,
	Count: DWORD,
	searchVal: DWORD

	; Using EDI for mid
	; Using ECX for first
	; Using ESI for last

	mov ecx, 0				; First = 0
	mov eax, Count			; Last = (count-1)
	dec eax			
	mov esi, eax			; ESI last
	mov ebx, pArray			; EBX points to array


	L1:		; While first <= last
		mov eax, ecx
		cmp eax, esi
		jg L5				; Exit search

			; mid = (last + first)/2
		mov eax, esi
		add eax, ecx

		shr eax, 1
		mov edi, eax		; make mid

			; edx = values[mid]
		push esi			; save last
		mov esi, edi		; mid to esi

		shl esi, 2			; Scale mid value by 4
		mov edx, [ebx+esi]	; EDX = values(mid)
		pop esi				; restore last

		; if edx < searchval(edi)

		push eax			; save eax
		mov eax, edi		; put mid on eax
		cmp edx, searchVal		; compare to search
		mov edi, eax		; put mid back on edi
		pop eax				; restore eax
		jge L2

			; first = mid+1
		mov eax, edi	; add mid
		inc eax			
		mov ecx, eax	; copy to first
		jmp L4

			; else if(edx > searchVal(edi))

		L2: 
		push ecx		; save first
		mov ecx, edi	; move mid to ecx
		cmp edx, searchVal	; compare search
		mov edi, ecx	; put mid back on edi
		pop ecx			; restore first
		jle L3

			; last = mid-1

		mov eax, edi	; move mid
		dec eax
		mov esi, eax
		jmp L4

	L3: mov eax, edi	; value found
		jmp L9			; return mid

	L4: pop edi
		jmp L1			; continue loop

	L5: mov eax, -1 ; search failed

	L9: ret

BinarySearch ENDP













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
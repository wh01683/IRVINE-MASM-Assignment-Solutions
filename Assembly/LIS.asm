TITLE Longest Increasing Sequence	(LIS.asm)

INCLUDE C:\Irvine\Irvine32.inc


.data

LongestIncreasingSeq PROTO n: DWORD, arr: PTR DWORD
max_ref DWORD ?
testArr DWORD 10, 22, 9, 33, 21, 50, 41, 60
lisStr BYTE "Length of longest increasing sequence = ",0


.code

Main PROC

INVOKE LongestIncreasingSeq, 8, ADDR testArr
mov edx, OFFSET lisStr
call WriteString
mov eax, max_ref
call WriteInt
call Crlf
   

  

exit
Main ENDP


LongestIncreasingSeq PROC USES eax ecx ebx edx esi edi, 
n: DWORD,
arr: PTR DWORD
LOCAL i: DWORD,
	  j: DWORD,
	  max: DWORD,
	  temp: DWORD
	  

.data

lisArr DWORD 10 DUP(1)


.code

mov ebx, 4
mov eax, n
mul ebx
mov n, eax

mov esi, arr
mov edi, lisArr


; for (i = 1; i < n; i++)
mov ecx, 1	; ECX = i
mov edx, 0	; EDX = j


OuterLoop:
	
	; for(j=0; j < i; j++)

	InnerLoop:
		
		lea ebx, [esi+ecx*4]
		push ecx
		lea ecx, [esi+edx*4] 
 		cmp ebx, ecx 				 ; If arr[i] > arr[j]
		pop ecx
		jg ArriGArrj			
		jmp InnerLoopIteration

	  ArriGArrj:								; (arr[i] > arr[j]) == true
		lea ebx, [edi+edx*4]					; ecx = lisArr[j]
		inc ebx
		push edx
		lea edx, [edi+ecx*4]					; lisArr[j]+1
		cmp edx, ebx							; If lisArr[i] < lisArr[j] + 1
		pop edx
		jl LisiLLisJP1							; Go to second condition check
		jmp InnerLoopIteration					; else, finish loop

	  LisiLLisJP1:								; (lis[i] < lis[j] + 1) == true
	  mov [edi+ecx*4], ecx						; lisArr[i] = lisArr[j] + 1

	  InnerLoopIteration:						; Finish loop
		  
		  inc edx			; Increment j
		  cmp edx, ecx		; If j < i, loop inner
		  jl InnerLoop

							; j !< i, done with Inner Loop
	  inc ecx
	  cmp ecx, n			; If i < n, loop outer

	  jl OuterLoop
							; i !< n, done with outer loop.
		
							

		mov ebx, SIZEOF DWORD
	  ; for(i = 0; i < n; i++)
	  mov ecx, 0				; i = 0
	  LoopMaximum:			; Pick maximum of all LIS values
		
		  lea edx, [edi+ecx*4]
		  cmp max, edx			; if(max < lisArr[i])
		  jl MaxLLisArri		; (max < lisArr[i]) == true
		  jmp LoopMaximumIteration	; Else, finish loop

	  MaxLLisArri:
		lea edx, [edi+ecx*4]
		mov max, edx		; max = lisArr[i]
	  
	  LoopMaximumIteration:	; Done with iteration
		  inc ecx				; Increment i
		  cmp ecx, n			; If i < n, loop
		  jl LoopMaximum

Done:
	mov eax, max
	mov max_ref, eax
	ret
LongestIncreasingSeq ENDP



END Main
TITLE Lab9 Fibonacci Test (Lab9FibTest.asm)

INCLUDE C:\Irvine\Irvine32.inc


mPrintInt MACRO int
	push eax
	mov eax, int
	call WriteInt
	pop eax
ENDM

mPrintFlags MACRO
	push eax
	lahf
	movzx eax, ah
	call WriteBin
	call Crlf
	pop eax
ENDM

.data

saveFlags BYTE ?
	

.code

Main PROC

mov ecx, 50
call FibCalc



call Crlf
mPrintInt edx
mPrintInt eax
call Crlf


exit
Main ENDP

FibCalc PROC uses ebx esi,
	; ecx holds the number

	;	fib(1) = 0:1 in edx:eax
	mov eax, 1		; n - 1
	mov edx, 0		; n - 2
	

	;	fib(1) and fib(2) both equal 1
	cmp ecx, 2		; if ecx is 1 or 2
	jle done		; then return 1 in edx:eax

	; subtract one from ecx because fib(1) and fib(2) are already calculated
	sub ecx, 2		
	
	; previous value stored in esi:ebx
	mov ebx, 1		; esi:ebx store previous value
	mov esi, 0		 
	
	top:
		jc overflow		; if carry flag set, we overflowed
		adc ebx, eax    
		adc esi, edx 
		xchg eax, ebx	
		xchg edx, esi	; swap esi:ebx and edx:eax
		mPrintFlags

	loop top

jmp done

overflow:
	mov eax, 0
	mov edx, 0
	jmp done

done:
	ret

FibCalc ENDP

END Main

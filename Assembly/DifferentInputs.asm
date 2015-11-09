TITLE Different Inputs (DifferentInputs.asm)

INCLUDE C:/Irvine/Irvine32.inc

.data

	test1 DWORD 34234
	test2 DWORD 12
	test3 DWORD 99999999

	DifferentInputs PROTO, var1: DWORD, var2: DWORD, var3: DWORD

.code

main PROC
		
	INVOKE DifferentInputs, test1, test2, test3
	call DumpRegs
	
main ENDP

DifferentInputs PROC USES edx ecx,
	var1: DWORD,
	var2: DWORD,
	var3: DWORD

	mov edx, var1
	
	cmp edx, var2
	je Var1EqVar2
	mov eax, 1
	ret

	Var1EqVar2:
	cmp edx, var3
	je AllEqual
	mov eax, 1
	ret
	
	AllEqual:
	mov eax, 0
	ret

DifferentInputs ENDP

END main
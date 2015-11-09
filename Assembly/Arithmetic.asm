
;Robert Howerton
;09/24/2015
;Assembly program to emulate equation -(x+y-2z+1)


TITLE ASM Equation						(Arithmetic.asm)
INCLUDE C:/Irvine/Irvine32.inc



.data
xVar DWORD 5        ; xVar variable initialized with value 5
yVar DWORD 9        ; yVar variable initialized with value 9
zVar DWORD 3        ; zVar variable initialized with value 3
two DWORD 2            ; two variable initialized with value 2, used for later calculations
tempVar DWORD ?        ; tempVar variable uninitialized, used when moving the results of sub-parts around

.code

main_eqn PROC

       mov eax, xVar
	   add eax, yVar
	   sub eax, zVar
	   sub eax, zVar
	   inc eax
        neg eax                ; negate eax stack. eax stack now = -7 (hex DWORD = FFFFFFF9)
        call DumpRegs		   ; dump registers to console
        exit                   ; exit program (prevent Assembly.exe crash error)

main_eqn ENDP                  ; end process

END main_eqn                   ; end file

/*

  EAX=FFFFFFF9  EBX=7EFDE000  ECX=00000000  EDX=00000000
  ESI=00000000  EDI=00000000  EBP=003FFA2C  ESP=003FFA24
  EIP=0122340B  EFL=00000297  CF=1  SF=1  ZF=0  OF=0  AF=1  PF=1

Press any key to continue . . .

*/


INCLUDE C:\Irvine\Irvine32.inc


.data

upperBound DWORD 7Ah
lowerBound DWORD 61h


.code

BetterRandomRange PROC            ;\

    mov eax, upperBound            ; eax = 100
    sub eax, lowerBound            ; 100-(-300)
    add eax, 1                    ; 100-(-300)+1
    
    call RandomRange            ; RandomRange from - to  100-(-300)+1

    mov ebx, lowerBound
    add eax, ebx
    ret

exit
BetterRandomRange ENDP
END BetterRandomRange
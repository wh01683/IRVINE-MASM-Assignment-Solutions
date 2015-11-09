INCLUDE C:/Irvine/Irvine32.inc

.data
op1 BYTE 12h, 23h, 34h, 45h, 56h, 67h, 78h, 89h, 90h, 01h
op2 BYTE 34h, 45h, 56h, 67h, 78h, 89h, 90h, 01h, 23h, 34h, 40h
 
result BYTE 11 DUP(0)

.code 
main PROC ;calls the proc
    call Clrscr ; clear screen
    mov esi, OFFSET op1 ; operand 1
    mov edi, OFFSET op2 ; operand 2
    mov ebx, OFFSET result ; the result
    mov ecx, LENGTHOF op1 ; which is 10 bytes
    call Extended_Sub
    mov esi, OFFSET result
    mov ecx, LENGTHOF result
    call Display_Result
    exit
    main ENDP
Extended_Sub PROC ; Subtracts the 2 operands
    pushad 
    clc
    L1:
        mov al, [esi] ; op1 -> al
        sbb al, [edi] ; sub op2 from al
        pushfd
        mov [ebx],al ;start storing result
        add esi, 1
        add edi, 1
        add ebx, 1
        popfd
        loop L1 ; loop
        mov BYTE PTR[ebx],0 ;clear the highest byte of result
        sbb BYTE PTR[ebx],0 ; Subtract carry
        popad
        ret
Extended_Sub ENDP
    Display_Result PROC
        pushad
        add esi, ecx ; point to last element of the result
        sub esi, TYPE BYTE
        mov ebx, TYPE BYTE
        L1:
        mov al, [esi] ; result -> AL
        call WriteHex ; write the hexadecimal digit
        sub esi, TYPE BYTE
        loop L1; loop
        popad
        ret
Display_Result ENDP
END main

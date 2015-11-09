INCLUDE C:/Irvine/Irvine32.inc

BUFMAX = 128 
.data
    strText BYTE "Enter the plain text:", 0
    strEnc BYTE "The encrypted text is:", 0
    buffer BYTE BUFMAX+1 DUP (0)
    bufSize DWORD ?
    key SBYTE -2, 4, 1, 0, -3, 5, 2, -4, -4, 6
    
    keySize DWORD 10 
.code
main PROC
    call Clrscr
    mov ecx, 2
    L1:
    call InputPlainText
    call CovertText
    call DisplayText
    loop L1
    exit
    main ENDP

    InputPlainText PROC USES ecx edx
    mov edx, OFFSET strText
    call WriteString
    call Crlf
    mov ecx, BUFMAX
    mov edx, OFFSET buffer
    call ReadString
    mov bufSize, eax
    call Crlf
    ret
    InputPlainText ENDP

    CovertText PROC USES esi ecx edx
    mov ecx, bufSize
    mov edx,0
    mov esi,0
    Label1:
    cmp key[edx],0
    jl Label2
    shr buffer[esi], key[edx]
    inc esi
    inc edx
    jmp Label3
    Label2:
    shl buffer[esi], key[edx]
    inc esi
    inc edx
    Label3:
    cmp edx, keySize
    jne Label1
    mov edx,0
    loop Label1
    ret
    ConvertText ENDP

    DisplayText PROC USES edx
    mov edx, OFFSET strEnc
    call WriteString
    mov edx, OFFSET buffer
    call WriteString
    call Crlf
    call Crlf
    ret
    DisplayText ENDP
END main
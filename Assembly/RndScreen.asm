 INCLUDE C:\Irvine\Irvine32.inc

.data

maxX BYTE ?
maxY BYTE ?
randX BYTE ?
randY BYTE ?


lowerChar BYTE 97
upperChar BYTE 122

.code

main PROC

call Randomize
mov ecx, 100

L1:
	
	call GetMaxXY

	movzx ebx, dx
	mov maxX, bl
	movzx ebx, ax
	mov maxY, bl

	mov al, maxX
	call RandomRange
	mov dl, al

	mov al, maxY
	call RandomRange
	mov dh, al

	call Gotoxy

	mov al, upperChar            
	sub al, lowerChar            
	add al, 1                    
    call RandomRange
	add al, lowerChar
	
	call WriteChar
	
	mov eax, 100
	call Delay

	Loop L1


exit
main ENDP
END main



 INCLUDE C:\Irvine\Irvine32.inc

.data

temp DWORD 16
tempColor DWORD 16

.code

main PROC

           mov ecx, 0	; starting outer loop (Loop 1) at 0
OuterLoop:

           cmp ecx, 15	; Loop1 iterates between 0 and 15, compares counter to 15.
           je done		; jumps to :done: when ecx contents hit 15
           mov ebx, 0	; start inner loop at 0

InnerLoop:
           mov eax, ecx	; get counter from outer loop, store in eax (for SetTextColor)
		   mov edx, 16  ; multiply by 1
		   mul edx
		   add eax, ebx ; add counter from inner loop

		   call SetTextColor	; sets text color

		   mov al, 'A'		; moves A to al for writing
		   call WriteChar	; just writes A

           cmp ebx, 15	 ; compares current counter to 15
           je InnerLoopComplete	; jump out if loop is finished
           inc ebx		 ; increment inner loop counter
           jmp InnerLoop ; starts over

InnerLoopComplete:	; End of inner loop

		   call Crlf ; makes new line at the end of each inner loop
           inc ecx	; increment outer loop counter
           jmp OuterLoop ; goes back to beginning of OuterLoop
done:

exit
main ENDP
END main
TITLE Drunkard's Walk With Probabilities (ProbablyDrunkWalk.asm)

INCLUDE C:\Irvine\Irvine32.inc


WalkMax = 256
StartX = 256
StartY = 256

DrunkardWalk STRUCT
	path		COORD WalkMax DUP(<0,0>) ; Making array of coordinates initialized at 0,0.
	pathsUsed	WORD 0					 ; How many steps taken by the professor at loop end
DrunkardWalk ENDS

.data
	aWalk DrunkardWalk <>				; Create one DrunkardWalk initialized with default values
	DisplayPosition PROTO  currX:WORD, currY:WORD
	GetDirection PROTO currDir:WORD
	smiley BYTE 01h

.code

Main PROC

	call Randomize
	mov esi, OFFSET aWalk
	call TakeDrunkenWalk
	mov dh, 0
	mov dl, 0
	call Gotoxy
exit
Main ENDP


;-------------------------------------------------------------
TakeDrunkenWalk PROC
LOCAL currX: WORD, currY: WORD, currDir: WORD
;
;	Take a walk in random directions (north, south, east, west).
;	Receives: ESI Points to a DrunkardWalk structure
;	Returns:  Structure is initialized with random values
;-------------------------------------------------------------

pushad

;	Use the OFFSET operator to obtain the address of path,
;	the array of COORD objects, and copy it into edi

	mov edi, esi
	add edi, OFFSET DrunkardWalk.path	; Add array of coords in DrunkardWalk to edi
	mov ecx, WalkMax					; How many steps the professor will take
	mov currX, StartX					; Current X location
	mov currY, StartY					; Current Y location
	mov currDir, 0					

Again:								; Start of our walking loop
	
	; Insert current X in array
		mov ax, currX
		mov (COORD PTR [edi]).X, ax
	; Insert current Y in array
		mov ax, currY
		mov (COORD PTR [edi]).Y, ax


	INVOKE GetDirection, currDir

	INVOKE DisplayPosition, currX, currY
	mov currDir, bx		; Replace current direction with new direction
	mov eax, ebx		; place into eax for movement decision
	
	.IF eax == 0
		dec currY
	.ELSEIF eax == 1
		inc currY
	.ELSEIF eax == 2
		dec currX
	.ELSE
		inc currX
	.ENDIF

	add edi, TYPE COORD	   ; Point to the next coordinate in DrunkardWalk
	loop Again

Finish:
	mov	(DrunkardWalk PTR [esi]).pathsUsed, WalkMax	; Since we're done, we walked the entire path
	popad
	ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD
;	Display the current X and Y positions.
;-------------------------------------------------------------

.data

	commaStr BYTE ",",0

.code
	
	pushad


	; Write coordinates to console
	;	movzx eax, currX
	;	call WriteDec
	;	mov edx, OFFSET commaStr
	;	call WriteString
	;	movzx eax, currY
	;	call WriteDec
	;	call Crlf
	; End Write Coordinates

	; Write smiley to console at current position
	mov dx, currY	; put current Y into DX
	shl dx, 8		; shift current Y into DH
	add dx, currX	; add current X to DX (which will end up in DL)
	call Gotoxy		; Move cursor
	mov al, smiley	; Write smiley char
	call WriteChar	
	not al			; Inverses AL (used for visualizing sequential steps)
	mov smiley, al	; replace smiley

	popad
	ret

DisplayPosition ENDP

GetDirection PROC USES eax, 
			 currDir: WORD

	mov eax, 100
	call RandomRange

	.IF eax > 50
		movzx ebx, currDir		; Same direction
	.ELSEIF eax > 30			; Move left with 20% probability
		.IF (currDir == 2) || (currDir == 3)
			mov ebx, 2
		.ELSE
			mov ebx, 0
		.ENDIF
	.ELSEIF eax > 10			; Move right with 20% probability
		.IF (currDir == 1) || (currDir == 0)
			mov ebx, 3
		.ELSE
			mov ebx, 1
		.ENDIF
	.ELSE						; Reverse with 10% probability
		.IF currDir == 0
			mov ebx, 1
		.ELSEIF currDir == 1
			mov ebx, 0
		.ELSEIF currDir == 2
			mov ebx, 3
		.ELSE
			mov ebx, 4
		.ENDIF
	.ENDIF

	ret

GetDirection ENDP

END Main
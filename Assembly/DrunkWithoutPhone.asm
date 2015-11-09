TITLE Drunkard's Walk With Probabilities (ProbablyDrunkWalk.asm)

INCLUDE C:\Irvine\Irvine32.inc


WalkMax = 50
StartX = 50
StartY = 50

DrunkardWalk STRUCT
	path		COORD WalkMax DUP(<0,0>) ; Making array of coordinates initialized at 0,0.
	pathsUsed	WORD 0					 ; How many steps taken by the professor at loop end
DrunkardWalk ENDS

.data
	aWalk DrunkardWalk <>				; Create one DrunkardWalk initialized with default values
	DisplayPosition PROTO  currX:WORD, currY:WORD, currStep:WORD
	GetDirection PROTO currDir:WORD
	phoneDropInterval WORD ?

.code

Main PROC
	
	
	call Randomize
	
	mov eax, WalkMax
	call RandomRange
	mov phoneDropInterval, ax
	
	mov esi, OFFSET aWalk
	call TakeDrunkenWalk
exit
Main ENDP


;-------------------------------------------------------------
TakeDrunkenWalk PROC
LOCAL currX: WORD, currY: WORD, currDir: WORD, currSteps: WORD
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
	mov currSteps, 0

Again:								; Start of our walking loop
	
	; Insert current X in array
	mov ax, currX
	mov (COORD PTR [edi]).X, ax
	; Insert current Y in array
	mov ax, currY
	mov (COORD PTR [edi]).Y, ax


	INVOKE GetDirection, currDir

	INVOKE DisplayPosition, currX, currY, currSteps
	mov currDir, bx		; Replace current direction with new direction

	mov eax, ebx
	
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
	inc currSteps
	loop Again

Finish:
	mov	(DrunkardWalk PTR [esi]).pathsUsed, WalkMax	; Since we're done, we walked the entire path
	popad
	ret
TakeDrunkenWalk ENDP

;-------------------------------------------------------------
DisplayPosition PROC currX:WORD, currY:WORD, currStep:WORD
;	Display the current X and Y positions.
;-------------------------------------------------------------

.data

	commaStr BYTE ",",0
	phoneDropped BYTE " Phone dropped here!!", 0

.code
	
	pushad
	movzx ebx, currStep
	; Write coordinates to console
		movzx eax, currX
		call WriteDec
		mov edx, OFFSET commaStr
		call WriteString
		movzx eax, currY
		call WriteDec
	.IF phoneDropInterval == bx
		mov edx, OFFSET phoneDropped
		call WriteString
	.ENDIF
		call Crlf
	; End Write Coordinates
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
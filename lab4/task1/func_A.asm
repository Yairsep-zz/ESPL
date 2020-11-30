section .text
	global funcA
	
funcA:
	push	ebp ;starting function convention
	mov	ebp, esp
	mov	eax,-1
    push ebx

.L2:
	add eax, 1
	mov ebx, eax
	add ebx, [ebp+8] ;load argument
	movzx	ebx, BYTE [ebx] ;load byte by byte (completes zero)
	test bl,bl ;check that i got to the end of the string
	jne .L2 ;jump if not equal (continue looping)
    pop ebx 
	mov esp, ebp ;exiting convention
	pop ebp
	ret
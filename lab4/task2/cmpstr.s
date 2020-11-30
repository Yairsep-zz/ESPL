section .text
	global cmpstr
	
cmpstr:
	push ebp ;staring convention
	mov	ebp, esp
	push ebx ;using this register to load bytes
	push ecx ;using this register to load bytes
	push esi ;string registers
	push edi ;string registers
	mov esi, [ebp+8] ;take first argument
	mov edi, [ebp+12] ;take second argument

    
.loop:
	movzx	ecx, BYTE [edi] ;loading byte by byte
	movzx	ebx, BYTE [esi]	;loading byte by byte

	cmp ebx,ecx ;comparing between them
	jg .ifGreater ;if greater than
	jl .ifLess	; if less then
	
	test ebx, ebx ;if i got to end
	jz .ifEquals

	inc esi ;esi++
	inc edi ;edi++
	jmp .loop ;continue looping
	

.ifGreater:
	mov eax, 1
	jmp .exit

.ifLess:
	mov eax, 2
	jmp .exit

.ifEquals:
	mov eax, 0
	jmp .exit

.exit:
	pop edi ;poping all registers
	pop esi
	pop ecx
	pop ebx
	mov esp, ebp ;returning convention
	pop ebp
	ret

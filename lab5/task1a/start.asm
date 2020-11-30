section .text
	global _start
	global read
	global write
	global open
	global close
	global strlen
	extern main
	
_start:

	mov eax, [esp] ;eax = argc
	lea edx , [esp+4] ;edx = argv, lead loads a pointer to the item, like you get a pointer in c

	push edx 
	push eax
	
	call main ;call main with argu
	mov ebx,eax
	mov eax,1
	int 0x80

read:

	push ebp ;save caller
	mov ebp, esp

	push ebx ;push registers
	push ecx
	push edx

	mov eax,3 ;system read number
	mov ebx,[ebp+8] ;file descriptor
	mov ecx,[ebp+12] ;buffer
	mov edx,[ebp+16] ;size

	int 0x80 ;oprating system

	pop edx ;pop registers
	pop ecx
	pop ebx

	mov esp, ebp ;exit convention
	pop ebp
	ret

write:

	push ebp
	mov ebp, esp

	push ebx
	push ecx
	push edx

	mov eax,4 ;system write num
	mov ebx,[ebp+8] ;file descriptor
	mov ecx,[ebp+12] ;buffer
	mov edx,[ebp+16] ;size

	int 0x80 ;oprating system

	pop edx ;pop registers
	pop ecx
	pop ebx

	mov esp, ebp ;
	pop ebp
	ret

open:

	push ebp
	mov ebp, esp

	push ebx
	push ecx

	mov eax,5 ;system open call
	mov ebx,[ebp+8] ;string argument
	mov ecx,[ebp+12] ;flag argument

	int 0x80

	pop ecx
	pop ebx

	mov esp, ebp
	pop ebp 
	ret

close:

	push ebp
	mov ebp, esp

	push ebx

	mov eax,6 ;system close call
	mov ebx,[ebp+8] ;flag

	int 0x80

	pop ebx

	mov esp, ebp
	pop ebp
	ret

strlen: ;like lab4

	push ebp
	mov ebp, esp	
	mov eax,-1

.strlen_Loop:

	add eax, 1
	mov ebx, eax
	add ebx, [ebp+8]
	movzx ebx, BYTE [ebx]
	test bl,bl
	jne .strlen_Loop
	pop ebx
	mov esp, ebp
	pop ebp
	ret
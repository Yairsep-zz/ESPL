section .bss
	buffer: resb 50
    arr: resb 16

section .text
	global _start
	global read
	global write
	global open
	global close
	global utoa
	global strlen
	
	
_start:

	push ebp 
	mov ebp, esp

	push dword[ebp+12] ;name of file
	call open
	
	mov edi, eax ;store the fd of the file in edi
	jmp main_loop

main_loop:

	push 50 ;3rd argument for read (size of buffer)
	push buffer ;2nd argument for read (the buffer itself)
	push edi ;1st argument for read (fd)
	call read
	
	mov ecx, eax ;store number of bytes read

	push ecx ;3rd argument for write (size of buffer)
	push buffer ;2nd argument for write (the buffer itself)
	push 1	;1st argument for write (stdout)

	call write
	
	cmp ecx, 50 ;compare if the buffer is full
	je main_loop
	jmp exit_main_loop
	

exit_main_loop:

	push edi ; push fd
	call close
	mov esp, ebp

	pop ebp
	mov eax, 1 ;exit system call
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

utoa_s:

	push ebp
	mov ebp, esp

	sub esp , 8 ;make space for local variables
	pushad ;push all registers

	mov ecx, arr ;ebx = arr

	mov eax,[ebp+8] ;eax = int atgument
	mov byte [ecx+15] , 0 ;end of the string
	mov dword [ebp-8], 0xF ;intiating counter

	cmp eax , 0 ;if eax = 0
	je finish

utoa_loop:

	mov edx , 0 ;clean the register
	mov ecx , 10 ;set ebx value to 10
	div ecx 	; eax = eax / ebx
	mov [ebp-4] , edx ; [ebp-4] = edx - stores the reminder
	add dword [ebp-4] , 0x30  ;converts result to ascii
	mov edx , [ebp-4] ;edx = ascii value

	dec dword [ebp-8] ;counter--
	mov ecx , [ebp-8]  ;ecx = counter

	add ecx , arr ;ecx = arr[counter]
	mov [ecx] , dl ; arr[counter] = dl

	cmp eax , 0 ;if i==0
	jne utoa_loop

finish:
	mov edx , dword[ebp-8] ;edx = counter value
	add edx, arr 	;ecx = array
	mov [ebp-4] , edx ;local var = potr

	popad

	mov eax, [ebp-4] ;return value

	add esp , 8 ;returning stack pointer to the place
	pop ebp
	ret


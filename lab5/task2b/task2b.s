section .data
	new_Line: db 10, 0
	message:    db " Chars in the file" , 0 ;input string + end of it
	error_msg:    db "Invalid input" , 0 ,10
	error_len equ $-error_msg

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
	extern printf
	
_start:

	push ebp 
	mov ebp, esp
	
	mov ecx, 1
	add ecx, [ebp+12] ;argument

	movzx ecx, BYTE [ecx] ;move byte
	
	cmp ecx, 2 ;if no flag
	je if_noFLag

	cmp ecx, 'c' ;if -c falg
	je if_c_flag
	; jne if_error
	
if_noFLag:

	push 0 ;flag argument - 0 read
	push dword[ebp+12] ;file name argument
	call open
	
	mov edi, eax ;edi = file discriptor
	jmp if_noFLag_loop
	
if_c_flag:

	push 0 ;flag argument - 0 read
	push dword[ebp+16] ;file name argument argv[2]
	call open
	
	mov edi, eax ;store the fd of the file in esi
	jmp c_flag_loop

if_error:

	mov edx , error_len
	mov ecx , error_msg
	mov ebx , 1
	mov eax , 4
	int 0x80

if_noFLag_loop:
	push 50 ;size argument
	push buffer ;buffer argument
	push edi ;fd argument
	call read
	
	mov edx, eax ;num of bytes to read

	push edx ;size argument
	push buffer ;buffer argument
	push 1	;fd argument -
	call write
	
	cmp edx, 50 ;compare & check if the buffer is full
	je if_noFLag_loop
	jmp if_noFLag_exit
	
c_flag_loop:

	push 50 ;size argument
	push buffer ;buffer argument
	push edi ;fd argument -
	call read
	
	mov edx, eax ;num of bytes read func, read
	add [ebp-4], edx ;sum the num of bytes
	
	cmp edx, 50 ;compare & check if the buffer is full
	je c_flag_loop
	jmp c_flag_exit
	

if_noFLag_exit:

	push edi ;fd argument
	call close

	mov esp, ebp ;close convention
	pop ebp
	mov eax, 1 ;exit system call
	int 0x80
	
c_flag_exit:

	mov eax, [ebp-4] ;eax = sum
	push eax 
	call utoa ;cast int to string
	mov esi, eax ; esi = eax
	
	push esi
	call strlen ;len(esi)

	mov ebx, eax ;ebx = strlen
	
	push ebx ;size argument
	push esi ;buffer argument
	push 1 ;fd argument
	call write

	push message
	call printf

	push new_Line
	call printf
	
	push esi ;fd arg
	call close

	mov esp, ebp ;closing convention
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

utoa:

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


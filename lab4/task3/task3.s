section .data
	input:    db "Yair loves assembly" , 0 ;input string + end of it
	output:    times $-input db 0 ,10 ;initiate an array for output string 

section .text
	global _start
	extern printf ;importing external printf function

	
_start:
	push ebp ;starting function convention
	mov	ebp, esp
	push esi ;string regeister
	push edi ;string regeister
	mov esi, input ;loacating input to esi
	mov edi, output ;locating output to edi


.loop: ;looping over input string
	
	movzx ebx, BYTE [esi] ;loading byte by byte
	inc esi ;i++
	test ebx, ebx ;check if we are in the end of the stirng
	jnz .loop ;if not continue looping
	dec esi ;pointer to the end of input string


.reverse: ;loads input string backwords 

	dec esi 
	mov	bl, BYTE [esi] ;becuase cant do mov [edi] [esi]
	mov [edi],BYTE bl ;load byte by byte
	inc edi ;i++
	cmp esi, input ;check if we came back to begining of input 
	jnz .reverse ;if not continue looping
	

.print: ;using external print function
	push output 
	call printf
	add esp, 8 ;return stack pointer
	
.exit:
	pop edi
	pop esi
	mov esp, ebp
	pop ebp
	mov eax,4
	int 0x80
	mov eax,1
	int 0x80

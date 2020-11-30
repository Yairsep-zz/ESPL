all: main

main: main.o func_A.o
	gcc -m32 -o main main.o func_A.o
	rm main.o func_A.o

main.o: main.c
	gcc -m32 -c -o main.o main.c

func_A.o: func_A.asm
	nasm -f elf func_A.asm

clean:
	rm -rf ./*.o main

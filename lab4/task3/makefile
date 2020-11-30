all: main

main: task3.o
	ld -melf_i386 -o main task3.o -lc -I/lib/ld-linux.so.2
	rm -f task3.o

task3.o: task3.s
	nasm -g -f elf -w+all -o task3.o task3.s
	
.PHONY: clean

clean:
	rm -f *.o main
	


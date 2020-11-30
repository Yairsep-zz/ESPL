all: task2b

task2b: task2b.o 
	ld -melf_i386 -o task2b task2b.o -lc -I/lib/ld-linux.so.2
	rm -f task2b.o

task2b.o: task2b.s
	nasm -g -f elf -w+all -o task2b.o task2b.s
	
.PHONY: clean

clean:
	rm -f *.o task2b

	

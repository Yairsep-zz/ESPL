all: task2a

task2a: task2a.o
	ld -melf_i386 -o task2a task2a.o -lc -I/lib/ld-linux.so.2
	rm -f task2a.o

task2a.o: task2a.s
	nasm -g -f elf -w+all -o task2a.o task2a.s
	
.PHONY: clean

clean:
	rm -f *.o task2a
	

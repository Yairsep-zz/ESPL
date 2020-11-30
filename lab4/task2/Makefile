.PHONY: all clean

all: scmp

scmp: scmp.o cmpstr_c.o cmpstr.o
	gcc -m32 -o scmp scmp.o cmpstr_c.o cmpstr.o
	rm scmp.o cmpstr_c.o cmpstr.o

scmp.o: scmp.c
	gcc -m32 -c -o scmp.o scmp.c

cmpstr_c.o: cmpstr_c.c
	gcc -m32 -g -Wall -ansi -c -o cmpstr_c.o cmpstr_c.c

cmpstr.o: cmpstr.s
	nasm -f elf cmpstr.s
	
clean:
	rm -rf *.o scmp
all: clean bcmp

bcmp: task1b.o
	gcc -m32 -g -Wall -o bcmp task1b.o
	rm task1b.o

task1b.o: task1b.c
	gcc -g -Wall -m32 -ansi -c -o task1b.o task1b.c

.PHONY: clean

clean:
	rm -f *.o bcmp
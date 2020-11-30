all: clean char2ascii

char2ascii: task1b.o
	gcc -m32 -g -Wall -o char2ascii task1b.o

task1b.o: task1b.c
	gcc -g -Wall -m32 -ansi -c -o task1b.o task1b.c

.PHONY: clean

clean:
	rm -f *.o char2ascii
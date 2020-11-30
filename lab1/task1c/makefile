all: clean char2ascii

char2ascii: task1c.o
	gcc -m32 -g -Wall -o char2ascii task1c.o

task1c.o: task1c.c
	gcc -g -Wall -m32 -ansi -c -o task1c.o task1c.c

.PHONY: clean

clean:
	rm -f *.o char2ascii

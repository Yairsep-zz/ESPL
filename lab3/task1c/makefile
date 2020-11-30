all: clean bcmp

bcmp: task1c.o
	gcc -m32 -g -Wall -o bcmp task1c.o
	rm task1c.o

task1c.o: task1c.c
	gcc -g -Wall -m32 -ansi -c -o task1c.o task1c.c

.PHONY: clean

clean:
	rm -f *.o bcmp
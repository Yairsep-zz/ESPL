all: clean bcmp

bcmp: task1a.o
	gcc -m32 -g -Wall -o bcmp task1a.o
	rm task1a.o

task1a.o: task1a.c
	gcc -g -Wall -m32 -ansi -c -o task1a.o task1a.c

.PHONY: clean

clean:
	rm -f *.o bcmp
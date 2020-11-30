all: clean bcmp

bcmp: task2.o
	gcc -m32 -g -Wall -o bcmp task2.o
	rm task2.o

task2.o: task2.c
	gcc -g -Wall -m32 -ansi -c -o task2.o task2.c

.PHONY: clean

clean:
	rm -f *.o bcmp
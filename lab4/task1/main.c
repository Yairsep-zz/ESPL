#include <stdlib.h>
#include <stdio.h>
#include <string.h>

extern int funcA(char * input);

int main(int argc, char **argv) {
  char * c ="hello world!";
  int i;
  FILE * output=stdout;
  i = funcA(c);
  fprintf(output , "%d\n" , i);
  return 0;
}

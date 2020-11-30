#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char **argv)
{
    FILE *output = stdout;
    if (strcmp(argv[1], "-b") == 0)
    {
        FILE *input = stdin;
        unsigned char c;

        int y[8];
        int i;
        while ((c = fgetc(input)) != EOF)
        {
            if (c != 10)
            {
                for (i = 0; i < 8; i++)
                {
                    y[7 - i] = c & 1;
                    c = c >> 1;
                }
                for (i = 0; i < 8; i++)
                {
                    fprintf(output, "%d", y[i]);
                }
                fprintf(output, "\n");
            }
        }
    }
    return 1;
}

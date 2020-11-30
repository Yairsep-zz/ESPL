#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct diff {
    long offset; /* offset of the difference in file starting from zero*/
    unsigned char orig_value;     /* value of the byte in ORIG */
    unsigned char new_value;     /* value of the byte in NEW */
} diff;

typedef struct node node;

struct node {
    diff *diff_data; /* pointer to a struct containing the offset and the value of the bytes in each of the files*/
    node *next;
};

void list_print(node *diff_list,FILE* output);
/* Print the nodes in diff_list in the following format: byte POSITION ORIG_VALUE NEW_VALUE.
Each item followed by a newline character. */
void list_print(node *diff_list,FILE* output){

    node *curr = diff_list;
    if (curr == NULL){
        return;
    }
    if (curr->next != NULL){
        list_print(curr->next , output);
    }
    long offset = curr->diff_data->offset;
    fprintf(output , "byte %ld %02x %02x\n" , offset , curr->diff_data->orig_value , curr->diff_data->new_value);
}


void list_free(node *diff_list); /* Free the memory allocated by and for the list. */

void list_free(node *diff_list){

    node *curr;
    while (diff_list != NULL){
        curr = diff_list;
        diff_list = diff_list->next;
        free(curr->diff_data);
        free(curr);
    }
}

node* list_append(node* diff_list, diff* data);
/* Add a new node with the given data to the list,
   and return a pointer to the list (i.e., the first node in the list).
   If the list is null - create a new entry and return a pointer to the entry.*/
node* list_append(node* diff_list, diff* data){

    node *new_head = (struct node*) malloc(sizeof(struct node));
    new_head->diff_data = data;
    if (diff_list == NULL){
        new_head->next = NULL;
    }
    else {
        new_head->next = diff_list;
    }
    return new_head;
}

void restore (FILE* file , node* diff_list){

    node* curr = diff_list;
    long offset;
    while (curr !=NULL){
        offset = curr->diff_data->offset;
        unsigned char c;
        c = curr->diff_data->orig_value;
        fseek(file , offset , SEEK_SET);
        fwrite(&c , 1 , 1 ,file);
        curr = curr->next;
    }

}

int main(int argc , char **argv)
{
    FILE* output = stdout; FILE *orig; FILE *new;
    int restore_flag = 0;
    int print_total_flag = 0;
    long loc =0;
    int j;

    for (j = 1; j < argc; j++) {
        if (strcmp(argv[j], "-t") == 0) {
            print_total_flag = 1;
        }
        else if (strcmp(argv[j], "-r") == 0) {
            restore_flag = 1;
            if (argv[++j] != NULL){
                sscanf(argv[j], "%ld", &loc);
            }
        }
        else if (strcmp(argv[j], "-k") == 0) {
            sscanf(argv[++j], "%ld", &loc);
        }
        else if (strcmp(argv[j], "-o") == 0)
        {
            output = fopen(argv[++j], "w");
        }
        else {
            orig = fopen(argv[j], "rb");
            new =  fopen(argv[++j], "rb+");
        }

    }
    fseek(orig , 0 , SEEK_END);
    long len_orig = ftell(orig);
    fseek(orig , loc , SEEK_SET);

    fseek(new , 0 , SEEK_END);
    long len_new = ftell(new);
    fseek(new , loc , SEEK_SET);

    long size;
    if (len_orig >= len_new){
        size = len_orig;
    }
    else {
        size = len_new;
    }
    size = size;
    unsigned char c1; unsigned char c2;
    node *diff_list = NULL;
    int count =0; int i;
    for (i = loc ; i < size ; i++){
        fread(&c1 , 1 , 1 , orig);
        fread(&c2 , 1 , 1 , new);
        if (c1 != c2){
            diff * diff_data = malloc(sizeof(diff));
            diff_data->offset = i;
            diff_data->orig_value = c1;
            diff_data->new_value = c2;
            diff_list = list_append(diff_list , diff_data);
            count++;
        }
    }
    if (restore_flag ==1){
        restore(new , diff_list);
    }

    if (print_total_flag == 1){
        fprintf(output , "%d\n" , count);
    }
    else {
        list_print(diff_list, output);
    }
    list_free(diff_list);
    fclose(output);
    fclose(orig);
    fclose(new);
    return 0;
}
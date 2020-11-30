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

int main()
{
    FILE *output = stdout;
    node *linked_list = NULL;

    struct diff *diffA = (struct diff*) malloc(sizeof(struct diff));
    struct diff *diffB = (struct diff*) malloc(sizeof(struct diff));

    diffA->offset =1; diffA->new_value = 'a'; diffA->orig_value='b';
    diffB->offset =2; diffB->new_value = 'c'; diffB->orig_value='d';

    linked_list = list_append(linked_list ,diffA);
    linked_list = list_append(linked_list ,diffB);

    list_print(linked_list , output);
    list_free(linked_list);
    fclose(output);
    return 0;
}
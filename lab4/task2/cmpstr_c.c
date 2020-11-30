

int cmpstr_c(char* a, char* b){

    int a_size = sizeof(a);
    int b_size = sizeof(b);

    int size;
    int is_Equal = 0;
    int output;
    if (a_size > b_size){
        size = a_size;
    }
    else {
        size = b_size;
    };

    int i;
    for (i = 0 ; i < size ; ++i){
        if (a[i] > b[i]){
            output = 1;
            is_Equal = 2;
            break;
        }
        else if (a[i] == b[i] && is_Equal == 0){
            is_Equal = 1;
        }
        else if (a[i] < b[i]){
            output = 2;
            is_Equal = 2;
            break;
        }
    }
    if (is_Equal ==1){
        return 0;
    }
    return output;
}
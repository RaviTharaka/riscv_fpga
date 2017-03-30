#include <stdio.h>

int main(int argc, char *argv[]){
    char *ptr = (char *)0x12345678; //the addr you wish to access the contents of
    printf("%c\n", *ptr); //this will give you the first byte, you can add any more bytes you need to the ptr itself, like so: *(ptr + nbyte).

//  Convert the integer value to an address.
    int *p = (int *) u;

    //  Modify the int through the new pointer.
    *p = 123;

    return 0;
}

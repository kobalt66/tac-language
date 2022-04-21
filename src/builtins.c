#include "include/builtins.h"
#include <stdio.h>
#include <string.h>

static char* mkstr(const char* str) {
    char* outstr = (char*)calloc(strlen(str) + 1, sizeof(char));
    strcpy(outstr, str);

    return outstr;
}

AST_T* fptr_print(visitor_T* visitor, AST_T* node, list_T* list) {
    AST_T* ast = init_ast(AST_STRING);

    const char* template = "movl $4, \%eax\n" // syscall write
                           "movl $1, \%ebx\n" // stdout
                           "movl $0, \%ecx\n" // buffer
                           "movl $0, \%edx\n" // size
                           "int $0x80\n";

    ast->string_value = mkstr(template);
    return ast;
}

void buildins_register_fptr(list_T* list, const char* name, AST_T* (*fptr)(visitor_T* visitor, AST_T* node, list_T* list)) {
    AST_T* fptr_print_var = init_ast(AST_VARIABLE);
    fptr_print_var->name = mkstr(name);
    fptr_print_var->fptr = fptr;

    list_push(list, fptr_print_var);
}

void builtins_init(list_T* list) {
    buildins_register_fptr(list, "print", fptr_print);
}
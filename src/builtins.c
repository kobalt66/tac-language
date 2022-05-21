#include "include/builtins.h"
#include "include/utils.h"
#include "include/as_frontend.h"
#include <stdio.h>
#include <string.h>


AST_T* fptr_print(visitor_T* visitor, AST_T* node, list_T* list) {
    return node;
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
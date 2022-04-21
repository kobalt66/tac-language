#include "include/builtins.h"
#include "include/utils.h"
#include <stdio.h>
#include <string.h>

static char* mkstr(const char* str) {
    char* outstr = (char*)calloc(strlen(str) + 1, sizeof(char));
    strcpy(outstr, str);

    return outstr;
}

AST_T* fptr_print(visitor_T* visitor, AST_T* node, list_T* list) {
    AST_T* ast = init_ast(AST_STRING);

    AST_T* first_arg = list->size ? (AST_T*)list->items[0] : (AST_T*)0;
    char* instr = calloc(128, sizeof(char));
    char* hexstr = 0;

    if (first_arg) {
        sprintf(instr, "%d", first_arg->int_value);
        hexstr = str_to_hex(instr);
    }

    const char* template = "movl $4, %%eax\n" // syscall write
                           "movl $1, %%ebx\n" // stdout
                           "pushl $0x%s\n"      // buffer
                           "movl %%esp, %%ecx\n" // buffer
                           "movl $%d, %%edx\n" // size
                           "int $0x80\n";

    char* asmb = calloc((hexstr ? strlen(hexstr) : 0) + strlen(template) + 1, sizeof(char));
    sprintf(asmb, template, hexstr ? hexstr : "$0", 8);
    ast->string_value = asmb;
    free(hexstr);

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
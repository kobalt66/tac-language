#ifndef TAC_AST_H
#define TAC_AST_H

#include "list.h"
#include "stack_frame.h"

struct VISITOR_STRUCT;

typedef struct AST_STRUCT {
    enum {
        AST_COMPOUND,
        AST_FUNCTION,
        AST_CALL,
        AST_INT,
        AST_STRING,
        AST_ASSIGNMENT,
        AST_DEFINITION_TYPE,
        AST_VARIABLE,
        AST_STATEMENT_RETURN,
        AST_ACCESS,
        AST_NOOP
    } type;

    list_T* children;
    char* name;
    char* string_value;
    struct AST_STRUCT* value;
    int int_value;
    int data_type;
    int id;
    unsigned int stack_idx;
    struct AST_STRUCT* (*fptr)(struct VISITOR_STRUCT* visitor, struct AST_STRUCT* node, list_T* list);
    stack_frame_T* stack;
} AST_T;

AST_T* init_ast(int type);

#endif
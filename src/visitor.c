#include "include/visitor.h"
#include "include/builtins.h"
#include <stdio.h>
#include <string.h>

static AST_T* var_lookup(list_T* list, const char* name) {
    for (int i = 0; i < list->size; i++) {
        AST_T* child_ast = (AST_T*)list->items[i];

        if (child_ast->type != AST_VARIABLE || !child_ast->name)
            continue;

        if (strcmp(child_ast->name, name) == 0)
            return child_ast;
    }

    return 0;
}

visitor_T* init_visitor() {
    visitor_T* visitor = calloc(1, sizeof(struct VISITOR_STRUCT));
    visitor->object = init_ast(AST_COMPOUND);

    builtins_init(visitor->object->children);

    return visitor;
}
AST_T* visitor_visit(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    switch (node->type) {
        case AST_COMPOUND:          return visitor_visit_compound(visitor, node, list, stack); break; 
        case AST_ASSIGNMENT:        return visitor_visit_assignment(visitor, node, list, stack); break;
        case AST_VARIABLE:          return visitor_visit_variable(visitor, node, list, stack); break;
        case AST_CALL:              return visitor_visit_call(visitor, node, list, stack); break;
        case AST_INT:               return visitor_visit_int(visitor, node, list, stack); break;
        case AST_STRING:            return visitor_visit_string(visitor, node, list, stack); break;
        case AST_ACCESS:            return visitor_visit_access(visitor, node, list, stack); break;
        case AST_FUNCTION:          return visitor_visit_function(visitor, node, list, stack); break;
        case AST_STATEMENT_RETURN:  return visitor_visit_statement_return(visitor, node, list, stack); break;
        default: { printf("[Visitor]: Don't know how to handle AST of type `%d`\n", node->type); exit(1); } break;
    }

    return node;
}

AST_T* visitor_visit_compound(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    AST_T* compound = init_ast(AST_COMPOUND);

    for (unsigned int i = 0; i < node->children->size; i++) {
        AST_T* x = visitor_visit(visitor, (AST_T*)node->children->items[i], list, stack);
        list_push(compound->children, x);
    }

    return compound;
}
AST_T* visitor_visit_assignment(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    AST_T* new_var = init_ast(AST_ASSIGNMENT);
    new_var->name = node->name;

    if (node->value)
        new_var->value = visitor_visit(visitor, node->value, list, stack);
    
    list_push(list, new_var);
    list_push(stack->stack, new_var->name);

    return new_var;
}
AST_T* visitor_visit_variable(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    int stack_idx = list_indexof_str(stack->stack, node->name) + 1;
    node->stack_idx = (int)stack_idx;

    return node;
}
AST_T* visitor_visit_call(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    AST_T* var = var_lookup(visitor->object->children, node->name);

    list_T* new_args = init_list(sizeof(struct AST_STRUCT*));

    for (unsigned int i = 0; i < node->value->children->size; i++) {
        list_push(new_args, visitor_visit(visitor, (AST_T*)node->value->children->items[i], list, stack));
    }

    if (var) {
        if (var->fptr) {
            return var->fptr(visitor, node, new_args);
        }
    }

    return node;
}
AST_T* visitor_visit_int(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    return node;
}
AST_T* visitor_visit_string(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    return node;
}
AST_T* visitor_visit_statement_return(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    AST_T* ast = init_ast(AST_STATEMENT_RETURN);
    ast->value = visitor_visit(visitor, node->value, list, stack);
    return ast;
}
AST_T* visitor_visit_access(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    int id = 0;
    for (unsigned int i = list->size; i > 0; i--) {
        if (strcmp(((AST_T*)list->items[i-1])->name, node->name) == 0) {
            id = i;
            break;
        }
    }

    node->id = id;
    return node;
}
AST_T* visitor_visit_function(visitor_T* visitor, AST_T* node, list_T* list, stack_frame_T* stack) {
    AST_T* func = init_ast(AST_FUNCTION);
    func->children = init_list(sizeof(struct AST_STRUCT*));
    func->value = visitor_visit(visitor, node->value, node->children, stack);

    stack_frame_T* new_stack = init_stack_frame();

    for (unsigned int i = 0; i < node->children->size; i++)
        list_push(func->children, (AST_T*)visitor_visit(visitor, (AST_T*)node->children->items[i], list, new_stack));

    func->value = visitor_visit(visitor, node->value, node->children, new_stack);

    return func;
}
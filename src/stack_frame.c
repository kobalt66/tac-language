#include "include/stack_frame.h"
#include "include/AST.h"

stack_frame_T* init_stack_frame() {
    stack_frame_T* stack = calloc(1, sizeof(struct STACK_FRAME_STRUCT));
    stack->stack = init_list(sizeof(char*));

    return stack;
}
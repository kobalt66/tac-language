#ifndef TAC_AS_FRONTEND_H
#define TAC_AS_FRONTEND_H

#include "AST.h"

char* as_f(AST_T* ast);

char* as_f_compound(AST_T* ast);
char* as_f_assignment(AST_T* ast);
char* as_f_call(AST_T* ast);
char* as_f_variable(AST_T* ast);
char* as_f_int(AST_T* ast);

#endif
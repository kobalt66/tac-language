.section .text
.globl _start
_start:
movl %esp, %ebp
call main
movl %eax, %ebx
movl $1, %eax
int $0x80

subl $4, %esp

.globl main
main:
pushl %ebp
movl %esp, %ebp
subl $4, %esp
subl $16, %esp

# Push string elements onto stack
movl $0x0, 8(%esp)
movl $0x0a6f, 4(%esp) 
movl $0x06c6c6568, 0(%esp) 
pushl 8(%esp)

# Call
call print
addl $4, %esp

# Return statement
pushl $0
jmp return_statement

print:
   pushl %ebp
   movl %esp, %ebp
   pushl 8(%esp)
   call strlen
   addl $4, %esp
   movl 8(%esp), %ecx
   movl %eax, %edx
   movl $4, %eax
   movl $1, %ebx

   movl %ebp, %esp
   popl %ebp
   int $0x80
   ret

return_statement:
   popl %eax
   movl %ebp, %esp
   popl %ebp
   ret

.type strlen, @function
strlen:
  pushl %ebp
  movl %esp, %ebp
  movl $0, %edi
  movl 8(%esp), %eax
  jmp strlenloop

strlenloop:
  movb (%eax, %edi, 1), %cl
  cmpb $0, %cl
  je strlenend
  addl $1, %edi
  jmp strlenloop

strlenend:
  movl %edi, %eax
  movl %ebp, %esp
  popl %ebp
  ret

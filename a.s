.section .text
.globl _start
_start:
movl %esp, %ebp
call main
movl %eax, %ebx
movl $1, %eax
int $0x80


.globl hello
hello:
pushl %ebp
movl %esp, %ebp
pushl 16(%esp)

# Call
call print
addl $4, %esp
pushl 12(%esp)

# Call
call print
addl $4, %esp

# Return statement
pushl $0
jmp return_statement


.globl main
main:
pushl %ebp
movl %esp, %ebp

# Push string elements onto stack
subl $20, %esp
movl $0x0, 16(%esp)
movl $0x0a, 12(%esp) 
movl $0x021646c72, 8(%esp) 
movl $0x06f77206f, 4(%esp) 
movl $0x06c6c6568, 0(%esp) 
pushl %esp

# Push string elements onto stack
subl $16, %esp
movl $0x0, 12(%esp)
movl $0x0a7920, 8(%esp) 
movl $0x0676e6974, 4(%esp) 
movl $0x06e697270, 0(%esp) 
pushl %esp
pushl 20(%esp)

# Push string elements onto stack
subl $12, %esp
movl $0x0, 8(%esp)
movl $0x021677261, 4(%esp) 
movl $0x020647233, 0(%esp) 
pushl %esp
pushl 36(%esp)

# Call
call hello
addl $12, %esp

# Push string elements onto stack
subl $24, %esp
movl $0x0, 20(%esp)
movl $0x0a, 16(%esp) 
movl $0x0216e6961, 12(%esp) 
movl $0x06d206d6f, 8(%esp) 
movl $0x07266206f, 4(%esp) 
movl $0x06c6c6548, 0(%esp) 
pushl %esp

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

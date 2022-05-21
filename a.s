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
subl $56, %esp

# Push string elements onto stack
movl $0x0, 48(%esp)
movl $0x0a7473, 44(%esp) 
movl $0x0616c2065, 40(%esp) 
movl $0x06874206e, 36(%esp) 
movl $0x061687420, 32(%esp) 
movl $0x07265676e, 28(%esp) 
movl $0x06f6c206e, 24(%esp) 
movl $0x065766520, 20(%esp) 
movl $0x073692067, 16(%esp) 
movl $0x06e697274, 12(%esp) 
movl $0x073207369, 8(%esp) 
movl $0x06874206f, 4(%esp) 
movl $0x06c6c6568, 0(%esp) 
subl $4, %esp
subl $56, %esp

# Push string elements onto stack
movl $0x0, 48(%esp)
movl $0x0a, 44(%esp) 
movl $0x027317261, 40(%esp) 
movl $0x076272065, 36(%esp) 
movl $0x06c626169, 32(%esp) 
movl $0x072617620, 28(%esp) 
movl $0x0666f2065, 24(%esp) 
movl $0x0756c6176, 20(%esp) 
movl $0x020676e69, 16(%esp) 
movl $0x072747320, 12(%esp) 
movl $0x065687420, 8(%esp) 
movl $0x074736920, 4(%esp) 
movl $0x073696874, 0(%esp) 
movl %esp, -8(%ebp)
pushl -8(%ebp)

# Call
call print
addl $4, %esp
movl %esp, -12(%ebp)
pushl -12(%ebp)

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

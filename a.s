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
pushl 8(%esp)

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
pushl $0x0
pushl $0x0a
pushl $0x021646c72
pushl $0x06f77206f
pushl $0x06c6c6568
pushl %esp
pushl $0x0
pushl $0x0a7920
pushl $0x0676e6974
pushl $0x06e697270
pushl %esp

# Call
call hello
addl $8, %esp
pushl $0x0
pushl $0x0a
pushl $0x0216e6961
pushl $0x06d206d6f
pushl $0x07266206f
pushl $0x06c6c6548
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

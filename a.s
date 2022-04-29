.section .text
.globl _start
_start:
movl %esp, %ebp
call main
movl %eax, %ebx
movl $1, %eax
int $0x80

.globl something
something:
pushl %ebp
movl %esp, %ebp

# Print Method
pushl $0x0a2167
pushl $0x06e696874
pushl $0x0656d6f73
pushl $0x020676e69
pushl $0x06c6c6143

movl %esp, %ecx
addl $20, %esp
movl $20, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Call
pushl $1

popl %eax
movl %ebp, %esp
popl %ebp
ret
.globl main
main:
pushl %ebp
movl %esp, %ebp

# Call
call something

# Call
pushl 8(%esp)

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

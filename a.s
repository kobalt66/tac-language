.section .text
.globl _start
_start:
pushl 0(%esp)
call main
addl $4, %esp
movl %eax, %ebx
movl $1, %eax
int $0x80

.globl main
main:
pushl %ebp
movl %esp, %ebp
movl $4, %eax
movl $1, %ebx
movl $0, %ecx
movl $0, %edx
int $0x80
movl $18, %eax

movl %ebp, %esp
popl %ebp
ret

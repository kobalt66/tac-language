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
pushl $0x0ad65
pushl $0x067617567
pushl $0x06e616c20
pushl $0x063617420
pushl $0x065687420
pushl $0x073692073
pushl $0x069687420
pushl $0x02c646c72
pushl $0x06f77206f
pushl $0x06c6c6568
movl %esp, %ecx
addl $78, %esp
movl $40, %edx
int $0x80
movl $18, %eax

movl %ebp, %esp
popl %ebp
ret

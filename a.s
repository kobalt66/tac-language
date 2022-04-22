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
pushl $0x0a3234
pushl $0x09
pushl $0x03a646c72
pushl $0x06f572020
pushl $0x020
pushl $0x0a3032
pushl $0x093a6f6c
pushl $0x06c654820
pushl $0x02e31
movl %esp, %ecx
addl $52, %esp
movl $36, %edx
int $0x80
movl $4, %eax
movl $1, %ebx
pushl $0x0a3234
pushl $0x09
pushl $0x03a646c72
pushl $0x06f572020
pushl $0x020
pushl $0x0a3032
pushl $0x093a6f6c
pushl $0x06c654820
pushl $0x02e32
movl %esp, %ecx
addl $52, %esp
movl $36, %edx
int $0x80
movl $18, %eax

movl %ebp, %esp
popl %ebp
ret

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

# Print Method
movl $4, %eax
movl $1, %ebx

# Access
pushl 4(%esp)

movl %esp, %ecx
addl $0, %esp
movl $0, %edx
int $0x80

# Print Method
movl $4, %eax
movl $1, %ebx

pushl $0x0a65
pushl $0x072656874
pushl $0x0206f6c6c
pushl $0x06548

movl %esp, %ecx
addl $16, %esp
movl $16, %edx
int $0x80
movl 8(%esp), %eax

movl %ebp, %esp
popl %ebp
ret

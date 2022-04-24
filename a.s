.section .text
.globl _start
_start:
pushl 4(%esp)
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
movl $1, %ebx

# Access
movl 8(%esp), %esp
movl 1(%esp), %esp
pushl (%esp)
call strlen
addl $4, %esp

movl %esp, %ecx
addl $0, %esp
movl %eax, %edx

movl $4, %eax
int $0x80

# Print Method
movl $1, %ebx

pushl $0x0a65
pushl $0x072656874
pushl $0x0206f6c6c
pushl $0x06548

movl %esp, %ecx
addl $16, %esp
movl $16, %edx

movl $4, %eax
int $0x80
movl 8(%esp), %eax

movl %ebp, %esp
popl %ebp
ret

.type strlen, @function
strlen:
  pushl %ebp
  movl %esp, %ebp
  movl $0, %edi
  movl 4(%esp), %eax
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

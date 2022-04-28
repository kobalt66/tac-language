.section .text
.globl _start
_start:
movl %esp, %ebp
call main
movl %eax, %ebx
movl $1, %eax
int $0x80

.globl main
main:
pushl %ebp
movl %esp, %ebp

# Print Method
pushl $0x0a646c72
pushl $0x06f77206f
pushl $0x06c6c6568

movl %esp, %ecx
addl $12, %esp
movl $12, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
pushl $0x03533
pushl $0x032333231

movl %esp, %ecx
addl $8, %esp
movl $8, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
pushl $0x0a

movl %esp, %ecx
addl $4, %esp
movl $4, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
# Access
pushl 12(%ebp)
call strlen
popl %esp

movl %esp, %ecx
addl $0, %esp
movl %eax, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
pushl $0x0a

movl %esp, %ecx
addl $4, %esp
movl $4, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
pushl 0(%esp)

movl %esp, %ecx
addl $0, %esp
movl %eax, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

# Print Method
pushl $0x0a

movl %esp, %ecx
addl $4, %esp
movl $4, %edx

movl $4, %eax
movl $1, %ebx

int $0x80

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

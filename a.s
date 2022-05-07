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
pushl 28(%esp)

# Call
call print
addl $4, %esp
pushl 24(%esp)

# Call
call print
addl $4, %esp
pushl 20(%esp)

# Call
call print
addl $4, %esp
pushl 16(%esp)

# Call
call print
addl $4, %esp
pushl 12(%esp)

# Call
call print
addl $4, %esp
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
subl $4, %esp
subl $4, %esp
subl $4, %esp
subl $4, %esp
subl $4, %esp
subl $4, %esp
subl $92, %esp

# Push string elements onto stack
movl $0x0, 84(%esp)
movl $0x0a21, 80(%esp) 
movl $0x0216c6c61, 76(%esp) 
movl $0x063206e6f, 72(%esp) 
movl $0x06974636e, 68(%esp) 
movl $0x075662073, 64(%esp) 
movl $0x069687420, 60(%esp) 
movl $0x06e692073, 56(%esp) 
movl $0x0746e656d, 52(%esp) 
movl $0x075677261, 48(%esp) 
movl $0x020726568, 44(%esp) 
movl $0x0746f206f, 40(%esp) 
movl $0x074206465, 36(%esp) 
movl $0x07261706d, 32(%esp) 
movl $0x06f632067, 28(%esp) 
movl $0x06e6f6c20, 24(%esp) 
movl $0x079726576, 20(%esp) 
movl $0x0206f736c, 16(%esp) 
movl $0x061207369, 12(%esp) 
movl $0x020646c72, 8(%esp) 
movl $0x06f77206f, 4(%esp) 
movl $0x06c6c6568, 0(%esp) 
movl %esp, -4(%ebp)
# end of hello world is also very long compared to other arguments in this function call!!

subl $84, %esp

# Push string elements onto stack
movl $0x0, 76(%esp)
movl $0x0a, 72(%esp) 
movl $0x02e2e2e6c, 68(%esp) 
movl $0x06c616320, 64(%esp) 
movl $0x06e6f6974, 60(%esp) 
movl $0x0636e7566, 56(%esp) 
movl $0x020736968, 52(%esp) 
movl $0x07420666f, 48(%esp) 
movl $0x02073746e, 44(%esp) 
movl $0x0656d7567, 40(%esp) 
movl $0x072612072, 36(%esp) 
movl $0x06568746f, 32(%esp) 
movl $0x0206e6168, 28(%esp) 
movl $0x074207265, 24(%esp) 
movl $0x0676e6f6c, 20(%esp) 
movl $0x020746962, 16(%esp) 
movl $0x020612073, 12(%esp) 
movl $0x069207920, 8(%esp) 
movl $0x0676e6974, 4(%esp) 
movl $0x06e697270, 0(%esp) 
movl %esp, -8(%ebp)
# end of printing y is a bit longer than other arguments of this function call...

subl $20, %esp

# Push string elements onto stack
movl $0x0, 12(%esp)
movl $0x0a, 8(%esp) 
movl $0x021677261, 4(%esp) 
movl $0x020647233, 0(%esp) 
movl %esp, -12(%ebp)
# end of 3rd arg!

subl $20, %esp

# Push string elements onto stack
movl $0x0, 12(%esp)
movl $0x0a, 8(%esp) 
movl $0x021677261, 4(%esp) 
movl $0x020687434, 0(%esp) 
movl %esp, -16(%ebp)
# end of 4th arg!

subl $20, %esp

# Push string elements onto stack
movl $0x0, 12(%esp)
movl $0x0a, 8(%esp) 
movl $0x021677261, 4(%esp) 
movl $0x020687435, 0(%esp) 
movl %esp, -20(%ebp)
# end of 5th arg!

subl $20, %esp

# Push string elements onto stack
movl $0x0, 12(%esp)
movl $0x0a, 8(%esp) 
movl $0x021677261, 4(%esp) 
movl $0x020687436, 0(%esp) 
movl %esp, -24(%ebp)
# end of 6th arg!

pushl -4(%ebp)
pushl -8(%ebp)
pushl -12(%ebp)
pushl -16(%ebp)
pushl -20(%ebp)
pushl -24(%ebp)

# Call
call hello
addl $24, %esp
subl $4, %esp
subl $28, %esp

# Push string elements onto stack
movl $0x0, 20(%esp)
movl $0x0a, 16(%esp) 
movl $0x0216e6961, 12(%esp) 
movl $0x06d206d6f, 8(%esp) 
movl $0x07266206f, 4(%esp) 
movl $0x06c6c6548, 0(%esp) 
movl %esp, -4(%ebp)
# end of Hello from main!

pushl -4(%ebp)

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

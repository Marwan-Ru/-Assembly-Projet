#
# Compteur de voyelles
#
	
.data  # debut du segment de donnees

msgnoargs:
	.string "Il faut au moins un argument!\n"
lennoargs:
	.quad 29
	
.text # debut du segment de code

.global _start
_start:
	pop %rax # RAX = argc
	cmp $2, %rax
	jl noargs

noargs:
	mov $1, %rax # RAX = 1 (sys_write)
	mov $1, %rdi # RDI = 1 (stdout)
	mov $msgnoargs, %rsi # RSI = msgnoargs
	mov lennoargs, %rdx # RDX = lennoargs
	syscall

fin:
	mov $60, %rax # RAX = 1
	xor %rdi,%rdi # RDI = 0
	syscall # appel systeme

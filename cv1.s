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
	test %rax, %rax # RAX == 0 ?
	jz noargs

noargs:
	mov lennoargs, %rdx # RDX = lennoargs
	mov msgnoargs, %rcx # RCX = msgnoargs
	mov $1, %rbx # RBX = 1 (stdout)
	mov $4, %rax # RAX = 4 (sys_write)
	syscall

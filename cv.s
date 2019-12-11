#
# Compteur de voyelles
#
	
.data  # debut du segment de donnees
	
.text # debut du segment de code

.global _start
_start:
	
fin:
	mov $60, %rax # RAX = 1
	xor %rdi,%rdi # RDI = 0
	syscall # appel systeme
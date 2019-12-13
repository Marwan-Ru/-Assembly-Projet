#
# Compteur de voyelles
#
	
.data  # debut du segment de donnees

msgnoargs:
	.string "Il faut au moins un argument!"
lennoargs:
	.quad 29

msgargs1:
	.string "Il y a "
lenargs1:
	.quad 7

msgargs2:
	.string " voyelles"
lenargs2:
	.quad 9
	
.text # debut du segment de code

.global _start
_start:
	pop %rbx #RAX = argc
	cmp $2, %rbx #Rax == 0 ?
	jl noargs
	pop %rbx #RAX = argv[0]
	pop %rbx #RAX = argv[1]
	movb (%RBX), %al # PLace le premier octets que pointe RBX dans AL
	xor %r8, %r8	# r8 va nous servir de compteur de voyelles

tant_que:
	test %al, %al  	# al == 0
	jz args
	inc %rbx
	cmp $97, %al 	# 97 est le code ascii de a, on fait donc al == 'a'
	je est_voyelle
	cmp $101, %al 	# al == 'e'
	je est_voyelle
	cmp $105, %al 	# al == 'i'
	je est_voyelle
	cmp $111, %al 	# al == 'o'
	je est_voyelle
	cmp $117, %al 	# al == 'u'
	je est_voyelle
	cmp $121, %al 	# al == 'y'
	je est_voyelle
	movb (%rbx), %al 	# On déplace l'octet suivant dans al
	jmp tant_que

est_voyelle:
	inc %r8			# r8 ++
	movb (%RBX), %al 	# On déplace l'octet suivant dans al
	jmp tant_que

noargs:
	mov $1, %rax # RAX = 1 (sys_write)
	mov $1, %rdi # RDI = 1 (stdout)
	mov $msgnoargs, %rsi # RSI = msgnoargs
	mov lennoargs, %rdx # RDX = lennoargs
	syscall
	mov $10, %rdx # RDX = 10
	call printC
	jmp fin

args:
	mov $1, %rax # RAX = 1 (sys_write)
	mov $1, %rdi # RDI = 1 (stdout)
	mov $msgargs1, %rsi # RSI = msgnoargs
	mov lenargs1, %rdx # RDX = lennoargs
	syscall
	mov %r8, %rax # RAX = R8
	call print
	mov $1, %rax # RAX = 1 (sys_write)
	mov $msgargs2, %rsi # RSI = msgnoargs
	mov lenargs2, %rdx # RDX = lennoargs
	syscall
	mov $10, %rdx # RDX = 10
	call printC

fin:
	mov $60, %rax # RAX = 1
	xor %rdi,%rdi # RDI = 0
	syscall # appel systeme

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
	pop %rbx # RAX = argc
	mov %rbx, %rcx # RCX = RBX (argc)
	cmp $2, %rbx # Rax < 2 ?
	jl noargs
	pop %rbx # RAX = argv[0]
	sub $1, %rcx # RCX--
	xor %r8, %r8 # r8 va nous servir de compteur de voyelles

for:
	test %rcx, %rcx # RCX == 0 ?
	jz args
	pop %rbx # RAX = argv[1]
	movb (%rbx), %al # RBX = argv 
	sub $1, %rcx # RCX--

tant_que:
	test %al, %al  	# al == 0
	jz for
	inc %rbx
	cmp $65, %al 	# al == 'A'
	je est_a
	cmp $69, %al 	# al == 'E'
	je est_e
	cmp $73, %al 	# al == 'I'
	je est_i
	cmp $79, %al 	# al == 'O'
	je est_o
	cmp $85, %al 	# al == 'U'
	je est_u
	cmp $89, %al 	# al == 'Y'
	je est_y
	cmp $97, %al 	# 97 est le code ascii de a, on fait donc al == 'a'
	je est_a
	cmp $101, %al 	# al == 'e'
	je est_e
	cmp $105, %al 	# al == 'i'
	je est_i
	cmp $111, %al 	# al == 'o'
	je est_o
	cmp $117, %al 	# al == 'u'
	je est_u
	cmp $121, %al 	# al == 'y'
	je est_y
	movb (%rbx), %al 	# On déplace l'octet suivant dans al
	jmp tant_que

est_a:
	inc %r8 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_e:
	inc %r9 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_i:
	inc %r10 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_o:
	inc %r11 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_u:
	inc %r12 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_y:
	inc %r13 # r8++
	movb (%RBX), %al # On déplace l'octet suivant dans al
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

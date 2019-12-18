#
# Compteur de voyelles
#
	
.data  # debut du segment de donnees

msgnoargs:
	.string "Il faut au moins un argument!"
lennoargs:
	.quad 29

msgargs1:
	.string " occurence(s) de"
lenargs1:
	.quad 16

msga:
	.string " a"
lena:
	.quad 2

msge:
	.string " e"
lene:
	.quad 2

msgi:
	.string " i"
leni:
	.quad 2

msgo:
	.string " o"
leno:
	.quad 2

msgu:
	.string " u"
lenu:
	.quad 2

msgy:
	.string " y"
leny:
	.quad 2
	
.text # debut du segment de code

.global _start
_start:
	pop %rcx # RCX = argc
	cmp $2, %rcx # RCX < 2 ?
	jl noargs
	pop %rbx # RBX = argv[0]
	sub $1, %rcx # RCX--
	#On initilaise les compteurs de voyelle 
	xor %r8, %r8 
	xor %r9, %r9 
	xor %r10, %r10 
	xor %r11, %r11 
	xor %r12, %r12 
	xor %r13, %r13 

for:
	test %rcx, %rcx # RCX == 0 ?
	jz empile
	pop %rbx # RBX = argv[1]
	movb (%rbx), %al # AL = argv 
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
	inc %r9 # r9++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_i:
	inc %r10 # r10++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_o:
	inc %r11 # r11++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_u:
	inc %r12 # r12++
	movb (%RBX), %al # On déplace l'octet suivant dans al
	jmp tant_que

est_y:
	inc %r13 # r13++
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

empile: #On va empiler la valeur pour chaque lettre 
	push $msgy
	push %r13
	push $msgu
	push %r12
	push $msgo
	push %r11
	push $msgi
	push %r10
	push $msge
	push %r9
	push $msga
	push %r8
	mov $6, %r14 #r14 = 7 Pour la boucle for n°2

refor:
	test %r14, %r14 # R14 == 0 ?
	jz fin
	sub $1, %r14 # R14  --

args:
	pop %rax # RAX = R8
	call print
	mov $1, %rax # RAX = 1 (sys_write)
	mov $1, %rdi # RDI = 1 (stdout)
	mov $msgargs1, %rsi # RSI = msgarg1
	mov lenargs1, %rdx # RDX = lennarg2
	syscall
	mov $1, %rax # RAX = 1 (sys_write)
	pop %rsi # On met la bonne lettre dans rsi
	mov $2, %rdx # RDX = 2
	syscall
	mov $10, %rdx # RDX = 10
	call printC
	jmp refor

fin:
	mov $60, %rax # RAX = 1
	xor %rdi,%rdi # RDI = 0
	syscall # appel systeme

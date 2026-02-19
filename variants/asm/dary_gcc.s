	.file	"dary.c"
	.text
	.p2align 4
	.globl	hash
	.type	hash, @function
hash:
.LFB53:
	.cfi_startproc
	endbr64
	movsbl	(%rdi), %eax
	leaq	1(%rdi), %rcx
	testl	%esi, %esi
	jne	.L2
	movl	$5381, %edx
	testb	%al, %al
	je	.L18
	.p2align 4,,10
	.p2align 3
.L3:
	movl	%edx, %esi
	addq	$1, %rcx
	sall	$5, %esi
	addl	%esi, %edx
	addl	%eax, %edx
	movsbl	-1(%rcx), %eax
	testb	%al, %al
	jne	.L3
.L8:
	movl	%edx, %eax
	imulq	$128207979, %rax, %rax
	shrq	$34, %rax
	imull	$134, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	cmpl	$1, %esi
	je	.L19
	testb	%al, %al
	je	.L11
	movl	$131, %edx
	.p2align 4,,10
	.p2align 3
.L7:
	movl	%edx, %esi
	addq	$1, %rcx
	sall	$5, %esi
	addl	%esi, %edx
	addl	%eax, %edx
	movsbl	-1(%rcx), %eax
	testb	%al, %al
	jne	.L7
	jmp	.L8
	.p2align 4,,10
	.p2align 3
.L19:
	xorl	%edx, %edx
	testb	%al, %al
	je	.L20
	.p2align 4,,10
	.p2align 3
.L6:
	imull	$65599, %edx, %edx
	addq	$1, %rcx
	addl	%eax, %edx
	movsbl	-1(%rcx), %eax
	testb	%al, %al
	jne	.L6
	jmp	.L8
.L18:
	movl	$21, %eax
	ret
.L11:
	movl	$131, %eax
	ret
.L20:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE53:
	.size	hash, .-hash
	.p2align 4
	.globl	init_table
	.type	init_table, @function
init_table:
.LFB54:
	.cfi_startproc
	endbr64
	movq	$0, (%rdi)
	movq	%rdi, %rdx
	leaq	8(%rdi), %rdi
	xorl	%eax, %eax
	movq	$0, 3200(%rdi)
	movq	%rdx, %rcx
	andq	$-8, %rdi
	subq	%rdi, %rcx
	addl	$3216, %ecx
	shrl	$3, %ecx
	rep stosq
	movl	$0, 3216(%rdx)
	movq	$0, 3224(%rdx)
	ret
	.cfi_endproc
.LFE54:
	.size	init_table, .-init_table
	.p2align 4
	.globl	insert
	.type	insert, @function
insert:
.LFB55:
	.cfi_startproc
	endbr64
	movq	%rsi, %r9
	movl	$100, %r8d
	.p2align 4,,10
	.p2align 3
.L23:
	movsbl	(%r9), %edx
	leaq	1(%r9), %rsi
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L44
	.p2align 4,,10
	.p2align 3
.L30:
	movl	%eax, %ecx
	addq	$1, %rsi
	sall	$5, %ecx
	addl	%ecx, %eax
	addl	%edx, %eax
	movsbl	-1(%rsi), %edx
	testb	%dl, %dl
	jne	.L30
	xorl	%ecx, %ecx
.L28:
	movl	%eax, %edx
	imulq	$128207979, %rdx, %rdx
	shrq	$34, %rdx
	imull	$134, %edx, %esi
	subl	%esi, %eax
	movl	%eax, %edx
.L31:
	movslq	%ecx, %rax
	imulq	$134, %rax, %rax
	addq	%rdx, %rax
	movq	(%rdi,%rax,8), %r10
	testq	%r10, %r10
	je	.L45
	addl	$1, %ecx
	addq	$1, 3224(%rdi)
	movq	%r9, (%rdi,%rax,8)
	cmpl	$3, %ecx
	je	.L46
	movsbl	(%r10), %edx
	cmpl	$1, %ecx
	je	.L47
	testb	%dl, %dl
	je	.L36
	leaq	1(%r10), %rsi
	movl	$131, %eax
	.p2align 4,,10
	.p2align 3
.L27:
	movl	%eax, %ecx
	addq	$1, %rsi
	sall	$5, %ecx
	addl	%ecx, %eax
	movl	$2, %ecx
	addl	%edx, %eax
	movsbl	-1(%rsi), %edx
	testb	%dl, %dl
	jne	.L27
	movq	%r10, %r9
	jmp	.L28
	.p2align 4,,10
	.p2align 3
.L46:
	subl	$1, %r8d
	je	.L37
	movq	%r10, %r9
	jmp	.L23
	.p2align 4,,10
	.p2align 3
.L47:
	testb	%dl, %dl
	je	.L48
	leaq	1(%r10), %rsi
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L29:
	imull	$65599, %eax, %eax
	addq	$1, %rsi
	addl	%edx, %eax
	movsbl	-1(%rsi), %edx
	testb	%dl, %dl
	jne	.L29
	movq	%r10, %r9
	jmp	.L28
.L36:
	movl	$131, %edx
.L26:
	movq	%r10, %r9
	jmp	.L31
.L45:
	movq	%r9, (%rdi,%rax,8)
	movl	$1, %eax
	addl	$1, 3216(%rdi)
	ret
.L44:
	xorl	%ecx, %ecx
	movl	$21, %edx
	jmp	.L31
.L48:
	xorl	%edx, %edx
	jmp	.L26
.L37:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE55:
	.size	insert, .-insert
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC2:
	.string	"r"
.LC3:
	.string	"../models_test_data.csv"
.LC4:
	.string	"\r\n"
.LC5:
	.string	","
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC10:
	.string	"d-ary Cuckoo (d=3): AvgTime=%.8f, AvgLF=%.4f, AvgDisp=%.2f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB56:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	-57344(%rsp), %r11
	.cfi_def_cfa 11, 57400
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	.cfi_def_cfa_register 7
	subq	$1656, %rsp
	.cfi_def_cfa_offset 59056
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 58984(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L75
	leaq	58464(%rsp), %r13
	movq	%rax, %rdx
	movq	%rax, %rbp
	xorl	%ebx, %ebx
	movl	$512, %esi
	movq	%r13, %rdi
	leaq	3524(%rsp), %r12
	call	fgets@PLT
	leaq	.LC4(%rip), %r15
	leaq	.LC5(%rip), %r14
	jmp	.L51
.L107:
	cmpl	$200, %ebx
	je	.L55
	movq	%r15, %rsi
	movq	%r13, %rdi
	call	strcspn@PLT
	movq	%r14, %rsi
	movq	%r13, %rdi
	movb	$0, 58464(%rsp,%rax)
	call	strtok@PLT
	movq	%rax, %rsi
	testq	%rax, %rax
	je	.L52
	leaq	-260(%r12), %rdi
	movl	$256, %edx
	call	__strcpy_chk@PLT
.L52:
	xorl	%edi, %edi
	movq	%r14, %rsi
	call	strtok@PLT
	movq	%rax, %rdi
	testq	%rax, %rax
	je	.L53
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movl	%eax, -4(%r12)
.L53:
	movq	%r14, %rsi
	xorl	%edi, %edi
	call	strtok@PLT
	movq	%rax, %rsi
	testq	%rax, %rax
	je	.L54
	movl	$16, %edx
	movq	%r12, %rdi
	call	__strcpy_chk@PLT
.L54:
	addl	$1, %ebx
	addq	$276, %r12
.L51:
	movq	%rbp, %rdx
	movl	$512, %esi
	movq	%r13, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L107
.L55:
	movq	%rbp, %rdi
	movslq	%ebx, %rbp
	xorl	%r12d, %r12d
	xorl	%r14d, %r14d
	call	fclose@PLT
	imulq	$276, %rbp, %rbp
	leaq	32(%rsp), %rax
	movl	$10, 24(%rsp)
	movq	%rax, 8(%rsp)
	leaq	3264(%rsp), %r15
	pxor	%xmm1, %xmm1
	pxor	%xmm0, %xmm0
	addq	%r15, %rbp
.L73:
	movq	8(%rsp), %rdi
	movq	%r14, %rax
	movl	$402, %ecx
	movss	%xmm1, 16(%rsp)
	movsd	%xmm0, (%rsp)
	rep stosq
	movq	%r14, 3256(%rsp)
	movl	$0, 3248(%rsp)
	call	clock@PLT
	testl	%ebx, %ebx
	movsd	(%rsp), %xmm0
	movss	16(%rsp), %xmm1
	movq	%rax, %r9
	je	.L76
	movl	%ebx, 16(%rsp)
	movq	%r15, %rsi
	xorl	%r10d, %r10d
	xorl	%r13d, %r13d
	xorl	%edi, %edi
	xorl	%r8d, %r8d
.L71:
	movq	%rsi, %rbx
	movb	%r10b, (%rsp)
	movl	$100, %r11d
	movl	$5381, %eax
	movsbl	(%rbx), %edx
	leaq	1(%rbx), %r10
	testb	%dl, %dl
	je	.L108
	.p2align 4,,10
	.p2align 3
.L65:
	movl	%eax, %ecx
	addq	$1, %r10
	sall	$5, %ecx
	addl	%ecx, %eax
	addl	%edx, %eax
	movsbl	-1(%r10), %edx
	testb	%dl, %dl
	jne	.L65
	xorl	%ecx, %ecx
.L63:
	movl	%eax, %edx
	imulq	$128207979, %rdx, %rdx
	shrq	$34, %rdx
	imull	$134, %edx, %r10d
	subl	%r10d, %eax
	movl	%eax, %edx
.L66:
	movslq	%ecx, %rax
	imulq	$134, %rax, %rax
	addq	%rdx, %rax
	movq	32(%rsp,%rax,8), %r10
	testq	%r10, %r10
	je	.L109
	addl	$1, %ecx
	movq	%rbx, 32(%rsp,%rax,8)
	addq	$1, %r8
	cmpl	$3, %ecx
	je	.L110
	cmpl	$1, %ecx
	je	.L111
	movzbl	(%r10), %edx
	testb	%dl, %dl
	je	.L77
	leaq	1(%r10), %rbx
	movl	$131, %eax
	.p2align 4,,10
	.p2align 3
.L62:
	movl	%eax, %ecx
	addq	$1, %rbx
	movl	$1, %edi
	sall	$5, %ecx
	addl	%eax, %ecx
	movsbl	%dl, %eax
	movzbl	-1(%rbx), %edx
	addl	%ecx, %eax
	movl	$2, %ecx
	testb	%dl, %dl
	jne	.L62
	movq	%r10, %rbx
	jmp	.L63
	.p2align 4,,10
	.p2align 3
.L110:
	movl	$1, %edi
	subl	$1, %r11d
	je	.L103
	movq	%r10, %rbx
	movl	$5381, %eax
	movsbl	(%rbx), %edx
	leaq	1(%rbx), %r10
	testb	%dl, %dl
	jne	.L65
.L108:
	xorl	%ecx, %ecx
	movl	$21, %edx
	jmp	.L66
	.p2align 4,,10
	.p2align 3
.L111:
	movsbl	(%r10), %edx
	testb	%dl, %dl
	je	.L112
	leaq	1(%r10), %rbx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L64:
	imull	$65599, %eax, %eax
	addq	$1, %rbx
	movl	$1, %edi
	addl	%edx, %eax
	movsbl	-1(%rbx), %edx
	testb	%dl, %dl
	jne	.L64
	movq	%r10, %rbx
	jmp	.L63
.L77:
	movl	$131, %edx
.L61:
	movq	%r10, %rbx
	movl	$1, %edi
	jmp	.L66
.L109:
	movq	%rbx, 32(%rsp,%rax,8)
	addl	$1, %r13d
	movl	$1, %r10d
.L68:
	addq	$276, %rsi
	cmpq	%rsi, %rbp
	jne	.L71
	xorl	%eax, %eax
	testb	%r10b, %r10b
	movl	16(%rsp), %ebx
	cmove	%eax, %r13d
	addq	%r12, %r8
	testb	%dil, %dil
	cmovne	%r8, %r12
.L57:
	movq	%r9, (%rsp)
	movss	%xmm1, 28(%rsp)
	movsd	%xmm0, 16(%rsp)
	call	clock@PLT
	movq	(%rsp), %r9
	movsd	16(%rsp), %xmm0
	pxor	%xmm2, %xmm2
	movss	28(%rsp), %xmm1
	subq	%r9, %rax
	subl	$1, 24(%rsp)
	cvtsi2sdq	%rax, %xmm2
	divsd	.LC6(%rip), %xmm2
	addsd	%xmm2, %xmm0
	pxor	%xmm2, %xmm2
	cvtsi2ssl	%r13d, %xmm2
	divss	.LC7(%rip), %xmm2
	addss	%xmm2, %xmm1
	jne	.L73
	pxor	%xmm2, %xmm2
	movl	$2, %edi
	movl	$3, %eax
	movsd	.LC8(%rip), %xmm3
	cvtsi2sdq	%r12, %xmm2
	leaq	.LC10(%rip), %rsi
	divss	.LC9(%rip), %xmm1
	cvtss2sd	%xmm1, %xmm1
	divsd	%xmm3, %xmm0
	divsd	%xmm3, %xmm2
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L49:
	movq	58984(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L113
	addq	$59000, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L112:
	.cfi_restore_state
	xorl	%edx, %edx
	jmp	.L61
.L103:
	movzbl	(%rsp), %r10d
	jmp	.L68
.L76:
	xorl	%r13d, %r13d
	jmp	.L57
.L75:
	movl	$1, %eax
	jmp	.L49
.L113:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE56:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC6:
	.long	0
	.long	1093567616
	.section	.rodata.cst4,"aM",@progbits,4
	.align 4
.LC7:
	.long	1137246208
	.section	.rodata.cst8
	.align 8
.LC8:
	.long	0
	.long	1076101120
	.section	.rodata.cst4
	.align 4
.LC9:
	.long	1092616192
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:

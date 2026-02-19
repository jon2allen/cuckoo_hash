	.file	"blocked.c"
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
	je	.L2
	xorl	%edx, %edx
	testb	%al, %al
	je	.L14
	.p2align 4,,10
	.p2align 3
.L3:
	imull	$65599, %edx, %edx
	addq	$1, %rcx
	addl	%eax, %edx
	movsbl	-1(%rcx), %eax
	testb	%al, %al
	jne	.L3
.L6:
	movl	%edx, %eax
	imulq	$1374389535, %rax, %rax
	shrq	$36, %rax
	imull	$50, %eax, %ecx
	movl	%edx, %eax
	subl	%ecx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L2:
	movl	$5381, %edx
	testb	%al, %al
	je	.L15
	.p2align 4,,10
	.p2align 3
.L5:
	movl	%edx, %esi
	addq	$1, %rcx
	sall	$5, %esi
	addl	%esi, %edx
	addl	%eax, %edx
	movsbl	-1(%rcx), %eax
	testb	%al, %al
	jne	.L5
	jmp	.L6
.L15:
	movl	$31, %eax
	ret
.L14:
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
	movq	$0, 3184(%rdi)
	movq	%rdx, %rcx
	andq	$-8, %rdi
	subq	%rdi, %rcx
	addl	$3200, %ecx
	shrl	$3, %ecx
	rep stosq
	movl	$0, 3200(%rdx)
	movq	$0, 3208(%rdx)
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
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	movq	%rsi, %rdi
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	movl	$100, %ebx
.L18:
	movsbl	(%rdi), %edx
	leaq	1(%rdi), %rcx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L38
	.p2align 4,,10
	.p2align 3
.L22:
	movl	%eax, %esi
	addq	$1, %rcx
	sall	$5, %esi
	addl	%esi, %eax
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L22
	xorl	%r12d, %r12d
.L21:
	movl	%eax, %ecx
	movq	%rdi, %r13
	imulq	$1374389535, %rcx, %rcx
	shrq	$36, %rcx
	imull	$50, %ecx, %edx
	subl	%edx, %eax
	movl	%eax, %ecx
.L19:
	movslq	%r12d, %rdx
	leaq	(%rdx,%rdx,4), %rax
	leaq	(%rax,%rax,4), %rax
	leaq	(%rcx,%rax,2), %r14
	movq	%r14, %rax
	salq	$5, %rax
	addq	%rbp, %rax
	cmpq	$0, (%rax)
	je	.L30
	cmpq	$0, 8(%rax)
	je	.L31
	cmpq	$0, 16(%rax)
	je	.L32
	cmpq	$0, 24(%rax)
	je	.L39
	addq	$1, 3208(%rbp)
	call	rand@PLT
	cltd
	shrl	$30, %edx
	addl	%edx, %eax
	andl	$3, %eax
	subl	%edx, %eax
	cltq
	leaq	(%rax,%r14,4), %rax
	movq	0(%rbp,%rax,8), %rdi
	movq	%r13, 0(%rbp,%rax,8)
	cmpl	$1, %r12d
	je	.L40
	movsbl	(%rdi), %edx
	xorl	%ecx, %ecx
	movl	$1, %r12d
	testb	%dl, %dl
	je	.L29
	leaq	1(%rdi), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	imull	$65599, %eax, %eax
	addq	$1, %rcx
	movl	$1, %r12d
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L20
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L40:
	subl	$1, %ebx
	jne	.L18
	xorl	%eax, %eax
	jmp	.L17
	.p2align 4,,10
	.p2align 3
.L38:
	movq	%rdi, %r13
	xorl	%r12d, %r12d
	movl	$31, %ecx
	jmp	.L19
.L29:
	movq	%rdi, %r13
	jmp	.L19
.L30:
	xorl	%eax, %eax
.L23:
	leaq	(%rdx,%rdx,4), %rdx
	leaq	(%rdx,%rdx,4), %rdx
	leaq	(%rcx,%rdx,2), %rdx
	leaq	(%rax,%rdx,4), %rax
	movq	%rdi, 0(%rbp,%rax,8)
	movl	$1, %eax
	addl	$1, 3200(%rbp)
.L17:
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L31:
	.cfi_restore_state
	movl	$1, %eax
	jmp	.L23
.L32:
	movl	$2, %eax
	jmp	.L23
.L39:
	movl	$3, %eax
	jmp	.L23
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
	.string	"Blocked Cuckoo (b=4): AvgTime=%.8f, AvgLF=%.4f, AvgDisp=%.2f\n"
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
	subq	$1640, %rsp
	.cfi_def_cfa_offset 59040
	xorl	%edi, %edi
	movq	%fs:40, %rax
	movq	%rax, 58968(%rsp)
	xorl	%eax, %eax
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	call	fopen@PLT
	testq	%rax, %rax
	je	.L53
	movq	%rax, %rdx
	movl	$512, %esi
	movq	%rax, %r14
	xorl	%r12d, %r12d
	leaq	58448(%rsp), %rbp
	leaq	3508(%rsp), %rbx
	movq	%rbp, %rdi
	leaq	.LC4(%rip), %r15
	leaq	.LC5(%rip), %r13
	call	fgets@PLT
	jmp	.L43
	.p2align 4,,10
	.p2align 3
.L70:
	cmpl	$200, %r12d
	je	.L47
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	strcspn@PLT
	movq	%r13, %rsi
	movq	%rbp, %rdi
	movb	$0, 58448(%rsp,%rax)
	call	strtok@PLT
	testq	%rax, %rax
	je	.L44
	leaq	-260(%rbx), %rdi
	movl	$256, %edx
	movq	%rax, %rsi
	call	__strcpy_chk@PLT
.L44:
	xorl	%edi, %edi
	movq	%r13, %rsi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L45
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %rdi
	call	strtol@PLT
	movl	%eax, -4(%rbx)
.L45:
	xorl	%edi, %edi
	movq	%r13, %rsi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L46
	movl	$16, %edx
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	__strcpy_chk@PLT
.L46:
	addl	$1, %r12d
	addq	$276, %rbx
.L43:
	movq	%r14, %rdx
	movl	$512, %esi
	movq	%rbp, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L70
.L47:
	movq	%r14, %rdi
	movslq	%r12d, %rbp
	leaq	32(%rsp), %rbx
	xorl	%r15d, %r15d
	call	fclose@PLT
	imulq	$276, %rbp, %rbp
	leaq	3248(%rsp), %rax
	movl	$10, 20(%rsp)
	movq	%rax, 24(%rsp)
	movl	$0x00000000, 16(%rsp)
	movq	$0x000000000, 8(%rsp)
	addq	%rax, %rbp
	.p2align 4,,10
	.p2align 3
.L51:
	xorl	%eax, %eax
	movl	$400, %ecx
	movq	%rbx, %rdi
	movl	$0, 3232(%rsp)
	rep stosq
	movq	$0, 3240(%rsp)
	call	clock@PLT
	movq	%rax, %r13
	testl	%r12d, %r12d
	je	.L54
	movq	24(%rsp), %r14
	.p2align 4,,10
	.p2align 3
.L50:
	movq	%r14, %rsi
	movq	%rbx, %rdi
	addq	$276, %r14
	call	insert
	cmpq	%rbp, %r14
	jne	.L50
	movl	3232(%rsp), %r14d
	addq	3240(%rsp), %r15
.L49:
	call	clock@PLT
	pxor	%xmm0, %xmm0
	subq	%r13, %rax
	subl	$1, 20(%rsp)
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC6(%rip), %xmm0
	addsd	8(%rsp), %xmm0
	movsd	%xmm0, 8(%rsp)
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%r14d, %xmm0
	divss	.LC7(%rip), %xmm0
	addss	16(%rsp), %xmm0
	movss	%xmm0, 16(%rsp)
	jne	.L51
	pxor	%xmm2, %xmm2
	movaps	%xmm0, %xmm1
	movsd	.LC8(%rip), %xmm3
	movsd	8(%rsp), %xmm0
	cvtsi2sdq	%r15, %xmm2
	movl	$2, %edi
	leaq	.LC10(%rip), %rsi
	movl	$3, %eax
	divsd	%xmm3, %xmm0
	divss	.LC9(%rip), %xmm1
	cvtss2sd	%xmm1, %xmm1
	divsd	%xmm3, %xmm2
	call	__printf_chk@PLT
	xorl	%eax, %eax
.L41:
	movq	58968(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L71
	addq	$58984, %rsp
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
	.p2align 4,,10
	.p2align 3
.L54:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L49
.L53:
	movl	$1, %eax
	jmp	.L41
.L71:
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
	.long	1137180672
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

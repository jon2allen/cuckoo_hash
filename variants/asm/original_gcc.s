	.file	"original.c"
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
	shrq	$38, %rax
	imull	$200, %eax, %ecx
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
	movl	$181, %eax
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
	movq	%rsi, %r8
	movl	$100, %esi
	.p2align 4,,10
	.p2align 3
.L18:
	movsbl	(%r8), %edx
	leaq	1(%r8), %rcx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L33
	.p2align 4,,10
	.p2align 3
.L22:
	movl	%eax, %r9d
	addq	$1, %rcx
	sall	$5, %r9d
	addl	%r9d, %eax
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L22
	xorl	%r9d, %r9d
.L21:
	movl	%eax, %ecx
	imulq	$1374389535, %rcx, %rcx
	shrq	$38, %rcx
	imull	$200, %ecx, %edx
	subl	%edx, %eax
	movq	%r8, %rdx
	movl	%eax, %ecx
.L19:
	movslq	%r9d, %rax
	leaq	(%rax,%rax,4), %rax
	leaq	(%rax,%rax,4), %rax
	leaq	(%rcx,%rax,8), %rax
	movq	(%rdi,%rax,8), %r8
	testq	%r8, %r8
	je	.L34
	addq	$1, 3208(%rdi)
	movq	%rdx, (%rdi,%rax,8)
	cmpl	$1, %r9d
	je	.L35
	movsbl	(%r8), %edx
	xorl	%ecx, %ecx
	movl	$1, %r9d
	testb	%dl, %dl
	je	.L27
	leaq	1(%r8), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	imull	$65599, %eax, %eax
	addq	$1, %rcx
	movl	$1, %r9d
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L20
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L35:
	subl	$1, %esi
	jne	.L18
	xorl	%eax, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L27:
	movq	%r8, %rdx
	jmp	.L19
.L33:
	movq	%r8, %rdx
	xorl	%r9d, %r9d
	movl	$181, %ecx
	jmp	.L19
.L34:
	movq	%rdx, (%rdi,%rax,8)
	movl	$1, %eax
	addl	$1, 3200(%rdi)
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
	.string	"Original Cuckoo: AvgTime=%.8f, AvgLF=%.4f, AvgDisp=%.2f\n"
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
	leaq	.LC2(%rip), %rsi
	leaq	.LC3(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 58968(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L48
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
	jmp	.L38
	.p2align 4,,10
	.p2align 3
.L65:
	cmpl	$200, %r12d
	je	.L42
	movq	%r15, %rsi
	movq	%rbp, %rdi
	call	strcspn@PLT
	movq	%r13, %rsi
	movq	%rbp, %rdi
	movb	$0, 58448(%rsp,%rax)
	call	strtok@PLT
	testq	%rax, %rax
	je	.L39
	leaq	-260(%rbx), %rdi
	movl	$256, %edx
	movq	%rax, %rsi
	call	__strcpy_chk@PLT
.L39:
	xorl	%edi, %edi
	movq	%r13, %rsi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L40
	movl	$10, %edx
	xorl	%esi, %esi
	movq	%rax, %rdi
	call	strtol@PLT
	movl	%eax, -4(%rbx)
.L40:
	xorl	%edi, %edi
	movq	%r13, %rsi
	call	strtok@PLT
	testq	%rax, %rax
	je	.L41
	movl	$16, %edx
	movq	%rax, %rsi
	movq	%rbx, %rdi
	call	__strcpy_chk@PLT
.L41:
	addl	$1, %r12d
	addq	$276, %rbx
.L38:
	movq	%r14, %rdx
	movl	$512, %esi
	movq	%rbp, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L65
.L42:
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
.L46:
	xorl	%eax, %eax
	movl	$400, %ecx
	movq	%rbx, %rdi
	movl	$0, 3232(%rsp)
	rep stosq
	movq	$0, 3240(%rsp)
	call	clock@PLT
	movq	%rax, %r13
	testl	%r12d, %r12d
	je	.L49
	movq	24(%rsp), %r10
	.p2align 4,,10
	.p2align 3
.L45:
	movq	%r10, %rsi
	movq	%rbx, %rdi
	addq	$276, %r10
	call	insert
	cmpq	%rbp, %r10
	jne	.L45
	movl	3232(%rsp), %r14d
	addq	3240(%rsp), %r15
.L44:
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
	jne	.L46
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
.L36:
	movq	58968(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L66
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
.L49:
	.cfi_restore_state
	xorl	%r14d, %r14d
	jmp	.L44
.L48:
	movl	$1, %eax
	jmp	.L36
.L66:
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

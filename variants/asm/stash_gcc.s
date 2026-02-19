	.file	"stash.c"
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
	movl	$2776544515, %ecx
	imulq	%rcx, %rax
	shrq	$39, %rax
	imull	$198, %eax, %ecx
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
	movl	$35, %eax
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
	movq	$0, 3152(%rdi)
	movq	%rdx, %rcx
	andq	$-8, %rdi
	pxor	%xmm0, %xmm0
	subq	%rdi, %rcx
	addl	$3168, %ecx
	shrl	$3, %ecx
	rep stosq
	movups	%xmm0, 3168(%rdx)
	movl	$0, 3200(%rdx)
	movq	$0, 3208(%rdx)
	movups	%xmm0, 3184(%rdx)
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
	movl	$2776544515, %r8d
	movl	$100, %esi
	.p2align 4,,10
	.p2align 3
.L18:
	movsbl	(%r9), %edx
	leaq	1(%r9), %rcx
	movl	$5381, %eax
	testb	%dl, %dl
	je	.L38
	.p2align 4,,10
	.p2align 3
.L22:
	movl	%eax, %r10d
	addq	$1, %rcx
	sall	$5, %r10d
	addl	%r10d, %eax
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L22
	xorl	%r10d, %r10d
.L21:
	movl	%eax, %ecx
	movq	%r9, %r11
	imulq	%r8, %rcx
	shrq	$39, %rcx
	imull	$198, %ecx, %edx
	subl	%edx, %eax
	movl	%eax, %ecx
.L19:
	movslq	%r10d, %rdx
	imulq	$198, %rdx, %rax
	addq	%rcx, %rax
	movq	(%rdi,%rax,8), %r9
	testq	%r9, %r9
	je	.L39
	addq	$1, 3208(%rdi)
	movq	%r11, (%rdi,%rax,8)
	cmpl	$1, %r10d
	je	.L40
	movsbl	(%r9), %edx
	xorl	%ecx, %ecx
	movl	$1, %r10d
	testb	%dl, %dl
	je	.L30
	leaq	1(%r9), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L20:
	imull	$65599, %eax, %eax
	addq	$1, %rcx
	movl	$1, %r10d
	addl	%edx, %eax
	movsbl	-1(%rcx), %edx
	testb	%dl, %dl
	jne	.L20
	jmp	.L21
	.p2align 4,,10
	.p2align 3
.L40:
	subl	$1, %esi
	jne	.L18
	cmpq	$0, 3168(%rdi)
	je	.L32
	cmpq	$0, 3176(%rdi)
	je	.L28
	cmpq	$0, 3184(%rdi)
	je	.L33
	xorl	%eax, %eax
	cmpq	$0, 3192(%rdi)
	movl	$3, %edx
	je	.L28
	ret
.L30:
	movq	%r9, %r11
	jmp	.L19
.L38:
	movq	%r9, %r11
	xorl	%r10d, %r10d
	movl	$35, %ecx
	jmp	.L19
.L39:
	movq	%r11, (%rdi,%rax,8)
	movl	3200(%rdi), %eax
	addl	$1, %eax
.L24:
	movl	%eax, 3200(%rdi)
	movl	$1, %eax
	ret
.L32:
	xorl	%edx, %edx
.L28:
	movl	3200(%rdi), %eax
	movq	%r9, 3168(%rdi,%rdx,8)
	addl	$1, %eax
	jmp	.L24
.L33:
	movl	$2, %edx
	jmp	.L28
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
	.string	"Cuckoo with Stash: AvgTime=%.8f, AvgLF=%.4f, AvgDisp=%.2f\n"
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
	call	fclose@PLT
	imulq	$276, %rbp, %rbp
	leaq	3248(%rsp), %rax
	movl	$10, 12(%rsp)
	movq	%rax, 24(%rsp)
	leaq	3200(%rsp), %r14
	movq	$0, 16(%rsp)
	movl	$0x00000000, 8(%rsp)
	addq	%rax, %rbp
	movq	$0x000000000, (%rsp)
	.p2align 4,,10
	.p2align 3
.L51:
	pxor	%xmm0, %xmm0
	xorl	%eax, %eax
	movl	$396, %ecx
	movq	%rbx, %rdi
	rep stosq
	movaps	%xmm0, 16(%r14)
	movaps	%xmm0, (%r14)
	movl	$0, 3232(%rsp)
	movq	$0, 3240(%rsp)
	call	clock@PLT
	movq	%rax, %r13
	testl	%r12d, %r12d
	je	.L54
	movq	24(%rsp), %r15
	.p2align 4,,10
	.p2align 3
.L50:
	movq	%r15, %rsi
	movq	%rbx, %rdi
	addq	$276, %r15
	call	insert
	cmpq	%rbp, %r15
	jne	.L50
	movq	3240(%rsp), %rcx
	addq	%rcx, 16(%rsp)
	movl	3232(%rsp), %r15d
.L49:
	call	clock@PLT
	pxor	%xmm0, %xmm0
	subq	%r13, %rax
	subl	$1, 12(%rsp)
	cvtsi2sdq	%rax, %xmm0
	divsd	.LC6(%rip), %xmm0
	addsd	(%rsp), %xmm0
	movsd	%xmm0, (%rsp)
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%r15d, %xmm0
	divss	.LC7(%rip), %xmm0
	addss	8(%rsp), %xmm0
	movss	%xmm0, 8(%rsp)
	jne	.L51
	pxor	%xmm2, %xmm2
	movaps	%xmm0, %xmm1
	movsd	.LC8(%rip), %xmm3
	movsd	(%rsp), %xmm0
	cvtsi2sdq	16(%rsp), %xmm2
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
	xorl	%r15d, %r15d
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

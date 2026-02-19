.section .rodata
.Lstr0:
    .byte 46, 46, 47, 109, 111, 100, 101, 108, 115, 95, 116, 101, 115, 116, 95, 100, 97, 116, 97, 46, 99, 115, 118, 0
.Lstr1:
    .byte 114, 0
.Lstr2:
    .byte 13, 10, 0
.Lstr3:
    .byte 44, 0
.Lstr4:
    .byte 44, 0
.Lstr5:
    .byte 44, 0
.Lstr6:
    .byte 79, 114, 105, 103, 105, 110, 97, 108, 32, 67, 117, 99, 107, 111, 111, 58, 32, 65, 118, 103, 84, 105, 109, 101, 61, 37, 46, 56, 102, 44, 32, 65
    .byte 118, 103, 76, 70, 61, 37, 46, 52, 102, 44, 32, 65, 118, 103, 68, 105, 115, 112, 61, 37, 46, 50, 102, 10, 0

.section .text
.globl hash
.type hash, @function
hash:
.cfi_startproc
    pushq %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq $80, %rsp
    movq %rbx, -80(%rbp)
    movq %r12, -72(%rbp)
    movq %r13, -64(%rbp)
    movq %r14, -56(%rbp)
    movq %r15, -48(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdi, -8(%rbp)
    movslq -16(%rbp), %rax
    movq %rax, -16(%rbp)
    testl %eax, %eax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    xorl %eax, %eax
    movq $5381, %rcx
    movq %rbx, %rdx
    testq %rbx, %rbx
    cmovneq %rcx, %rax
    movl %eax, %eax
    movq %rax, -24(%rbp)
    movq -8(%rbp), %rax
    movq %rax, %r12
    movq -24(%rbp), %rax
    movq %rax, %r11
.LBB6:
    movq %r12, %r13
    addq $1, %r13
    movq %r12, %rcx
    movsbq (%rcx), %rax
    movq %rax, %r10
    movsbq %al, %rax
    testq %rax, %rax
    je .LBB8
.LBB7:
    movq %rbx, %rax
    testq %rbx, %rbx
    je .LBB10
.LBB9:
    movq %r11, %rax
    shll $5, %eax
    addq %r11, %rax
    movl %eax, %eax
    movq %rax, %r15
    movsbq %r10b, %rax
    movl %eax, %eax
    movq %rax, -24(%rbp)
    movq %r15, %rax
    addq -24(%rbp), %rax
    movl %eax, %eax
    movq %rax, -24(%rbp)
    movq %rax, %r14
    jmp .LBB11
.LBB10:
    movsbq %r10b, %rax
    movq %rax, %r15
    movq %r11, %rax
    shll $6, %eax
    movq %rax, -24(%rbp)
    movl %r15d, %eax
    addq -24(%rbp), %rax
    movl %eax, %eax
    movq %rax, %r15
    movq %r11, %rax
    shll $16, %eax
    movq %rax, -32(%rbp)
    movq %r15, %rax
    addq -32(%rbp), %rax
    movl %eax, %eax
    movq %r11, %rcx
    subq %r11, %rax
    movl %eax, %eax
    movq %rax, %r15
    movq %rax, %r14
.LBB11:
    movq %r13, %r12
    movq %r14, %r11
    jmp .LBB6
.LBB8:
    movq %r11, %r15
    xorl %edx, %edx
    movq %r11, -32(%rbp)
    movq %rdx, -24(%rbp)
    pushq %rdx
    pushq %r11
    movabsq $5165088340638674453, %rax
    xorl %edx, %edx
    movq %rax, %rcx
    movq %rdx, %rsi
    popq %rax
    popq %rdx
    pushq %rdx
    movq %rcx, %r8
    movq %rsi, %r9
    popq %rdi
    movq %rdi, %rcx
    imulq %r8, %rcx
    movq %rax, %rsi
    imulq %r9, %rsi
    mulq %r8
    addq %rcx, %rdx
    addq %rsi, %rdx
    movq %rdx, %rax
    xorl %edx, %edx
    movq %rax, -32(%rbp)
    movq %rdx, -24(%rbp)
    movq %r11, %rbx
    subq %rax, %rbx
    movq %rbx, %r12
    shrq $1, %r12
    movq %r12, %r13
    addq %rax, %r13
    movq %r13, %r10
    shrq $7, %r10
    movq %r10, %r14
    imulq $200, %r10, %r14
    movq %r11, %r10
    subq %r14, %r10
    movl %r10d, %eax
    movq %rax, %r10
    movq -80(%rbp), %rbx
    movq -72(%rbp), %r12
    movq -64(%rbp), %r13
    movq -56(%rbp), %r14
    movq -48(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.cfi_endproc
.size hash, .-hash

.globl init_table
.type init_table, @function
init_table:
.cfi_startproc
    pushq %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq $16, %rsp
    movq %rbx, -16(%rbp)
    movq %rdi, %rbx
    movq %rdi, %rax
    xorl %edi, %eax
    movq %rax, %rsi
    movq $3200, %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call memset
    xorl %eax, %eax
    movl %eax, 3200(%rbx)
    movq %rax, 3208(%rbx)
    movq -16(%rbp), %rbx
    movq %rbp, %rsp
    popq %rbp
    ret
.cfi_endproc
.size init_table, .-init_table

.globl insert
.type insert, @function
insert:
.cfi_startproc
    pushq %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq %rsp, %rbp
    .cfi_def_cfa_register %rbp
    subq $128, %rsp
    movq %rbx, -128(%rbp)
    movq %r12, -120(%rbp)
    movq %r13, -112(%rbp)
    movq %r14, -104(%rbp)
    movq %r15, -96(%rbp)
    movq %rdi, -8(%rbp)
    movq %rsi, -16(%rbp)
    movq -8(%rbp), %rax
    leaq 3208(%rax), %rax
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    xorl %eax, %eax
    movq %rax, -40(%rbp)
    movq %rax, -48(%rbp)
    movq %rax, -56(%rbp)
.LBB15:
    movq -48(%rbp), %rax
    cltq
    movq %rax, -88(%rbp)
    cmpl $100, %eax
    jl .LBB55
    jmp .LBB18
.LBB19:
    movslq %ebx, %rax
    movq %rax, %r14
    cmpl $2, %eax
    jge .LBB17
.LBB20:
    movq %r12, %rdi
    movq %rbx, %rax
    movq %rbx, %rsi
    xorl %ebx, %eax
    call hash
    movq %rax, %r15
    movl %eax, %eax
    movq %rax, %r13
    movl %eax, %eax
    movq %rax, %r10
    movq %r14, %rdi
    imulq $1600, %r14, %rdi
    movq -8(%rbp), %rcx
    movq %rdi, %rax
    addq %rcx, %rax
    movq %rax, -88(%rbp)
    movq %r10, %rsi
    shlq $3, %rsi
    movq %rax, %rcx
    movq %rsi, %rax
    addq %rcx, %rax
    movq %rax, -80(%rbp)
    movq %rax, %rcx
    movq (%rcx), %rax
    movq %rax, %r9
    testq %rax, %rax
    jne .LBB25
.LBB23:
    movq %r12, %rdx
    movq -80(%rbp), %rcx
    movq %rdx, (%rcx)
    movq -8(%rbp), %rax
    leaq 3200(%rax), %rax
    movq %rax, %r15
    movq %rax, %rcx
    movslq (%rcx), %rax
    movq %rax, %r14
    addq $1, %rax
    cltq
    movq %rax, %rdx
    movq %r15, %rcx
    movl %edx, (%rcx)
    movq $1, %rax
    movq -128(%rbp), %rbx
    movq -120(%rbp), %r12
    movq -112(%rbp), %r13
    movq -104(%rbp), %r14
    movq -96(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB25:
    movq -24(%rbp), %rcx
    movq (%rcx), %rax
    movq %rax, %r10
    movq %rax, %rsi
    addq $1, %rsi
    movq %rsi, %rdx
    movq -24(%rbp), %rcx
    movq %rdx, (%rcx)
    movq -80(%rbp), %rcx
    movq (%rcx), %rax
    movq %rax, %r11
    movq %r12, %rdx
    movq -80(%rbp), %rcx
    movq %rdx, (%rcx)
    movq %rbx, %r9
    addq $1, %r9
    movslq %r9d, %rax
    movq %rax, %r8
    movq %r11, %r12
    movq %rax, %rbx
    movq %r11, -64(%rbp)
    movq %r13, %rax
    movq %r13, -72(%rbp)
    jmp .LBB19
.LBB17:
    movq -48(%rbp), %r10
    addq $1, %r10
    movslq %r10d, %rax
    movq %rax, %rdi
    movq %r12, -32(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -40(%rbp)
    movq %rdi, -48(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -56(%rbp)
    jmp .LBB15
.LBB18:
    xorl %eax, %eax
    movq -128(%rbp), %rbx
    movq -120(%rbp), %r12
    movq -112(%rbp), %r13
    movq -104(%rbp), %r14
    movq -96(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB55:
    movq -32(%rbp), %rax
    movq %rax, %r12
    xorl %eax, %eax
    movq %rax, %rbx
    movq -40(%rbp), %rax
    movq %rax, -64(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -72(%rbp)
    jmp .LBB19
.cfi_endproc
.size insert, .-insert

.globl main
.type main, @function
main:
.cfi_startproc
    pushq %rbp
    .cfi_def_cfa_offset 16
    .cfi_offset %rbp, -16
    movq %rsp, %rbp
    .cfi_def_cfa_register %rbp
    movq $59136, %r11
.Lstack_probe_0:
    subq $4096, %rsp
    orl $0, (%rsp)
    subq $4096, %r11
    cmpq $4096, %r11
    ja .Lstack_probe_0
    subq %r11, %rsp
    orl $0, (%rsp)
    movq %rbx, -59136(%rbp)
    movq %r12, -59128(%rbp)
    movq %r13, -59120(%rbp)
    movq %r14, -59112(%rbp)
    movq %r15, -59104(%rbp)
    leaq .Lstr0(%rip), %rax
    movq %rax, -59064(%rbp)
    leaq .Lstr1(%rip), %rax
    movq %rax, -59072(%rbp)
    movq -59064(%rbp), %rax
    movq %rax, %rdi
    movq -59072(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call fopen
    movq %rax, -58936(%rbp)
    testq %rax, %rax
    jne .LBB31
.LBB29:
    movq $1, %rax
    movq -59136(%rbp), %rbx
    movq -59128(%rbp), %r12
    movq -59120(%rbp), %r13
    movq -59112(%rbp), %r14
    movq -59104(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB31:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq $512, %rax
    movq %rax, %rsi
    movq -58936(%rbp), %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call fgets
    leaq .Lstr5(%rip), %rax
    movq %rax, -58944(%rbp)
    leaq .Lstr4(%rip), %rax
    movq %rax, -58952(%rbp)
    leaq .Lstr3(%rip), %rax
    movq %rax, -58960(%rbp)
    leaq .Lstr2(%rip), %rax
    movq %rax, -58968(%rbp)
    xorl %eax, %eax
    movq %rax, -58976(%rbp)
    movq %rax, %r15
    leaq -55200(%rbp), %rax
    movq %rax, -58984(%rbp)
    leaq -55200(%rbp), %rax
    movq %rax, -58992(%rbp)
    leaq -55200(%rbp), %rax
    movq %rax, -59000(%rbp)
.LBB33:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq $512, %rax
    movq %rax, %rsi
    movq -58936(%rbp), %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call fgets
    movq %rax, -59064(%rbp)
    movslq %r15d, %rax
    movq %rax, %r12
    cmpl $200, %eax
    setl %al
    movzbq %al, %rax
    movq %rax, -59072(%rbp)
    xorl %eax, %eax
    movq -59072(%rbp), %rcx
    movq -59064(%rbp), %rdx
    testq %rdx, %rdx
    cmovneq %rcx, %rax
    testq %rax, %rax
    je .LBB35
.LBB34:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq -58968(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcspn
    movq %rax, -59064(%rbp)
    leaq -55712(%rbp), %rcx
    addq %rcx, %rax
    movq %rax, -59072(%rbp)
    xorl %eax, %eax
    movq %rax, %rdx
    movq -59072(%rbp), %rcx
    movb %dl, (%rcx)
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq -58960(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, -59008(%rbp)
    testq %rax, %rax
    je .LBB40
.LBB38:
    movq -58984(%rbp), %rax
    movq %rax, %rdi
    movq -59008(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB40:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58952(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, %r14
    testq %rax, %rax
    je .LBB56
.LBB41:
    movq -59000(%rbp), %rax
    leaq 256(%rax), %rax
    movq %rax, -59064(%rbp)
    movq %r14, %rax
    movq %r14, %rdi
    xorl %r14d, %eax
    movq %rax, %rsi
    movq $10, %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call strtol
    movq %rax, -59072(%rbp)
    cltq
    movq %rax, %rdx
    movq -59064(%rbp), %rcx
    movl %edx, (%rcx)
    movq %r14, %rax
    movq %r14, -59008(%rbp)
.LBB43:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58944(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, -59016(%rbp)
    testq %rax, %rax
    je .LBB46
.LBB44:
    movq -58992(%rbp), %rax
    leaq 260(%rax), %rax
    movq %rax, -59064(%rbp)
    movq %rax, %rdi
    movq -59016(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB46:
    movq %r15, %rax
    addq $1, %rax
    cltq
    movq %rax, -59064(%rbp)
    movq -58984(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59072(%rbp)
    movq -58992(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59080(%rbp)
    movq -59000(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59088(%rbp)
    movq -59008(%rbp), %rax
    movq %rax, -58976(%rbp)
    movq -59064(%rbp), %rax
    movq %rax, %r15
    movq -59072(%rbp), %rax
    movq %rax, -58984(%rbp)
    movq -59080(%rbp), %rax
    movq %rax, -58992(%rbp)
    movq -59088(%rbp), %rax
    movq %rax, -59000(%rbp)
    jmp .LBB33
.LBB35:
    movq -58936(%rbp), %rax
    movq %rax, %rdi
    xorl %eax, %eax
    call fclose
    xorl %eax, %eax
    movq %rax, -59032(%rbp)
    movq %rax, %r14
    movq %rax, -59040(%rbp)
    movq %rax, -59048(%rbp)
.LBB47:
    movslq %r14d, %rax
    movq %rax, -59064(%rbp)
    cmpl $10, %eax
    jge .LBB50
.LBB48:
    leaq -58928(%rbp), %rax
    movq %rax, %rdi
    xorl %eax, %eax
    call init_table
    xorl %eax, %eax
    call clock
    movq %rax, -59056(%rbp)
    xorl %eax, %eax
    movq %rax, %rbx
    leaq -55200(%rbp), %rax
    movq %rax, %r13
.LBB51:
    movslq %ebx, %rax
    movq %rax, %r8
    cmpl %r12d, %eax
    jge .LBB54
.LBB52:
    leaq -58928(%rbp), %rax
    movq %rax, %rdi
    movq %r13, %rax
    movq %r13, %rsi
    xorl %r13d, %eax
    call insert
    movq %rbx, %rdi
    addq $1, %rdi
    movslq %edi, %rax
    movq %rax, %r11
    movq %r13, %rax
    leaq 276(%rax), %rax
    movq %rax, %r10
    movq %r11, %rbx
    movq %rax, %r13
    jmp .LBB51
.LBB54:
    xorl %eax, %eax
    call clock
    movq %rax, %rbx
    movq %rax, %r9
    subq -59056(%rbp), %r9
    cvtsi2sdq %r9, %xmm0
    movq %xmm0, %rax
    movq %rax, %xmm0
    movabsq $4696837146684686336, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59072(%rbp)
    movq -59040(%rbp), %rax
    movq %rax, %xmm0
    movq -59072(%rbp), %rcx
    movq %rcx, %xmm1
    addsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59064(%rbp)
    movslq -55728(%rbp), %rax
    movq %rax, %rdi
    cvtsi2ssq %rax, %xmm0
    movd %xmm0, %eax
    movd %eax, %xmm0
    movq $1137180672, %rcx
    movd %ecx, %xmm1
    divss %xmm1, %xmm0
    movd %xmm0, %eax
    movq %rax, -59080(%rbp)
    movq -59032(%rbp), %rax
    movd %eax, %xmm0
    movq -59080(%rbp), %rcx
    movd %ecx, %xmm1
    addss %xmm1, %xmm0
    movd %xmm0, %eax
    movq %rax, -59072(%rbp)
    movq -55720(%rbp), %rax
    movq %rax, %r11
    movq -59048(%rbp), %rsi
    addq %rax, %rsi
    movq %r14, %r10
    addq $1, %r10
    movslq %r10d, %rax
    movq %rax, %r8
    movq -59072(%rbp), %rax
    movq %rax, -59032(%rbp)
    movq %r8, %r14
    movq -59064(%rbp), %rax
    movq %rax, -59040(%rbp)
    movq %rsi, %rax
    movq %rsi, -59048(%rbp)
    jmp .LBB47
.LBB50:
    leaq .Lstr6(%rip), %rax
    movq %rax, %r13
    movq -59040(%rbp), %rax
    movq %rax, %xmm0
    movabsq $4621819117588971520, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59064(%rbp)
    movq -59032(%rbp), %rax
    movd %eax, %xmm0
    movq $1092616192, %rcx
    movd %ecx, %xmm1
    divss %xmm1, %xmm0
    movd %xmm0, %eax
    movd %eax, %xmm0
    cvtss2sd %xmm0, %xmm0
    movq %xmm0, %rax
    movq %rax, -59072(%rbp)
    movq -59048(%rbp), %rax
    cvtsi2sdq %rax, %xmm0
    movq %xmm0, %rax
    movq %rax, -59080(%rbp)
    movq %rax, %xmm0
    movabsq $4621819117588971520, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59088(%rbp)
    movq %r13, %rdi
    movq -59064(%rbp), %rax
    movq %rax, %xmm0
    movq -59072(%rbp), %rax
    movq %rax, %xmm1
    movq -59088(%rbp), %rax
    movq %rax, %xmm2
    movb $3, %al
    call printf
    xorl %eax, %eax
    movq -59136(%rbp), %rbx
    movq -59128(%rbp), %r12
    movq -59120(%rbp), %r13
    movq -59112(%rbp), %r14
    movq -59104(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB56:
    movq -58976(%rbp), %rax
    movq %rax, -59008(%rbp)
    jmp .LBB43
.cfi_endproc
.size main, .-main


.section .note.GNU-stack,"",@progbits

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
    .byte 66, 108, 111, 99, 107, 101, 100, 32, 67, 117, 99, 107, 111, 111, 32, 40, 98, 61, 52, 41, 58, 32, 65, 118, 103, 84, 105, 109, 101, 61, 37, 46
    .byte 56, 102, 44, 32, 65, 118, 103, 76, 70, 61, 37, 46, 52, 102, 44, 32, 65, 118, 103, 68, 105, 115, 112, 61, 37, 46, 50, 102, 10, 0

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
    shrq $5, %r10
    movq %r10, %r14
    imulq $50, %r10, %r14
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
    subq $176, %rsp
    movq %rbx, -176(%rbp)
    movq %r12, -168(%rbp)
    movq %r13, -160(%rbp)
    movq %r14, -152(%rbp)
    movq %r15, -144(%rbp)
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
    movq %rax, -64(%rbp)
    movq %rax, -72(%rbp)
.LBB15:
    movq -56(%rbp), %rax
    cltq
    movq %rax, -128(%rbp)
    cmpl $100, %eax
    jl .LBB59
    jmp .LBB18
.LBB19:
    movslq %r12d, %rax
    movq %rax, %r15
    cmpl $2, %eax
    jge .LBB17
.LBB20:
    movq %r13, %rdi
    movq %r12, %rax
    movq %r12, %rsi
    xorl %r12d, %eax
    call hash
    movl %eax, %eax
    movq %rax, %r14
    movq %r15, %rax
    imulq $1600, %r15, %rax
    addq -8(%rbp), %rax
    movq %rax, -136(%rbp)
    movl %r14d, %eax
    movq %rax, -128(%rbp)
    shlq $5, %rax
    addq -136(%rbp), %rax
    movq %rax, -112(%rbp)
    xorl %eax, %eax
    movq %rax, %rbx
    movq -112(%rbp), %rax
    movq %rax, -120(%rbp)
.LBB23:
    movslq %ebx, %rax
    movq %rax, %r8
    cmpl $4, %eax
    jge .LBB26
.LBB24:
    movq -120(%rbp), %rcx
    movq (%rcx), %rax
    movq %rax, %rdi
    testq %rax, %rax
    jne .LBB25
.LBB27:
    movq %r13, %rdx
    movq -120(%rbp), %rcx
    movq %rdx, (%rcx)
    movq -8(%rbp), %rax
    leaq 3200(%rax), %rax
    movq %rax, -128(%rbp)
    movq %rax, %rcx
    movslq (%rcx), %rax
    movq %rax, -136(%rbp)
    addq $1, %rax
    cltq
    movq %rax, %rdx
    movq -128(%rbp), %rcx
    movl %edx, (%rcx)
    movq $1, %rax
    movq -176(%rbp), %rbx
    movq -168(%rbp), %r12
    movq -160(%rbp), %r13
    movq -152(%rbp), %r14
    movq -144(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB25:
    movq %rbx, %r8
    addq $1, %r8
    movslq %r8d, %rax
    movq %rax, %r11
    movq -120(%rbp), %rax
    leaq 8(%rax), %rax
    movq %rax, %r10
    movq %r11, %rbx
    movq %rax, -120(%rbp)
    jmp .LBB23
.LBB26:
    movq -24(%rbp), %rcx
    movq (%rcx), %rax
    movq %rax, %r11
    movq %rax, %r10
    addq $1, %r10
    movq %r10, %rax
    movq %r10, %rdx
    movq -24(%rbp), %rcx
    movq %rdx, (%rcx)
    xorl %eax, %eax
    call rand
    movq %rax, %r15
    cltq
    movq %rax, %r10
    sarq $63, %r10
    movq %r10, %r11
    shrq $62, %r11
    movq %rax, %r10
    addq %r11, %r10
    movq %r10, %r11
    sarq $2, %r11
    movq %r11, %r10
    shlq $2, %r10
    movq %rax, %r11
    subq %r10, %r11
    movslq %r11d, %rax
    movq %rax, %rdi
    movq %rax, %r9
    movq %rax, %r11
    shlq $3, %r11
    movq -112(%rbp), %rcx
    movq %r11, %rax
    addq %rcx, %rax
    movq %rax, %r15
    movq %rax, %rcx
    movq (%rcx), %rax
    movq %rax, %rsi
    movq %r13, %rdx
    movq %r15, %rcx
    movq %rdx, (%rcx)
    movq %r12, %r10
    addq $1, %r10
    movslq %r10d, %rax
    movq %rax, %r8
    movq %rsi, %r13
    movq %rdi, -80(%rbp)
    movq %r8, %r12
    movq %rbx, -88(%rbp)
    movq %rsi, -96(%rbp)
    movq %r14, %rax
    movq %r14, -104(%rbp)
    jmp .LBB19
.LBB17:
    movq -56(%rbp), %r11
    addq $1, %r11
    movslq %r11d, %rax
    movq %rax, %r9
    movq %r13, -32(%rbp)
    movq -80(%rbp), %rax
    movq %rax, -40(%rbp)
    movq -88(%rbp), %rax
    movq %rax, -48(%rbp)
    movq %r9, -56(%rbp)
    movq -96(%rbp), %rax
    movq %rax, -64(%rbp)
    movq -104(%rbp), %rax
    movq %rax, -72(%rbp)
    jmp .LBB15
.LBB18:
    xorl %eax, %eax
    movq -176(%rbp), %rbx
    movq -168(%rbp), %r12
    movq -160(%rbp), %r13
    movq -152(%rbp), %r14
    movq -144(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB59:
    movq -32(%rbp), %rax
    movq %rax, %r13
    movq -40(%rbp), %rax
    movq %rax, -80(%rbp)
    xorl %eax, %eax
    movq %rax, %r12
    movq -48(%rbp), %rax
    movq %rax, -88(%rbp)
    movq -64(%rbp), %rax
    movq %rax, -96(%rbp)
    movq -72(%rbp), %rax
    movq %rax, -104(%rbp)
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
    xorl %eax, %eax
    movq %rax, %rdi
    call time
    movq %rax, -59064(%rbp)
    movl %eax, %eax
    movq %rax, -59072(%rbp)
    movq %rax, %rdi
    xorl %eax, %eax
    call srand
    leaq .Lstr0(%rip), %rax
    movq %rax, -59072(%rbp)
    leaq .Lstr1(%rip), %rax
    movq %rax, -59064(%rbp)
    movq -59072(%rbp), %rax
    movq %rax, %rdi
    movq -59064(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call fopen
    movq %rax, -58936(%rbp)
    testq %rax, %rax
    jne .LBB35
.LBB33:
    movq $1, %rax
    movq -59136(%rbp), %rbx
    movq -59128(%rbp), %r12
    movq -59120(%rbp), %r13
    movq -59112(%rbp), %r14
    movq -59104(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB35:
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
.LBB37:
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
    je .LBB39
.LBB38:
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
    je .LBB44
.LBB42:
    movq -58984(%rbp), %rax
    movq %rax, %rdi
    movq -59008(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB44:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58952(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, %r14
    testq %rax, %rax
    je .LBB60
.LBB45:
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
.LBB47:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58944(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, -59016(%rbp)
    testq %rax, %rax
    je .LBB50
.LBB48:
    movq -58992(%rbp), %rax
    leaq 260(%rax), %rax
    movq %rax, -59064(%rbp)
    movq %rax, %rdi
    movq -59016(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB50:
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
    jmp .LBB37
.LBB39:
    movq -58936(%rbp), %rax
    movq %rax, %rdi
    xorl %eax, %eax
    call fclose
    xorl %eax, %eax
    movq %rax, -59032(%rbp)
    movq %rax, %r14
    movq %rax, -59040(%rbp)
    movq %rax, -59048(%rbp)
.LBB51:
    movslq %r14d, %rax
    movq %rax, -59064(%rbp)
    cmpl $10, %eax
    jge .LBB54
.LBB52:
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
.LBB55:
    movslq %ebx, %rax
    movq %rax, %r8
    cmpl %r12d, %eax
    jge .LBB58
.LBB56:
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
    jmp .LBB55
.LBB58:
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
    jmp .LBB51
.LBB54:
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
.LBB60:
    movq -58976(%rbp), %rax
    movq %rax, -59008(%rbp)
    jmp .LBB47
.cfi_endproc
.size main, .-main


.section .note.GNU-stack,"",@progbits

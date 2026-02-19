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
    .byte 100, 45, 97, 114, 121, 32, 67, 117, 99, 107, 111, 111, 32, 40, 100, 61, 51, 41, 58, 32, 65, 118, 103, 84, 105, 109, 101, 61, 37, 46, 56, 102
    .byte 44, 32, 65, 118, 103, 76, 70, 61, 37, 46, 52, 102, 44, 32, 65, 118, 103, 68, 105, 115, 112, 61, 37, 46, 50, 102, 10, 0

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
    subq $96, %rsp
    movq %rbx, -96(%rbp)
    movq %r12, -88(%rbp)
    movq %r13, -80(%rbp)
    movq %r14, -72(%rbp)
    movq %r15, -64(%rbp)
    movq %rsi, -16(%rbp)
    movq %rdi, -8(%rbp)
    movslq -16(%rbp), %rax
    movq %rax, -16(%rbp)
    movq %rax, -32(%rbp)
    testl %eax, %eax
    sete %al
    movzbq %al, %rax
    movq %rax, %rbx
    movq -32(%rbp), %rax
    cmpl $1, %eax
    sete %al
    movzbq %al, %rax
    movq %rax, %r12
    movq $131, %rax
    xorl %ecx, %ecx
    testq %r12, %r12
    cmovneq %rcx, %rax
    movq %rax, -32(%rbp)
    movq $5381, %rcx
    movq %rbx, %rdx
    testq %rbx, %rbx
    cmovneq %rcx, %rax
    movq %rax, -40(%rbp)
    movq -8(%rbp), %rax
    movq %rax, %r13
    movq -40(%rbp), %rax
    movq %rax, %r11
.LBB9:
    movq %r13, %r14
    addq $1, %r14
    movq %r13, %rcx
    movsbq (%rcx), %rax
    movq %rax, %r10
    movsbq %al, %rax
    testq %rax, %rax
    je .LBB11
.LBB10:
    movq %rbx, %rax
    testq %rbx, %rbx
    je .LBB13
.LBB12:
    movq %r11, %rax
    shll $5, %eax
    addq %r11, %rax
    movl %eax, %eax
    movq %rax, -32(%rbp)
    movsbq %r10b, %rax
    movl %eax, %eax
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    addq -40(%rbp), %rax
    movl %eax, %eax
    movq %rax, -40(%rbp)
    movq %rax, %r15
    jmp .LBB14
.LBB13:
    movq %r12, %rax
    testq %r12, %r12
    je .LBB16
.LBB15:
    movsbq %r10b, %rax
    movq %rax, -32(%rbp)
    movq %r11, %rax
    shll $6, %eax
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    movl %eax, %eax
    addq -40(%rbp), %rax
    movl %eax, %eax
    movq %rax, -40(%rbp)
    movq %r11, %rax
    shll $16, %eax
    movq %rax, -48(%rbp)
    movq -40(%rbp), %rax
    addq -48(%rbp), %rax
    movl %eax, %eax
    movq %r11, %rcx
    subq %r11, %rax
    movl %eax, %eax
    movq %rax, -48(%rbp)
    movq %rax, -24(%rbp)
    jmp .LBB17
.LBB16:
    movq %r11, %rax
    shll $5, %eax
    addq %r11, %rax
    movl %eax, %eax
    movq %rax, -32(%rbp)
    movsbq %r10b, %rax
    movl %eax, %eax
    movq %rax, -40(%rbp)
    movq -32(%rbp), %rax
    addq -40(%rbp), %rax
    movl %eax, %eax
    movq %rax, -40(%rbp)
    movq %rax, -24(%rbp)
.LBB17:
    movq -24(%rbp), %rax
    movq %rax, %r15
.LBB14:
    movq %r14, %r13
    movq %r15, %r11
    jmp .LBB9
.LBB11:
    movq %r11, %r10
    xorl %edx, %edx
    movq %r11, -40(%rbp)
    movq %rdx, -32(%rbp)
    pushq %rdx
    pushq %r11
    movabsq $-825973615240726191, %rax
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
    movq %rdx, -48(%rbp)
    movq %rdx, %rax
    xorl %edx, %edx
    movq %rax, -40(%rbp)
    movq %rdx, -32(%rbp)
    movq %rax, %rbx
    shrq $7, %rbx
    movq %rbx, %r10
    imulq $134, %rbx, %r10
    movq %r11, %r12
    subq %r10, %r12
    movl %r12d, %eax
    movq %rax, %r10
    movl %eax, %eax
    movq -96(%rbp), %rbx
    movq -88(%rbp), %r12
    movq -80(%rbp), %r13
    movq -72(%rbp), %r14
    movq -64(%rbp), %r15
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
    movq $3216, %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call memset
    xorl %eax, %eax
    movl %eax, 3216(%rbx)
    movq %rax, 3224(%rbx)
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
    leaq 3224(%rax), %rax
    movq %rax, -24(%rbp)
    movq -16(%rbp), %rax
    movq %rax, -32(%rbp)
    xorl %eax, %eax
    movq %rax, -40(%rbp)
    movq %rax, -48(%rbp)
    movq %rax, -56(%rbp)
.LBB21:
    movq -48(%rbp), %rax
    cltq
    movq %rax, -88(%rbp)
    cmpl $100, %eax
    jl .LBB61
    jmp .LBB24
.LBB25:
    movslq %ebx, %rax
    movq %rax, %r14
    cmpl $3, %eax
    jge .LBB23
.LBB26:
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
    imulq $1072, %r14, %rdi
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
    jne .LBB31
.LBB29:
    movq %r12, %rdx
    movq -80(%rbp), %rcx
    movq %rdx, (%rcx)
    movq -8(%rbp), %rax
    leaq 3216(%rax), %rax
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
.LBB31:
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
    jmp .LBB25
.LBB23:
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
    jmp .LBB21
.LBB24:
    xorl %eax, %eax
    movq -128(%rbp), %rbx
    movq -120(%rbp), %r12
    movq -112(%rbp), %r13
    movq -104(%rbp), %r14
    movq -96(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB61:
    movq -32(%rbp), %rax
    movq %rax, %r12
    xorl %eax, %eax
    movq %rax, %rbx
    movq -40(%rbp), %rax
    movq %rax, -64(%rbp)
    movq -56(%rbp), %rax
    movq %rax, -72(%rbp)
    jmp .LBB25
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
    movq $59152, %r11
.Lstack_probe_0:
    subq $4096, %rsp
    orl $0, (%rsp)
    subq $4096, %r11
    cmpq $4096, %r11
    ja .Lstack_probe_0
    subq %r11, %rsp
    orl $0, (%rsp)
    movq %rbx, -59152(%rbp)
    movq %r12, -59144(%rbp)
    movq %r13, -59136(%rbp)
    movq %r14, -59128(%rbp)
    movq %r15, -59120(%rbp)
    leaq .Lstr0(%rip), %rax
    movq %rax, -59080(%rbp)
    leaq .Lstr1(%rip), %rax
    movq %rax, -59088(%rbp)
    movq -59080(%rbp), %rax
    movq %rax, %rdi
    movq -59088(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call fopen
    movq %rax, -58952(%rbp)
    testq %rax, %rax
    jne .LBB37
.LBB35:
    movq $1, %rax
    movq -59152(%rbp), %rbx
    movq -59144(%rbp), %r12
    movq -59136(%rbp), %r13
    movq -59128(%rbp), %r14
    movq -59120(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB37:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq $512, %rax
    movq %rax, %rsi
    movq -58952(%rbp), %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call fgets
    leaq .Lstr5(%rip), %rax
    movq %rax, -58960(%rbp)
    leaq .Lstr4(%rip), %rax
    movq %rax, -58968(%rbp)
    leaq .Lstr3(%rip), %rax
    movq %rax, -58976(%rbp)
    leaq .Lstr2(%rip), %rax
    movq %rax, -58984(%rbp)
    xorl %eax, %eax
    movq %rax, -58992(%rbp)
    movq %rax, %r15
    leaq -55200(%rbp), %rax
    movq %rax, -59000(%rbp)
    leaq -55200(%rbp), %rax
    movq %rax, -59008(%rbp)
    leaq -55200(%rbp), %rax
    movq %rax, -59016(%rbp)
.LBB39:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq $512, %rax
    movq %rax, %rsi
    movq -58952(%rbp), %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call fgets
    movq %rax, -59080(%rbp)
    movslq %r15d, %rax
    movq %rax, %r12
    cmpl $200, %eax
    setl %al
    movzbq %al, %rax
    movq %rax, -59088(%rbp)
    xorl %eax, %eax
    movq -59088(%rbp), %rcx
    movq -59080(%rbp), %rdx
    testq %rdx, %rdx
    cmovneq %rcx, %rax
    testq %rax, %rax
    je .LBB41
.LBB40:
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq -58984(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcspn
    movq %rax, -59080(%rbp)
    leaq -55712(%rbp), %rcx
    addq %rcx, %rax
    movq %rax, -59088(%rbp)
    xorl %eax, %eax
    movq %rax, %rdx
    movq -59088(%rbp), %rcx
    movb %dl, (%rcx)
    leaq -55712(%rbp), %rax
    movq %rax, %rdi
    movq -58976(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, -59024(%rbp)
    testq %rax, %rax
    je .LBB46
.LBB44:
    movq -59000(%rbp), %rax
    movq %rax, %rdi
    movq -59024(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB46:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58968(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, %r14
    testq %rax, %rax
    je .LBB62
.LBB47:
    movq -59016(%rbp), %rax
    leaq 256(%rax), %rax
    movq %rax, -59080(%rbp)
    movq %r14, %rax
    movq %r14, %rdi
    xorl %r14d, %eax
    movq %rax, %rsi
    movq $10, %rax
    movq %rax, %rdx
    xorl %eax, %eax
    call strtol
    movq %rax, -59088(%rbp)
    cltq
    movq %rax, %rdx
    movq -59080(%rbp), %rcx
    movl %edx, (%rcx)
    movq %r14, %rax
    movq %r14, -59024(%rbp)
.LBB49:
    xorl %eax, %eax
    movq %rax, %rdi
    movq -58960(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strtok
    movq %rax, -59032(%rbp)
    testq %rax, %rax
    je .LBB52
.LBB50:
    movq -59008(%rbp), %rax
    leaq 260(%rax), %rax
    movq %rax, -59080(%rbp)
    movq %rax, %rdi
    movq -59032(%rbp), %rax
    movq %rax, %rsi
    xorl %eax, %eax
    call strcpy
.LBB52:
    movq %r15, %rax
    addq $1, %rax
    cltq
    movq %rax, -59080(%rbp)
    movq -59000(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59088(%rbp)
    movq -59008(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59096(%rbp)
    movq -59016(%rbp), %rax
    leaq 276(%rax), %rax
    movq %rax, -59104(%rbp)
    movq -59024(%rbp), %rax
    movq %rax, -58992(%rbp)
    movq -59080(%rbp), %rax
    movq %rax, %r15
    movq -59088(%rbp), %rax
    movq %rax, -59000(%rbp)
    movq -59096(%rbp), %rax
    movq %rax, -59008(%rbp)
    movq -59104(%rbp), %rax
    movq %rax, -59016(%rbp)
    jmp .LBB39
.LBB41:
    movq -58952(%rbp), %rax
    movq %rax, %rdi
    xorl %eax, %eax
    call fclose
    xorl %eax, %eax
    movq %rax, -59048(%rbp)
    movq %rax, %r14
    movq %rax, -59056(%rbp)
    movq %rax, -59064(%rbp)
.LBB53:
    movslq %r14d, %rax
    movq %rax, -59080(%rbp)
    cmpl $10, %eax
    jge .LBB56
.LBB54:
    leaq -58944(%rbp), %rax
    movq %rax, %rdi
    xorl %eax, %eax
    call init_table
    xorl %eax, %eax
    call clock
    movq %rax, -59072(%rbp)
    xorl %eax, %eax
    movq %rax, %rbx
    leaq -55200(%rbp), %rax
    movq %rax, %r13
.LBB57:
    movslq %ebx, %rax
    movq %rax, %r8
    cmpl %r12d, %eax
    jge .LBB60
.LBB58:
    leaq -58944(%rbp), %rax
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
    jmp .LBB57
.LBB60:
    xorl %eax, %eax
    call clock
    movq %rax, %rbx
    movq %rax, %r9
    subq -59072(%rbp), %r9
    cvtsi2sdq %r9, %xmm0
    movq %xmm0, %rax
    movq %rax, %xmm0
    movabsq $4696837146684686336, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59088(%rbp)
    movq -59056(%rbp), %rax
    movq %rax, %xmm0
    movq -59088(%rbp), %rcx
    movq %rcx, %xmm1
    addsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59080(%rbp)
    movslq -55728(%rbp), %rax
    movq %rax, %rdi
    cvtsi2ssq %rax, %xmm0
    movd %xmm0, %eax
    movd %eax, %xmm0
    movq $1137246208, %rcx
    movd %ecx, %xmm1
    divss %xmm1, %xmm0
    movd %xmm0, %eax
    movq %rax, -59096(%rbp)
    movq -59048(%rbp), %rax
    movd %eax, %xmm0
    movq -59096(%rbp), %rcx
    movd %ecx, %xmm1
    addss %xmm1, %xmm0
    movd %xmm0, %eax
    movq %rax, -59088(%rbp)
    movq -55720(%rbp), %rax
    movq %rax, %r11
    movq -59064(%rbp), %rsi
    addq %rax, %rsi
    movq %r14, %r10
    addq $1, %r10
    movslq %r10d, %rax
    movq %rax, %r8
    movq -59088(%rbp), %rax
    movq %rax, -59048(%rbp)
    movq %r8, %r14
    movq -59080(%rbp), %rax
    movq %rax, -59056(%rbp)
    movq %rsi, %rax
    movq %rsi, -59064(%rbp)
    jmp .LBB53
.LBB56:
    leaq .Lstr6(%rip), %rax
    movq %rax, %r13
    movq -59056(%rbp), %rax
    movq %rax, %xmm0
    movabsq $4621819117588971520, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59080(%rbp)
    movq -59048(%rbp), %rax
    movd %eax, %xmm0
    movq $1092616192, %rcx
    movd %ecx, %xmm1
    divss %xmm1, %xmm0
    movd %xmm0, %eax
    movd %eax, %xmm0
    cvtss2sd %xmm0, %xmm0
    movq %xmm0, %rax
    movq %rax, -59088(%rbp)
    movq -59064(%rbp), %rax
    cvtsi2sdq %rax, %xmm0
    movq %xmm0, %rax
    movq %rax, -59096(%rbp)
    movq %rax, %xmm0
    movabsq $4621819117588971520, %rcx
    movq %rcx, %xmm1
    divsd %xmm1, %xmm0
    movq %xmm0, %rax
    movq %rax, -59104(%rbp)
    movq %r13, %rdi
    movq -59080(%rbp), %rax
    movq %rax, %xmm0
    movq -59088(%rbp), %rax
    movq %rax, %xmm1
    movq -59104(%rbp), %rax
    movq %rax, %xmm2
    movb $3, %al
    call printf
    xorl %eax, %eax
    movq -59152(%rbp), %rbx
    movq -59144(%rbp), %r12
    movq -59136(%rbp), %r13
    movq -59128(%rbp), %r14
    movq -59120(%rbp), %r15
    movq %rbp, %rsp
    popq %rbp
    ret
.LBB62:
    movq -58992(%rbp), %rax
    movq %rax, -59024(%rbp)
    jmp .LBB49
.cfi_endproc
.size main, .-main


.section .note.GNU-stack,"",@progbits

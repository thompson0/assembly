.global _start
.intel_syntax noprefix

.section .data 
    n1: .quad 12 
    n2: .quad 2
    newline: .asciz "\n"

.section .bss
    buffer: .skip 32

.section .text

_start:

    # adição
    mov rax, [n1]
    add rax, [n2]
    call print_rax

    # subtração
    mov rax, [n1]
    sub rax, [n2]
    call print_rax

    # multiplicação
    mov rax, [n1]
    imul rax, [n2]
    call print_rax

    # divisão
    mov rax, [n1]
    xor rdx, rdx          # zera rdx para divisão correta
    div qword ptr [n2]
    call print_rax

    # sair do programa
    mov rax, 60
    xor rdi, rdi
    syscall

print_rax:
    mov rcx, 10
    lea rsi, [buffer + 31]
    mov byte ptr [rsi], 0
    dec rsi

    mov rbx, rax        # salva valor original
    mov rax, rbx        # prepara divisão

    cmp rax, 0
    jne .convert_loop

    # caso o número seja zero, imprime '0'
    mov byte ptr [rsi], '0'
    dec rsi
    jmp .print_number

.convert_loop:
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .convert_loop

.print_number:
    inc rsi
    lea rdx, [buffer + 32]
    sub rdx, rsi
    mov rax, 1          # syscall write
    mov rdi, 1          # stdout
    # rsi já aponta para o início da string
    syscall

    # printa nova linha
    mov rax, 1
    mov rdi, 1
    lea rsi, [newline]
    mov rdx, 1
    syscall

    ret

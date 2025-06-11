.global _start
.intel_syntax noprefix

_start:
    CALL print_hello_world # chama a funcao e volta aqui
    JMP exit # usado quando voce nao precisa voltar

print_hello_world:
    MOV rax, 0x01  # syscall: write
    MOV rdi, 0x01  # file descriptor: stdout
    LEA rsi, [hello_str] #pointer to string
    MOV rdx, 14 #numero de caracteres
    SYSCALL
    RET
    
exit:
    MOV rax, 0x3c #syscall exit
    MOV rdi, 0    #exit code 0, 1 e pra executar e 2 e erro 
    SYSCALL

.section .data 
    hello_str: .asciz "hello, world\n" # variavel
    
;Este programa soma duas variaveis, coloca a soma em address3 e dá print no ecra

.8086
.model small
.stack 2048

dseg segment para public 'data'
     start db 'Mensagem para contar espacos em branco',0
     space db 0

dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax
     
     xor ax,ax
     xor cl,cl

     lea bx , start           ; isto faz um ponteiro a apontar para start
     
;__________
ciclo:
     mov al , [bx]            ; colocar em al o valor apontado pelo bx
     inc bx

     cmp al , 0               ; isto server para ver se já cheguei ao fim da string
     je fim                   ; se já n houver mais elementos fazer isto

     cmp al , 20h             ; comparar o valor com um espaço em branco(20h = ascii de espaço)              ou acho que tambem dá cmp al , ' '
     jne ciclo                ; se nao for espaço em branco vai para o ciclo

     inc cl                   ; incrementar o contador de espacos em branco
     jmp ciclo                ; e volta tudo para cima outra vez
;___________
     mov space , cl

;_________
fim:
     mov al, 0                ; este al é tipo o return (0)
     mov ah, 4ch
     int 21h
main endp

PRINT PROC                    ;Procedimento para imprimir no ecra o digito em ax   
     
    ;initialize count
    mov cx,0
    mov dx,0
    label1:
        ; if ax is zero
        cmp ax,0
        je print1     
         
        ;initialize bx to 10
        mov bx,10       
         
        ; extract the last digit
        div bx                 
         
        ;push it in the stack
        push dx             
         
        ;increment the count
        inc cx             
         
        ;set dx to 0
        xor dx,dx
        jmp label1
    print1:
        ;check if count
        ;is greater than zero
        cmp cx,0
        je exit
         
        ;pop the top of stack
        pop dx
         
        ;add 48 so that it
        ;represents the ASCII
        ;value of digits
        add dx,48
         
        ;interrupt to print a
        ;character
        mov ah,02h
        int 21h
         
        ;decrease the count
        dec cx
        jmp print1
exit:
ret
PRINT ENDP



cseg ends

end main
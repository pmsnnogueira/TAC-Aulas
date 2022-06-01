;Este programa soma duas variaveis, coloca a soma em address3 e dá print no ecra

.8086
.model small
.stack 2048

dseg segment para public 'data'
     string  db 'String com MAIUSCULAS minusculas e numeros 1 2 3 4 5 6 $'
     num_MAI db 0
     num_MIN db 0
     num_DIG db 0

dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax

     lea si , string
ciclo:
     mov al , [si]
     cmp al , '$'
          je fim          ;Se for igual vai para o fim

     ;Agora verificar se é um caracter maiusculo -> o caracter ou é superior a 65 e menor que ...   Ou podemos usar os caracteres
     cmp al , 'A'
          jb Nao_E_MAIUSCULO
     cmp al , 'Z'
          ja NAO_E_MAIUSCULO

     inc num_MAI
     jmp PROXIMO

NAO_E_MAIUSCULO:
     cmp al , 'a'
          jb NAO_E_MINUSCULO
     cmp al , 'z'
          ja NAO_E_MINUSCULO
     inc num_MIN
     jmp PROXIMO

NAO_E_MINUSCULO:
     cmp al , '0'
          jb PROXIMO
     cmp al , '9'
          ja PROXIMO
     inc num_DIG
     jmp PROXIMO

PROXIMO:
     inc si
     jmp ciclo
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
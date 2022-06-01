;Este programa converte caracteres Maiusculos em minusculos

.8086
.model small
.stack 2048

dseg segment para public 'data'
     string  db 'String em MAIUSCULAS',0

dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax

     lea si , string
ciclo:
     mov al , [si]
     cmp al , 0
          je fim          ;Se for igual vai para o fim

     ;Agora verificar se é um caracter maiusculo -> o caracter ou é superior a 65 e menor que ...   Ou podemos usar os caracteres
     cmp al , 'A'
          jb NAO_E_MAIUSCULA
     cmp al , 'Z'
          ja NAO_E_MAIUSCULA

     add al , 20h             ; Ao fazer isto também dá -> add al , 'a' - 'A'   ,   Estou a incrementar 20h pq na tabela ascii a diferenca entre os caracteres maiusculos e minusculos é 20h
     mov [si] , al

NAO_E_MAIUSCULA:         ; Se for minusculo fazer isto
     inc si
     jmp ciclo

;_________
fim:
     mov al, 0                ; este al é tipo o return (0)
     mov ah, 4ch
     int 21h
main endp
cseg ends

end main
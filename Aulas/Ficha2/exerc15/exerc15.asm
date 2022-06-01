;Este programa converte caracteres Maiusculos em minusculos

.8086
.model small
.stack 2048

dseg segment para public 'data'
     vector  db 1,2,3,4,5,6,7,8,9,0
     somarImpar dw 0
dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax

     xor si , si
     xor dx ,dx          ;Este vai ser o nosso somador
     mov cx , 20         ;utilizador para o loop
ciclo:

     xor ax , ax
     mov al , vector[si]

     ;Agora fazer para saber se é um numero impar
     mov bl , 2
     div bl
     cmp ah , 0
          je NAO_E_IMPAR      ;Se entrar aqui é pq o numero é par
     
     add dl , vector[si]      
     adc dh ,0
     
NAO_E_IMPAR:         ; Se for minusculo fazer isto
     inc si
     cmp ax , 0          
     loopnz ciclo       ; ele decrementa o cx e salta para o ciclo se ax != 0 e o cx > 0

;No final mover para a variavel o resultado
     mov somarImpar , dx
     
;_________
fim:
     mov al, 0                ; este al é tipo o return (0)
     mov ah, 4ch
     int 21h
main endp
cseg ends

end main
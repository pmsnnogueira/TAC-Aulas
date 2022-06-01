;Este programa soma duas variaveis, faz a media e coloca a no Average
;Mas com procedimento
.8086
.model small
.stack 2048

dseg segment para public 'data'
     Address1 db 64H
     Address2 db 1100100b
     Average  db ?
dseg ends

;PILHA
STACK_HERE SEGMENT STACK
    DW 40 dup(?)
STACK_HERE ENDS


cseg segment para public 'code'
     assume cs:cseg, ds:dseg , ss: STACK_HERE
main proc
    mov ax, dseg
    mov ds, ax

    mov al , Address1 ;Mandar como parametros de entrada para o procedimento 
    mov ah , Address2 ;Mandar como parametros de entrada para o procedimento 
    call MEDIA
    mov Average , al    ;resultado de saida do procedimento

fim:
     mov al, 0
     mov ah, 4ch
     int 21h
main endp

MEDIA PROC                  ; (al , ah) parametros de entrada e (al) parametro de saida
    pushf                   ;Dar push nas flags e colocar em cima da pilhas
    push bx                 ;Agora já tenho os valores da main aqui

    ;Fazer soma
    add al , ah
    mov ah , 0
    adc ah , 0
    ;Fazer media
    mov bl , 2
    div bl                  ;al = ax/2
    
    ; Agora temos de mandar para a main ao contrario, da ordem do topo da pilha para baixo
    pop bx
    popf
    ret
MEDIA ENDP

cseg ends

end main
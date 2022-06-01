;Este programa soma duas variaveis, faz a media e coloca a no Average

.8086
.model small
.stack 2048

dseg segment para public 'data'
     Address1 db 64H
     Address2 db 1100100b
     Average  db ?
dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax
     
     xor ax,ax
;Fazer soma

     mov al , Address1
     add al , Address2
     adc ah , 0
     
     ;call PRINT
;Fazer media

     mov bl , 2
     div bl              ; al = ax/2

     mov Average , al

     mov al, 0
     mov ah, 4ch
     int 21h
main endp

PRINT PROC                              ;Procedimento para imprimir no ecra o digito em ax   
     
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
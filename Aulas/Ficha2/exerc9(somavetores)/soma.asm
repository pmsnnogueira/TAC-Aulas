;Este programa soma duas variaveis, coloca a soma em address3 e dá print no ecra

.8086
.model small
.stack 2048

dseg segment para public 'data'
     Vector1 db 1,2,3,4,5,6,7,8,9,10
     Vector2 db 11,12,13,14,15,16,17,18,19,20
     Vector3 dw 1o dup(?)
dseg ends

cseg segment para public 'code'
     assume cs:cseg, ds:dseg
main proc
     mov ax, dseg
     mov ds, ax
     
     xor ax,ax
     xor si,si
     xor di,di
     mov cx , 10

    ciclo:     
          mov al , Vector1[si]
          add al , Vector2[si]
          adc ah ,0
          mov Vector3[di] , ax

          inc si
          add di , 2
          
     loop ciclo


     mov al, 0                     ; este al é tipo o return 0
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
.8086
.model small
.stack 2048

dseg segment para public 'data'
	coluna db 5
dseg ends


cseg	segment para public 'code'
	assume  cs:cseg ,ds:dseg

Main  proc
	mov ax , dseg
	mov ds , ax

	mov   ax,0b800h
	mov   es,ax

	; objetivo meter o bx = coluna * 2
	mov al , coluna				;
	mov bl , 2
	mul bl						;		colocar o bx a apontar para o indice 0 da coluna 1		(=) (AX = al * bl)	(=)  ( ax = coluna *2 )	
	mov bx , ax					; 		colocar o resultado da soma em bx


	; objetivo si = bx + (20*2) (cada posicao vale 2 bytes)
	mov si , bx 										
	add si , 40	

	mov	cx , 25				; com o 25 vamos copiar as colunas a partir da variavel Coluna se quisessemos só uma linha era	
	mov ah , '*'
	
CICLO:
	mov es:[bx] , ah		; aqui meti caracteres na primeira linha para ser mais facil ver o resultado
	mov es:[bx+2] , ah		; aqui meti caracteres na primeira linha para ser mais facil ver o resultado

	mov ax , es:[bx] 		; colocar o valor da posicao es:[bx] em ax
	mov es:[si] , ax		; colocar o valor de ax na posicao es:[si] que é copiar da linha para a 15 linha
	
	mov ax , es:[bx+2]		; colocar tambem o valor da coluna ao lado
	mov es:[si+2] , ax		; copiar o da coluna ao lado e mandar para a outra coluna ao lado de si

	; agora temos de descer uma posicao do bx e do si
	; objetivo bx = bx + 160
	add bx , 160
	; e fazer o mesmo para o si
	add si , 160
	loop CICLO				; decrementamos o cx e voltamos ao ciclo

	mov     ah,4CH
	int     21H
main	endp

cseg    ends
end     main

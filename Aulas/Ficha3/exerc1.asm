.8086
.model small
.stack 2048

dseg segment para public 'data'
	linha db 1
dseg ends


cseg	segment para public 'code'
	assume  cs:cseg ,ds:dseg

Main  proc
	mov ax , dseg
	mov ds , ax

	mov   ax,0b800h
	mov   es,ax

	
	mov al , linha				;
	mov bl , 160				;		colocar o bx a apontar para o indice 0 da linha 1 (cada linha tem 160 bytes)
	mul bl						;
	mov bx , ax					; 		colocar o resultado da multiplicacao em bx
	
								; 		Agora queremos colocar o ponteiro para o indice 0 da linha 15 (160 * (linha + 15))
	mov al , linha										
	add al , 15
	mov dl , 160
	mul dl						; ax = 160 * (linha + 15)
	mov si , ax

	mov	cx , 160				; com o 160 vamos copiar as 2 linhas a partir da linha 1 se quisessemos só uma linha era 80
	mov ah , '*'
	
CICLO:
	mov es:[bx] , ah		; aqui meti caracteres na primeira linha para ser mais facil ver o resultado
	mov ax , es:[bx] 		; colocar o valor da posicao es:[bx] em ax
	mov es:[si] , ax		; colocar o valor de ax na posicao es:[si] que é copiar da linha para a 15 linha
	
	add bx , 2				; temos sempre de incrementar 2 pq se fosse um era para tratarmos das cores
	add si , 2
	loop CICLO				; decrementamos o cx e voltamos ao ciclo

	mov     ah,4CH
	int     21H
main	endp

cseg    ends
end     main

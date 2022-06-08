.8086
.model small
.stack 2048

cseg	segment para public 'code'
	assume  cs:cseg

Main  proc
	mov   ax,0b800h
	mov   es,ax

	mov	al,0h							; colocar no al a cor que vai ser 7h 0 000 0000		0(se vai estar ou nao a piscar) 000(cor de fundo) 0000(cor da letra)
	mov	ah,'*' 							; precisamos disto para colocar no ecra o *
	mov	bx,0h							; colocar o bx a 0 para apontar para o indice 0
	mov	cx,25*80						

ciclo:    
	mov	es:[bx],ah						; colocar o * no primeiro quadrado do ecra
	mov	es:[bx+1],al					; no byte imediatamente a seguir vamos colocar a cor
	inc	bx
	inc	bx								; incrementamos o bx para continuar a percorrer
	inc	al								; vamos incrementando as cores até 255, se tivermos a cor dentro do al e incrementarmos ao maximo ele vai voltar a 0
	loop	ciclo						; decrementamos o cx

	mov     ah,4CH
	int     21H
main	endp

cseg    ends
end     main

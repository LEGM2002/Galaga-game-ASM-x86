;Garcia Martinez Luis Eduardo

title "Proyecto: Galaga" ;codigo opcional. Descripcion breve del programa, el texto entrecomillado se imprime como cabecera en cada página de código
	.model small	;directiva de modelo de memoria, small => 64KB para memoria de programa y 64KB para memoria de datos
	.386			;directiva para indicar version del procesador
	.stack 128 		;Define el tamano del segmento de stack, se mide en bytes
	.data			;Definicion del segmento de datos

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;CONSTANTES;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Valor ASCII de caracteres para el marco del programa
marcoEsqInfIzq 		equ 	200d 	;'╚'
marcoEsqInfDer 		equ 	188d	;'╝'
marcoEsqSupDer 		equ 	187d	;'╗'
marcoEsqSupIzq 		equ 	201d 	;'╔'
marcoCruceVerSup	equ		203d	;'╦'
marcoCruceHorDer	equ 	185d 	;'╣'
marcoCruceVerInf	equ		202d	;'╩'
marcoCruceHorIzq	equ 	204d 	;'╠'
marcoCruce 			equ		206d	;'╬'
marcoHor 			equ 	205d 	;'═'
marcoVer 			equ 	186d 	;'║'

;Atributos de color de BIOS
;Valores de color para carácter
cNegro 			equ		00h
cAzul 			equ		01h
cVerde 			equ 	02h
cCyan 			equ 	03h
cRojo 			equ 	04h
cMagenta 		equ		05h
cCafe 			equ 	06h
cGrisClaro		equ		07h
cGrisOscuro		equ		08h
cAzulClaro		equ		09h
cVerdeClaro		equ		0Ah
cCyanClaro		equ		0Bh
cRojoClaro		equ		0Ch
cMagentaClaro	equ		0Dh
cAmarillo 		equ		0Eh
cBlanco 		equ		0Fh

;Valores de color para fondo de carácter
bgNegro 		equ		00h
bgAzul 			equ		10h
bgVerde 		equ 	20h
bgCyan 			equ 	30h
bgRojo 			equ 	40h
bgMagenta 		equ		50h
bgCafe 			equ 	60h
bgGrisClaro		equ		70h
bgGrisOscuro	equ		80h
bgAzulClaro		equ		90h
bgVerdeClaro	equ		0A0h
bgCyanClaro		equ		0B0h
bgRojoClaro		equ		0C0h
bgMagentaClaro	equ		0D0h
bgAmarillo 		equ		0E0h
bgBlanco 		equ		0F0h

;Valores para delimitar el área de juego
lim_superior 	equ		1
lim_inferior 	equ		23
lim_izquierdo 	equ		1
lim_derecho 	equ		39

;Valores de referencia para la posición inicial del jugador
ini_columna 	equ 	lim_derecho/2
ini_renglon 	equ 	22

;Valores para la posición de los controles e indicadores dentro del juego
;Lives
lives_col 		equ  	lim_derecho+7
lives_ren 		equ  	4

;Scores
hiscore_ren	 	equ 	11
hiscore_col 	equ 	lim_derecho+7
score_ren	 	equ 	13
score_col 		equ 	lim_derecho+7

;Botón STOP
stop_col 		equ 	lim_derecho+10
stop_ren 		equ 	19
stop_izq 		equ 	stop_col-1
stop_der 		equ 	stop_col+1
stop_sup 		equ 	stop_ren-1
stop_inf 		equ 	stop_ren+1

;Botón PAUSE
pause_col 		equ 	stop_col+10
pause_ren 		equ 	19
pause_izq 		equ 	pause_col-1
pause_der 		equ 	pause_col+1
pause_sup 		equ 	pause_ren-1
pause_inf 		equ 	pause_ren+1

;Botón PLAY
play_col 		equ 	pause_col+10
play_ren 		equ 	19
play_izq 		equ 	play_col-1
play_der 		equ 	play_col+1
play_sup 		equ 	play_ren-1
play_inf 		equ 	play_ren+1

;  123456789012345678901234567890123456789                                       79
;0 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1 ;                                     ;                                       ;  
;2 ;                                     ;   									 ;
;3 ;                                     ;   									 ;
;4 ;                                     ;       LIVES							 ;
;5 ;                                     ;   									 ;
;6 ;                                     ;   									 ;
;7 ;                                     ;   									 ;
;8 ;                                     ;   									 ;
;9 ;                                     ;   									 ;
;10;                                     ;   									 ;
;11;                                     ;       HIGH SCORE						 ;
;12;                                     ;   									 ;
;13;                                     ;   	 SCORE							 ;
;14;                                     ;   									 ;
;15;                                     ;   									 ;
;16;                                     ;   									 ;
;17;                                     ;   									 ;
;18;                                     ;   									 ;
;19;                                     ;         S       PAU         P         ;
;20;                                     ;  									 ;
;21;                                     ;   									 ;
;22;                 J                   ;   									 ;
;23;                                     ;                                       ;
;24;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;VARIABLES;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

titulo 			db 		"GALAGA"
scoreStr 		db 		"SCORE"
hiscoreStr		db 		"HI-SCORE"
livesStr		db 		"LIVES"
blank			db 		"     "
presiona		db 		"PRESIONA"
simbolo_play 	db      "[",16d,"]" 
para_comenzar	db 		"PARA COMENZAR"
gameover 		db  	"GAME OVER"
jugar_de_nuevo  db  	"[",254d,"] PARA REINICIAR"
para_salir	    db  	"[X] PARA CERRAR"

;Variables para el jugador
player_lives 	db 		3
player_score 	dw 		0
player_hiscore 	dw 		0

player_col		db 		ini_columna 	;posicion en columna del jugador
player_ren		db 		ini_renglon 	;posicion en renglon del jugador

player_move		db 		1 				;si se mueve es 1, sino es 0
enemy_move 		db 		1 				;1 a la derecha y 0 a la izquierda

pbullet_col		db 		ini_columna 	;posicion en columna de la bala del jugador
pbullet_ren 	db 		ini_renglon-3 	;posicion en renglon de la bala del jugador
pbullet_activa  db      0               ;0 bala disponible, 1 bala activa

;Variables para el enemigo
enemy_col		db 		ini_columna 	;posicion en columna del enemigo
enemy_ren		db 		3 				;posicion en renglon del enemigo

ebullet_col 	db 		ini_columna 	;posicion en columna de la bala del enemigo
ebullet_ren 	db 		6 				;posicion en renglon de la bala del enemigo
;ebullet_activa  db      0  				;0 bala disponible, 1 bala activa

col_aux 		db 		0  		;variable auxiliar para operaciones con posicion - columna
ren_aux 		db 		0 		;variable auxiliar para operaciones con posicion - renglon

conta 			db 		6 		;contador

;Variables de ayuda para lectura de tiempo del sistema
tick_ms			dw 		55 		;55 ms por cada tick del sistema, esta variable se usa para operación de MUL convertir ticks a segundos
mil				dw		1000 	;1000 auxiliar para operación DIV entre 1000
diez 			dw 		10 		;10 auxiliar para operaciones
sesenta			db 		60 		;60 auxiliar para operaciones
status 			db 		0 		;0 stop, 1 play, 2 pause
ticks 			dw		0 		;Variable para almacenar el número de ticks del sistema y usarlo como referencia

;Variables que sirven de parámetros de entrada para el procedimiento IMPRIME_BOTON
boton_caracter 	db 		0
boton_renglon 	db 		0
boton_columna 	db 		0
boton_color		db 		0
boton_bg_color	db 		0

;Variables para el manejo de los botones
pausa_activa	db 		1 		;0 disponible, 1 pausa activa
go_activo       db      1       ;1 si, 0 no

;Auxiliar para calculo de coordenadas del mouse en modo Texto
ocho			db 		8

;Cuando el driver del mouse no está disponible
no_mouse		db 	'No se encuentra driver de mouse. Presione [enter] para salir$'

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;MACROS SE DEFINEN FUERA DE .code;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;clear - Limpia pantalla
clear macro
	mov ax,0003h 	;ah = 00h, selecciona modo video
					;al = 03h. Modo texto, 16 colores
	int 10h		;llama interrupcion 10h con opcion 00h. 
				;Establece modo de video limpiando pantalla
endm

;posiciona_cursor - Cambia la posición del cursor a la especificada con 'renglon' y 'columna' 
posiciona_cursor macro renglon,columna
	mov dh,renglon	;dh = renglon
	mov dl,columna	;dl = columna
	mov bx,0
	mov ax,0200h 	;preparar ax para interrupcion, opcion 02h
	int 10h 		;interrupcion 10h y opcion 02h. Cambia posicion del cursor
endm 

;inicializa_ds_es - Inicializa el valor del registro DS y ES
inicializa_ds_es 	macro
	mov ax,@data
	mov ds,ax
	mov es,ax 		;Este registro se va a usar, junto con BP, para imprimir cadenas utilizando interrupción 10h
endm

;muestra_cursor_mouse - Establece la visibilidad del cursor del mouse
muestra_cursor_mouse	macro
	mov ax,1		;opcion 0001h
	int 33h			;int 33h para manejo del mouse. Opcion AX=0001h
					;Habilita la visibilidad del cursor del mouse en el programa
endm

;posiciona_cursor_mouse - Establece la posición inicial del cursor del mouse
posiciona_cursor_mouse	macro columna,renglon
	mov dx,renglon
	mov cx,columna
	mov ax,4		;opcion 0004h
	int 33h			;int 33h para manejo del mouse. Opcion AX=0001h
					;Habilita la visibilidad del cursor del mouse en el programa
endm

;oculta_cursor_teclado - Oculta la visibilidad del cursor del teclado
oculta_cursor_teclado	macro
	mov ah,01h 		;Opcion 01h
	mov cx,2607h 	;Parametro necesario para ocultar cursor
	int 10h 		;int 10, opcion 01h. Cambia la visibilidad del cursor del teclado
endm

;apaga_cursor_parpadeo - Deshabilita el parpadeo del cursor cuando se imprimen caracteres con fondo de color
;Habilita 16 colores de fondo
apaga_cursor_parpadeo	macro
	mov ax,1003h 		;Opcion 1003h
	xor bl,bl 			;BL = 0, parámetro para int 10h opción 1003h
  	int 10h 			;int 10, opcion 01h. Cambia la visibilidad del cursor del teclado
endm

;imprime_caracter_color - Imprime un caracter de cierto color en pantalla, especificado por 'caracter', 'color' y 'bg_color'. 
;Los colores disponibles están en la lista a continuacion;
; Colores:
; 0h: Negro
; 1h: Azul
; 2h: Verde
; 3h: Cyan
; 4h: Rojo
; 5h: Magenta
; 6h: Cafe
; 7h: Gris Claro
; 8h: Gris Oscuro
; 9h: Azul Claro
; Ah: Verde Claro
; Bh: Cyan Claro
; Ch: Rojo Claro
; Dh: Magenta Claro
; Eh: Amarillo
; Fh: Blanco
; utiliza int 10h opcion 09h
; 'caracter' - caracter que se va a imprimir
; 'color' - color que tomará el caracter
; 'bg_color' - color de fondo para el carácter en la celda
; Cuando se define el color del carácter, éste se hace en el registro BL:
; La parte baja de BL (los 4 bits menos significativos) define el color del carácter
; La parte alta de BL (los 4 bits más significativos) define el color de fondo "background" del carácter
imprime_caracter_color macro caracter,color,bg_color
	mov ah,09h				;preparar AH para interrupcion, opcion 09h
	mov al,caracter 		;AL = caracter a imprimir
	mov bh,0				;BH = numero de pagina
	mov bl,color 			
	or bl,bg_color 			;BL = color del caracter
							;'color' define los 4 bits menos significativos 
							;'bg_color' define los 4 bits más significativos 
	mov cx,1				;CX = numero de veces que se imprime el caracter
							;CX es un argumento necesario para opcion 09h de int 10h
	int 10h 				;int 10h, AH=09h, imprime el caracter en AL con el color BL
endm

;imprime_caracter_color - Imprime un caracter de cierto color en pantalla, especificado por 'caracter', 'color' y 'bg_color'. 
; utiliza int 10h opcion 09h
; 'cadena' - nombre de la cadena en memoria que se va a imprimir
; 'long_cadena' - longitud (en caracteres) de la cadena a imprimir
; 'color' - color que tomarán los caracteres de la cadena
; 'bg_color' - color de fondo para los caracteres en la cadena
imprime_cadena_color macro cadena,long_cadena,color,bg_color
	mov ah,13h				;preparar AH para interrupcion, opcion 13h
	lea bp,cadena 			;BP como apuntador a la cadena a imprimir
	mov bh,0				;BH = numero de pagina
	mov bl,color 			
	or bl,bg_color 			;BL = color del caracter
							;'color' define los 4 bits menos significativos 
							;'bg_color' define los 4 bits más significativos 
	mov cx,long_cadena		;CX = longitud de la cadena, se tomarán este número de localidades a partir del apuntador a la cadena
	int 10h 				;int 10h, AH=09h, imprime el caracter en AL con el color BL
endm

;lee_mouse - Revisa el estado del mouse
;Devuelve:
;;BX - estado de los botones
;;;Si BX = 0000h, ningun boton presionado
;;;Si BX = 0001h, boton izquierdo presionado
;;;Si BX = 0002h, boton derecho presionado
;;;Si BX = 0003h, boton izquierdo y derecho presionados
; (400,120) => 80x25 =>Columna: 400 x 80 / 640 = 50; Renglon: (120 x 25 / 200) = 15 => 50,15
;;CX - columna en la que se encuentra el mouse en resolucion 640x200 (columnas x renglones)
;;DX - renglon en el que se encuentra el mouse en resolucion 640x200 (columnas x renglones)
lee_mouse	macro
	mov ax,0003h
	int 33h
endm

;comprueba_mouse - Revisa si el driver del mouse existe
comprueba_mouse macro
	mov ax,0		;opcion 0
	int 33h			;llama interrupcion 33h para manejo del mouse, devuelve un valor en AX
					;Si AX = 0000h, no existe el driver. Si AX = FFFFh, existe driver
endm

;teclado se manipula mediante la interrupcion 16h
;si la bandera Z = 1 no hay datos en el buffer
;si la bandera Z = 0 hay datos en el buffer
entrada_teclado	macro
	mov ah,01h 
	int 16h		
endm

;limpiar el buffer del teclado
limpiar_teclado	macro
	mov ah,00h 	
	int 16h
endm

;macros auxiliares
posicion_caracter macro   	;obtener el caracter en la posición del cursor
	posiciona_cursor ren_aux,col_aux
	mov ah,08h
	mov bh,00
	int 10h          		;al = caracter y ah = color
	push ax
endm

guarda_jposicion macro   	;guardar coordenadas del jugador en las variables col_aux y ren_aux 
    mov al,[player_col]
    mov ah,[player_ren]
    mov [col_aux],al
    mov [ren_aux],ah
endm

guarda_jbullet macro 		;guarda coordenadas de la bala del jugador
	mov al,[pbullet_col]
    mov ah,[pbullet_ren]
    mov [col_aux],al
    mov [ren_aux],ah
endm

guarda_eposicion macro  	;guardar coordenadas del enemigo en las variables col_aux y ren_aux 
    mov al,[enemy_col]
    mov ah,[enemy_ren]
    mov [col_aux],al
    mov [ren_aux],ah
endm

guarda_ebullet macro  		;guardar coordenadas de la bala del enemigo 
	mov al,[ebullet_col]
    mov ah,[ebullet_ren]
    mov [col_aux],al
    mov [ren_aux],ah
endm

;colisiones
;NAVE JUGADOR
;      [1]
;   [2][3][4]
;[5][6][7][8][9]
;se compara con 178 ya que es el simbolo de la nave enemiga
colision_jderecha macro
	;en [9]
	add col_aux,3  
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [4]
	dec col_aux
	dec ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [1]
	dec col_aux
	dec ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
endm

colision_jizquierda macro
	;en [5]
	sub col_aux,3  
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [2]
	inc col_aux
	dec ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [1]
	inc col_aux
	dec ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
endm

colision_jarriba macro
	;en [1]
	sub ren_aux,3  
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [2]
	dec col_aux
	inc ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [5]
	dec col_aux
	inc ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [9]
	add col_aux,4
	posicion_caracter
	cmp al,178
	je pierde_vida
	;en [4]
	dec col_aux
	dec ren_aux
	posicion_caracter
	cmp al,178
	je pierde_vida
endm

;NAVE ENEMIGA
;[1][2][3][4][5]
;   [6][7][8]
;      [9]
colision_ederecha macro 
	;en [5]
    add col_aux,3d 
    posicion_caracter
    cmp al,219
    je pierde_vida
    ;en [8]
    dec col_aux
    inc ren_aux
    posicion_caracter
    cmp al,219
    je pierde_vida
    ;en [9]
    dec col_aux
    inc ren_aux
	posicion_caracter
    cmp al,219
    je pierde_vida
endm

colision_eizquierda macro 
	;en [1]
    sub col_aux,3d
    posicion_caracter
    cmp al,219
    je pierde_vida
    ;en [6]
    inc col_aux
    inc ren_aux
    posicion_caracter
    cmp al,219
    je pierde_vida
    ;en [9]
    inc col_aux
    inc ren_aux
	posicion_caracter
    cmp al,219
    je pierde_vida
endm

colision_eabajo macro 
	;en [9]
	add ren_aux,3  
	posicion_caracter
	cmp al,219
	je pierde_vida
	;en [6]
	dec col_aux
	dec ren_aux
	posicion_caracter
	cmp al,219
	je pierde_vida
	;en [1]
	dec col_aux
	dec ren_aux
	posicion_caracter
	cmp al,219
	je pierde_vida
	;en [5]
	add col_aux,4
	posicion_caracter
	cmp al,219
	je pierde_vida
	;en [4]
	inc col_aux
	inc ren_aux
	posicion_caracter
	cmp al,219
	je pierde_vida
endm

;BALA
colision_ebala macro 
	;Para la bala del enemigo que va de arriba hacia abajo
	;si el renglon siguiente corresponde al simbolo con el que
	;se imprime la nave del jugador significa que acerto el disparo
	inc ren_aux
	posicion_caracter		;lo guarda en al
	cmp al,219 
	je pierde_vida
endm

colision_jbala macro 
	;Para la bala del jugador que va de abajo hacia arriba
	;si el renglon siguiente corresponde al simbolo con el que
	;se imprime la nave enemiga significa que acerto el disparo
	dec ren_aux
	posicion_caracter		;lo guarda en al
	cmp al,178 
	je muere_nave
endm


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;FIN MACROS;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/

	.code

inicio:					;etiqueta inicio
	inicializa_ds_es
	comprueba_mouse		;macro para revisar driver de mouse
	xor ax,0FFFFh		;compara el valor de AX con FFFFh, si el resultado es cero, entonces existe el driver de mouse
	jz imprime_ui		;Si existe el driver del mouse, entonces salta a 'imprime_ui'
	;Si no existe el driver del mouse entonces se muestra un mensaje
	lea dx,[no_mouse]
	mov ax,0900h	;opcion 9 para interrupcion 21h
	int 21h			;interrupcion 21h. Imprime cadena.
	jmp teclado		;salta a 'teclado'

imprime_ui:
	clear 					;limpia pantalla
	oculta_cursor_teclado	;oculta cursor del mouse
	apaga_cursor_parpadeo 	;Deshabilita parpadeo del cursor
	call DIBUJA_UI 			;procedimiento que dibuja marco de la interfaz
	muestra_cursor_mouse 	;hace visible el cursor del mouse
	;mouse solo en la parte de botones y score
	mov ax,0007h
	;CX - columna en la que se encuentra el mouse en resolucion 640x200 (columnas x renglones)
	mov cx,320d
	mov dx,639d
	int 33h

;En "mouse_no_clic" se revisa que el boton izquierdo del mouse no esté presionado
;Si el botón está suelto, continúa a la sección "mouse"
;si no, se mantiene indefinidamente en "mouse_no_clic" hasta que se suelte
mouse_no_clic:	
	lee_mouse
	test bx,0001h
	jnz mouse_no_clic

;Iniciar la ejecucion del juego
start_juego:
	;si pausa no esta activa comienza o se reanuda el juego
	cmp pausa_activa,0d
	je jugador 

;Lee el mouse y avanza hasta que se haga clic en el boton izquierdo
mouse:
	lee_mouse

conversion_mouse:
	;Leer la posicion del mouse y hacer la conversion a resolucion
	;80x25 (columnas x renglones) en modo texto
	mov ax,dx 			;Copia DX en AX. DX es un valor entre 0 y 199 (renglon)
	div [ocho] 			;Division de 8 bits
						;divide el valor del renglon en resolucion 640x200 en donde se encuentra el mouse
						;para obtener el valor correspondiente en resolucion 80x25
	xor ah,ah 			;Descartar el residuo de la division anterior
	mov dx,ax 			;Copia AX en DX. AX es un valor entre 0 y 24 (renglon)

	mov ax,cx 			;Copia CX en AX. CX es un valor entre 0 y 639 (columna)
	div [ocho] 			;Division de 8 bits
						;divide el valor de la columna en resolucion 640x200 en donde se encuentra el mouse
						;para obtener el valor correspondiente en resolucion 80x25
	xor ah,ah 			;Descartar el residuo de la division anterior
	mov cx,ax 			;Copia AX en CX. AX es un valor entre 0 y 79 (columna)

	;Aquí se revisa si se hizo clic en el botón izquierdo
	test bx,0001h 		;Para revisar si el boton izquierdo del mouse fue presionado
	jz start_juego		;Si el boton izquierdo no fue presionado, vuelve a leer el estado del mouse

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;LOGICA DEL MOUSE;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;Si el mouse fue presionado en el renglon 0
	;se va a revisar si fue dentro del boton [X]
	cmp dx,0
	je boton_x
	;Si el mouse fue presionado en el renglon 19
	;se va a revisar si fue dentro de algun boton de control
	cmp dx,19
	jge botones_control
	jmp mouse_no_clic

boton_x:
	jmp boton_x1

botones_control:
	cmp dx,21
	jbe identificar_boton

;Lógica para revisar si el mouse fue presionado en [X]
;[X] se encuentra en renglon 0 y entre columnas 76 y 78
;Salir del juego
boton_x1:
	cmp cx,76
	jge boton_x2
	jmp mouse_no_clic

boton_x2:
	cmp cx,78
	jbe boton_x3
	jmp mouse_no_clic

boton_x3:
	;Se cumplieron todas las condiciones
	jmp salir

identificar_boton:
	;Orden inverso para que no se quede en el primer caso
	cmp cx,69
	jge boton_play
	cmp cx,59
	jge boton_pause
	cmp cx,49
	jge boton_stop
	jmp mouse_no_clic

;Lógica para revisar si el mouse fue presionado en STOP
;STOP se encuentra en renglon 19 y entre columnas 49 y 51
;Reiniciar el juego
boton_stop:
	cmp cx,51
	jbe stop_game
	jmp mouse_no_clic

stop_game:
	;Se cumplieron todas las condiciones del boton stop
	;reestablecemos coordenadas del enemigo
	mov [enemy_col],ini_columna
	mov [enemy_ren],3
	jmp inicio

;Lógica para revisar si el mouse fue presionado en PAUSE
;PAUSE se encuentra en renglon 19 y entre columnas 59 y 61
;Pausar el juego (congelar pantalla)
boton_pause:
	cmp cx,61
	jbe pause_game
	jmp mouse_no_clic

pause_game:
	;Se cumplieron todas las condiciones del boton pause
	mov pausa_activa,1d  
	jmp mouse_no_clic

;Lógica para revisar si el mouse fue presionado en PLAY
;PLAY se encuentra en renglon 19 y entre columnas 69 y 71
;Reanudar juego
boton_play:
	cmp cx,71
	jbe game_play
	jmp mouse_no_clic

game_play:
	;Se cumplieron todas las condiciones del boton play
	call IMPRIME_JUGADOR
	mov pausa_activa,0d
	call LIMPIAR_VENTANA_INICIO
	jmp start_juego

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;LOGICA DE LOS MOVIMIENTOS;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;El ciclo del juego se realiza entre jugador y enemigo

;MOVIMIENTO DEL JUGADOR
;solo se puede horizontal derecha o izquierda
;a - izquierda - 97d - 61h
;d - derecha - 100d - 64h
;spacebar - disparo - 32d - 20h
jugador:
	cmp [player_move],0d 		;jugador no se mueve
	je enemigo 					;enemigo comienza a moverse
	;verificar impacto de la bala del jugador
	guarda_jbullet
	colision_jbala
	cmp pbullet_activa,1d
	je salta_j
	guarda_jbullet
	call BORRA_BALA_JUGADOR
	dec pbullet_ren
	call REIMPRIME_BALA_JUGADOR
salta_j:
	cmp [player_move],1d  		;jugador se mueve
	je jugador_en_movimiento    ;verificar que tecla se presiono

;inicia conteo del tiempo
jugador_en_movimiento:
	mov ah,01h              	;la interrupción 1Ah con ah = 01h modifica a 0 el System-Timer Time Counter.
	mov cx,0000h            	;se reinicia el System-Timer Time Counter.
	mov dx,0000h
	int 1Ah
	mov [player_move],0d 		;se cambia el valor de la etiqueta para que despues de leer el teclado se mueva el enemigo

comparar_entrada_teclado:
	entrada_teclado    			     
	jz mouse  
	limpiar_teclado  	    
	cmp al,64h 					;caracter 'd' se avanza a la derecha
	je derecha_jugador
	cmp al,61h 					;caracter 'a' se avanza a la izquierda
	je izquierda_jugador
	cmp al,20h 					;caracter 'spacebar' se dispara la bala del jugador
	je disparo_jugador
	jmp comparar_entrada_teclado;si el caracter del teclado no corresponde a un boton de movimiento

;no mayor a 39d en columna
derecha_jugador:
	cmp player_col,37d  		;compara si se encuentra en el limite derecho
    je comparar_entrada_teclado
    ;verifica colision entre naves
    guarda_jposicion
    colision_jderecha
    ;si no, se mantiene a la derecha
	call BORRA_JUGADOR
	inc player_col
	call IMPRIME_JUGADOR
	xor ax,ax           		;se limpia el registro ax
	jmp mouse

;no menor a 1d en columna
izquierda_jugador:
	cmp player_col,3d  			;compara si se encuentra en el limite derecho
    je comparar_entrada_teclado
    ;verificar colision entre naves
    guarda_jposicion
    colision_jizquierda
    ;si no, se mantiene a la izquierda
	call BORRA_JUGADOR
	dec player_col
	call IMPRIME_JUGADOR
	xor ax,ax           		;se limpia el registro ax
	jmp mouse

;al llegar al limite superior desaparece la bala
;si le da al enemigo aumenta score y desaparece enemigo
disparo_jugador: 
	cmp pbullet_activa,0d 
	je saltar_d_j 				;saltamos porque la bala esta activa
	call IMPRIME_BALA_JUGADOR
	mov pbullet_activa,0d  
saltar_d_j:
	xor ax,ax 					;limpiamos el registro ax
	jmp mouse

;MOVIMIENTO DEL ENEMIGO
;se implementara movimiento en diagonal
enemigo:
	mov ax,0000h 				;obtiene el valor del sistema (ticks) y se almacena en dx
	int 1Ah
	cmp dx,2d					;verifica que dx sea mayor que contador, si no lo es se repite desde la etiqueta mouse_no_clic
	jge enemigo_en_movimiento
	jmp comparar_entrada_teclado

enemigo_en_movimiento:
    ;se verifica si la bala del jugador llego al limite superior
	cmp pbullet_ren,1d 			
	je restablecer_bala_jugador
regreso_bala:
	guarda_ebullet
	colision_ebala
	call BORRA_BALA_ENEMIGO
	inc ebullet_ren				;para que la bala enemiga avance
	call IMPRIME_BALA_ENEMIGO
	cmp enemy_move,1d 			;1 se mueve a la derecha
	je derecha_enemigo
	cmp enemy_move,0d  			;0 se mueve a la izquierda
	je izquierda_enemigo
restablecer_bala_jugador:
	call BORRA_BALA_JUGADOR
	mov pbullet_activa,1d 
	jmp regreso_bala

;no mayor a 39d en columna
derecha_enemigo:
	;verificar impacto de bala enemiga
	guarda_ebullet
	colision_ebala
	;verificar colision entre naves
	guarda_eposicion
	colision_ederecha			;se checa que no haya colision
	mov enemy_move,1d 			;mantenga el movimiento a la derecha
	cmp enemy_col,37d  			;verificar si llego al limite derecho
	je izquierda_enemigo 		;cambiar direccion
	cmp ebullet_ren,23d 
	je restablecer_bala_enemigo
	;como va de 1 a 39 en 5, 8, 11, 15, 19, 23, 27, 31 y 35 bajara en diagonal
	cmp enemy_col,35d 
    je abajo_derecha_enemigo    ;baja en diagonal a la derecha  
	cmp enemy_col,31d 
    je abajo_derecha_enemigo     
    cmp enemy_col,27d 
    je abajo_derecha_enemigo  
    cmp enemy_col,23d    
    je abajo_derecha_enemigo  
    cmp enemy_col,19d 
    je abajo_derecha_enemigo     
    cmp enemy_col,15d 
    je abajo_derecha_enemigo  
    cmp enemy_col,11d    
    je abajo_derecha_enemigo  
    cmp enemy_col,8d 
    je abajo_derecha_enemigo      
    cmp enemy_col,5d    
    je abajo_derecha_enemigo   
    ;si no se encuentra en ninguna de esas columnas se mueve a la derecha  
	call BORRA_ENEMIGO 
	inc enemy_col				;enemigo a la derecha
	call IMPRIME_ENEMIGO
	mov player_move,1d  		;mantener bucle
	jmp comparar_entrada_teclado

;no menor a 1d en columna
izquierda_enemigo:
	;verificar impacto de bala
	guarda_ebullet
	colision_ebala
	;verificar colision entre naves
	guarda_eposicion
	colision_eizquierda
	mov enemy_move,0d 			;mantenga el movimiento a la izquierda
	cmp enemy_col,3d  			;verificar si llego al limite izquierdo
	je derecha_enemigo  		;cambiar direccion
	cmp ebullet_ren,23d 
	je restablecer_bala_enemigo
	;como va de 1 a 39 en 5, 8, 11, 15, 19, 23, 27, 31 y 35 bajara en diagonal
	cmp enemy_col,35d 
    je abajo_izquierda_enemigo  ;baja en diagonal a la izquierda  
    cmp enemy_col,31d 
    je abajo_izquierda_enemigo        
    cmp enemy_col,27d 
    je abajo_izquierda_enemigo 
    cmp enemy_col,23d 
    je abajo_izquierda_enemigo     
    cmp enemy_col,19d 
    je abajo_izquierda_enemigo        
    cmp enemy_col,15d 
    je abajo_izquierda_enemigo 
    cmp enemy_col,11d 
    je abajo_izquierda_enemigo
    cmp enemy_col,8d 
    je abajo_izquierda_enemigo        
    cmp enemy_col,5d 
    je abajo_izquierda_enemigo    
    ;si no se encuentra en ninguna de esas columnas se mueve a la izquierda      
	call BORRA_ENEMIGO 
	dec enemy_col				;enemigo a la izquierda
	call IMPRIME_ENEMIGO
	mov player_move,1d  		;mantener bucle
	jmp comparar_entrada_teclado

abajo_derecha_enemigo:
	;verificar colision entre naves
	guarda_eposicion
	colision_eabajo
	cmp enemy_ren,20d 			;verificar si logro pasar al jugador
	je pierde_vida
	call BORRA_ENEMIGO
	inc enemy_ren 	  			;avanza diagonal a la derecha
	inc enemy_col
	call IMPRIME_ENEMIGO
	mov player_move,1d  		;mantener bucle
	jmp comparar_entrada_teclado

abajo_izquierda_enemigo:
	;verificar colision entre naves
	guarda_eposicion
	colision_eabajo
	cmp enemy_ren,20d 			;verificar si logro pasar al jugador
	je pierde_vida
	call BORRA_ENEMIGO
	inc enemy_ren 				;avanza diagonal a la izquierda
	dec enemy_col
	call IMPRIME_ENEMIGO
	mov player_move,1d  		;mantener bucle
	jmp comparar_entrada_teclado

restablecer_bala_enemigo:
	call BORRA_BALA_ENEMIGO 	;se borra la bala
	guarda_eposicion			;guardamos posicion actual del enemigo
	mov [ebullet_col],al  		;coordenada x del enemigo se guarda en al
	add ah,2d  					;coordenada y del enemigo se guarda en ah, como la bala va en la punta se incrementa 2
	mov [ebullet_ren],ah
	call IMPRIME_BALA_ENEMIGO
	;se continua con el movimiento del enemigo
	cmp enemy_move,1d  			
	je derecha_enemigo
	cmp enemy_move,0d 
	je izquierda_enemigo

;PERDIDA DE VIDAS
;colision naves o balas, o si pasa el enemigo
pierde_vida:
	call BORRA_BALA_ENEMIGO 	;se borra bala del enemigo
	;se restablece la posicion inicial de la bala
    mov [ebullet_col], ini_columna 
    mov [ebullet_ren], 6d 
    call BORRA_ENEMIGO 			;se borra el enemigo
    ;se restablece la posicion inicial del enemigo
    mov [enemy_col], ini_columna
    mov [enemy_ren], 3d
    call BORRA_JUGADOR 			;se borra el jugador
    ;se restablece la posicion inicial del jugador
	mov [player_col], ini_columna
	mov [player_ren], ini_renglon
	;creamos al enemigo y su bala, y al jugador
	call IMPRIME_ENEMIGO
	call IMPRIME_JUGADOR
	;eliminar vida y comprobar si es game over
	call BORRA_LIVES    		;borramos los caracteres que representan las vidas
	dec player_lives    		;quitamos una vida del jugador
	cmp player_lives,0d 		;verificar si aun le quedan vidas 
	je game_over				;si ya no tiene vidas es game over
	call IMPRIME_LIVES  		;se vuelva escribir el contador de vidas con los caracteres correspondientes
	jmp mouse

;SE MODIFICO MUERE_NAVE
muere_nave:
	guarda_jbullet
	call BORRA_BALA_JUGADOR
	mov pbullet_activa,1d 
	add [player_score],10d  	;aumenta 10 al score actual
	call IMPRIME_SCORE 			;actualiza el score actual
    call BORRA_ENEMIGO 			
    ;se restablece la posicion inicial del enemigo
    mov [enemy_col], ini_columna
    mov [enemy_ren], 3d
    call IMPRIME_ENEMIGO
    jmp mouse

;SE MODIFICO GAME_OVER
game_over:
	mov pausa_activa,1d 		;pausa el juego para poder borrar y mostrar el mensaje de game over
	call VENTANA_GAME_OVER
	mov ax,player_score  		;se guarda el puntaje de esta partida
	cmp player_hiscore,ax  		;se compara con el puntaje mas alto
	jbe nuevo_hiscore  			;si high score es menor al puntaje nuevo se actualiza
	jmp mouse

nuevo_hiscore:
	mov [player_hiscore],ax  	;se guarda el nuevo high score
	call IMPRIME_HISCORE 		;imprimir high score
	jmp mouse

;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/;/

;Si no se encontró el driver del mouse, muestra un mensaje y el usuario debe salir tecleando [enter]
teclado:
	mov ah,08h
	int 21h
	cmp al,0Dh		;compara la entrada de teclado si fue [enter]
	jnz teclado 	;Sale del ciclo hasta que presiona la tecla [enter]

salir:				;inicia etiqueta salir
	clear 			;limpia pantalla
	mov ax,4C00h	;AH = 4Ch, opción para terminar programa, AL = 0 Exit Code, código devuelto al finalizar el programa
	int 21h			;señal 21h de interrupción, pasa el control al sistema operativo

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;PROCEDIMIENTOS;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;INTERFAZ
	DIBUJA_UI proc
		;imprimir esquina superior izquierda del marco
		posiciona_cursor 0,0
		imprime_caracter_color marcoEsqSupIzq,cAmarillo,bgNegro
		
		;imprimir esquina superior derecha del marco
		posiciona_cursor 0,79
		imprime_caracter_color marcoEsqSupDer,cAmarillo,bgNegro
		
		;imprimir esquina inferior izquierda del marco
		posiciona_cursor 24,0
		imprime_caracter_color marcoEsqInfIzq,cAmarillo,bgNegro
		
		;imprimir esquina inferior derecha del marco
		posiciona_cursor 24,79
		imprime_caracter_color marcoEsqInfDer,cAmarillo,bgNegro
		
		;imprimir marcos horizontales, superior e inferior
		mov cx,78 		;CX = 004Eh => CH = 00h, CL = 4Eh 
	marcos_horizontales:
		mov [col_aux],cl
		;Superior
		posiciona_cursor 0,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor 24,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		
		mov cl,[col_aux]
		loop marcos_horizontales

		;imprimir marcos verticales, derecho e izquierdo
		mov cx,23 		;CX = 0017h => CH = 00h, CL = 17h 
	marcos_verticales:
		mov [ren_aux],cl
		;Izquierdo
		posiciona_cursor [ren_aux],0
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor [ren_aux],79
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		;Limite mouse
		posiciona_cursor [ren_aux],lim_derecho+1
		imprime_caracter_color marcoVer,cAmarillo,bgNegro

		mov cl,[ren_aux]
		loop marcos_verticales

		;imprimir marcos horizontales internos
		mov cx,79-lim_derecho-1 		
	marcos_horizontales_internos:
		push cx
		mov [col_aux],cl
		add [col_aux],lim_derecho
		;Interno superior 
		posiciona_cursor 8,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro

		;Interno inferior
		posiciona_cursor 16,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro

		mov cl,[col_aux]
		pop cx
		loop marcos_horizontales_internos

		;imprime intersecciones internas	
		posiciona_cursor 0,lim_derecho+1
		imprime_caracter_color marcoCruceVerSup,cAmarillo,bgNegro
		posiciona_cursor 24,lim_derecho+1
		imprime_caracter_color marcoCruceVerInf,cAmarillo,bgNegro

		posiciona_cursor 8,lim_derecho+1
		imprime_caracter_color marcoCruceHorIzq,cAmarillo,bgNegro
		posiciona_cursor 8,79
		imprime_caracter_color marcoCruceHorDer,cAmarillo,bgNegro

		posiciona_cursor 16,lim_derecho+1
		imprime_caracter_color marcoCruceHorIzq,cAmarillo,bgNegro
		posiciona_cursor 16,79
		imprime_caracter_color marcoCruceHorDer,cAmarillo,bgNegro

		;imprimir [X] para cerrar programa
		posiciona_cursor 0,76
		imprime_caracter_color '[',cAmarillo,bgNegro
		posiciona_cursor 0,77
		imprime_caracter_color 'X',cRojoClaro,bgNegro
		posiciona_cursor 0,78
		imprime_caracter_color ']',cAmarillo,bgNegro

		;imprimir título
		posiciona_cursor 0,37
		imprime_cadena_color [titulo],6,cAmarillo,bgNegro

		call IMPRIME_TEXTOS
		call IMPRIME_BOTONES
		call IMPRIME_DATOS_INICIALES
		call IMPRIME_SCORES
		call IMPRIME_LIVES
		call VENTANA_INICIO
		ret
	endp

	IMPRIME_TEXTOS proc
		;Imprime cadena "LIVES"
		posiciona_cursor lives_ren,lives_col
		imprime_cadena_color livesStr,5,cGrisClaro,bgNegro

		;Imprime cadena "SCORE"
		posiciona_cursor score_ren,score_col
		imprime_cadena_color scoreStr,5,cGrisClaro,bgNegro

		;Imprime cadena "HI-SCORE"
		posiciona_cursor hiscore_ren,hiscore_col
		imprime_cadena_color hiscoreStr,8,cGrisClaro,bgNegro
		ret
	endp

	IMPRIME_BOTONES proc
		;Botón STOP
		mov [boton_caracter],254d		;Carácter '■'
		mov [boton_color],bgAmarillo 	;Background amarillo
		mov [boton_renglon],stop_ren 	;Renglón en "stop_ren"
		mov [boton_columna],stop_col 	;Columna en "stop_col"
		call IMPRIME_BOTON 				;Procedimiento para imprimir el botón
		;Botón PAUSE
		mov [boton_caracter],19d 		;Carácter '‼'
		mov [boton_color],bgAmarillo 	;Background amarillo
		mov [boton_renglon],pause_ren 	;Renglón en "pause_ren"
		mov [boton_columna],pause_col 	;Columna en "pause_col"
		call IMPRIME_BOTON 				;Procedimiento para imprimir el botón
		;Botón PLAY
		mov [boton_caracter],16d  		;Carácter '►'
		mov [boton_color],bgAmarillo 	;Background amarillo
		mov [boton_renglon],play_ren 	;Renglón en "play_ren"
		mov [boton_columna],play_col 	;Columna en "play_col"
		call IMPRIME_BOTON 				;Procedimiento para imprimir el botón
		ret
	endp

	IMPRIME_SCORES proc
		;Imprime el valor de la variable player_score en una posición definida
		call IMPRIME_SCORE
		;Imprime el valor de la variable player_hiscore en una posición definida
		call IMPRIME_HISCORE
		ret
	endp

	IMPRIME_SCORE proc
		;Imprime "player_score" en la posición relativa a 'score_ren' y 'score_col'
		mov [ren_aux],score_ren
		mov [col_aux],score_col+20
		mov bx,[player_score]
		call IMPRIME_BX
		ret
	endp

	IMPRIME_HISCORE proc
	;Imprime "player_score" en la posición relativa a 'hiscore_ren' y 'hiscore_col'
		mov [ren_aux],hiscore_ren
		mov [col_aux],hiscore_col+20
		mov bx,[player_hiscore]
		call IMPRIME_BX
		ret
	endp

	;BORRA_SCORES borra los marcadores numéricos de pantalla sustituyendo la cadena de números por espacios
	BORRA_SCORES proc
		call BORRA_SCORE
		call BORRA_HISCORE
		ret
	endp

	BORRA_SCORE proc
		posiciona_cursor score_ren,score_col+20 		;posiciona el cursor relativo a score_ren y score_col
		imprime_cadena_color blank,5,cBlanco,bgNegro 	;imprime cadena blank (espacios) para "borrar" lo que está en pantalla
		ret
	endp

	BORRA_HISCORE proc
		posiciona_cursor hiscore_ren,hiscore_col+20 	;posiciona el cursor relativo a hiscore_ren y hiscore_col
		imprime_cadena_color blank,5,cBlanco,bgNegro 	;imprime cadena blank (espacios) para "borrar" lo que está en pantalla
		ret
	endp

	;SCORE
	;Imprime el valor del registro BX como entero sin signo (positivo)
	;Se imprime con 5 dígitos (incluyendo ceros a la izquierda)
	;Se usan divisiones entre 10 para obtener dígito por dígito en un LOOP 5 veces (una por cada dígito)
	IMPRIME_BX proc
		mov ax,bx
		mov cx,5
	div10:
		xor dx,dx
		div [diez]
		push dx
		loop div10
		mov cx,5
	imprime_digito:
		mov [conta],cl
		posiciona_cursor [ren_aux],[col_aux]
		pop dx
		or dl,30h
		imprime_caracter_color dl,cBlanco,bgNegro
		xor ch,ch
		mov cl,[conta]
		inc [col_aux]
		loop imprime_digito
		ret
	endp

	IMPRIME_DATOS_INICIALES proc
		call DATOS_INICIALES 		;inicializa variables de juego
		;imprime la 'nave' del jugador
		;borra la posición actual, luego se reinicia la posición y entonces se vuelve a imprimir
		call BORRA_JUGADOR
		;mov [player_col], ini_columna
		;mov [player_ren], ini_renglon
		;Imprime jugador
		call IMPRIME_JUGADOR
		;Borrar posicion actual del enemigo y reiniciar su posicion
		;Imprime enemigo
		call IMPRIME_ENEMIGO
		;Imprime bala del enemigo
		call BORRA_BALA_ENEMIGO
		call IMPRIME_BALA_ENEMIGO
		ret
	endp

	;Inicializa variables del juego
	DATOS_INICIALES proc
		mov [player_score],0
		mov [player_lives],3
		;jugador se mueve
		mov player_move,1
		;enemigo a la derecha
		mov enemy_move,1
		;juego pausado hasta que se de clic en play
		mov pausa_activa,1
		;inicializamos posion de la bala enemiga (en la punta de la nave)
		mov [ebullet_ren],6  
		mov [ebullet_col],ini_columna
		;inicializamos como bala del jugador no disponible
		mov pbullet_activa,1d 
		ret
	endp

	;Imprime los caracteres que representan vidas. Inicialmente se imprime el número de 'player_lives'
	IMPRIME_LIVES proc
		xor cx,cx
		mov di,lives_col+20
		mov cl,[player_lives]
	imprime_live:
		push cx
		mov ax,di
		posiciona_cursor lives_ren,al
		imprime_caracter_color 3d,cRojoClaro,bgNegro
		add di,2
		pop cx
		loop imprime_live
		ret
	endp

	;Similar a IMPRIME_LIVES solo que en este caso el caracter es de color negro simulando el borrado
	BORRA_LIVES proc 
	    xor cx,cx  						;limpia el registro cx de las columnas
	    mov di,lives_col+20
		mov cl,[player_lives]
	borra_live:
		push cx
		mov ax,di
		posiciona_cursor lives_ren,al
		imprime_caracter_color 0d,cNegro,bgNegro
		add di,2
		pop cx
		loop borra_live
		ret 
	endp

	;procedimiento IMPRIME_BOTON
	;Dibuja un boton que abarca 3 renglones y 5 columnas
	;con un caracter centrado dentro del boton
	;en la posición que se especifique (esquina superior izquierda)
	;y de un color especificado
	;Utiliza paso de parametros por variables globales
	;Las variables utilizadas son:
	;boton_caracter: debe contener el caracter que va a mostrar el boton
	;boton_renglon: contiene la posicion del renglon en donde inicia el boton
	;boton_columna: contiene la posicion de la columna en donde inicia el boton
	;boton_color: contiene el color del boton
	IMPRIME_BOTON proc
	 	;background de botón
		mov ax,0600h 		;AH=06h (scroll up window) AL=00h (borrar)
		mov bh,cRojo	 	;Caracteres en color amarillo
		xor bh,[boton_color]
		mov ch,[boton_renglon]
		mov cl,[boton_columna]
		mov dh,ch
		add dh,2
		mov dl,cl
		add dl,2
		int 10h
		mov [col_aux],dl
		mov [ren_aux],dh
		dec [col_aux]
		dec [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color [boton_caracter],cRojo,[boton_color]
	 	ret 			;Regreso de llamada a procedimiento
	endp	 			;Indica fin de procedimiento UI para el ensamblador

;JUGADOR
	IMPRIME_JUGADOR proc
		guarda_jposicion
		call PRINT_PLAYER
		ret
	endp

	;Imprime la nave del jugador, que recibe como parámetros las variables ren_aux y col_aux, que indican la posición central inferior
	PRINT_PLAYER proc
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		dec [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		dec [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		add [ren_aux],2
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		dec [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		inc [ren_aux]
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		
		add [col_aux],3
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		dec [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		inc [ren_aux]
		
		inc [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 219,cAzulClaro,bgNegro
		ret
	endp

	BORRA_JUGADOR proc
		guarda_jposicion
		call DELETE_PLAYER
		ret
	endp

	;Borra la nave del jugador, que recibe como parámetros las variables ren_aux y col_aux, que indican la posición central de la barra
	DELETE_PLAYER proc
		;IMPLEMENTAR DELETE_PLAYER
		;Similar a PRINT_PLAYER, en este caso se imprime el caracter
		;0 = null y se pasa el color negro simulando el borrado de la nave
		posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    dec [ren_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    dec [ren_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    add [ren_aux],2
	      
	    dec [col_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    dec [ren_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    inc [ren_aux]
	      
	    dec [col_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	      
	    add [col_aux],3
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    dec [ren_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
	    inc [ren_aux]
	      
	    inc [col_aux]
	    posiciona_cursor [ren_aux],[col_aux]
	    imprime_caracter_color 0,cNegro,bgNegro
		ret
	endp

	;Para nueva bala
	IMPRIME_BALA_JUGADOR proc 
		guarda_jposicion	
        sub ren_aux,3d
	    mov ah,[col_aux]       
		mov al,[ren_aux]
		mov [pbullet_col],ah
		mov [pbullet_ren] ,al
		call PRINT_PBULLET
		ret
	endp

	;Para simular el disparo
	REIMPRIME_BALA_JUGADOR proc 
		guarda_jbullet
		call PRINT_PBULLET
		ret  
	endp

	PRINT_PBULLET proc 
		;IMPLEMENTAR PRINT_PBULLET
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 24,cBlanco,bgNegro
		ret 
	endp

	BORRA_BALA_JUGADOR proc 
		guarda_jbullet
		call DELETE_PBULLET
		ret
	endp

	DELETE_PBULLET proc 
		;IMPLEMENTAR DELETE_PBULLET
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		ret 
	endp

;ENEMIGO
	IMPRIME_ENEMIGO proc
		guarda_eposicion
		call PRINT_ENEMY
		ret
	endp

	;Imprime la nave del enemigo
	PRINT_ENEMY proc
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		sub [ren_aux],2
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		dec [ren_aux]
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		
		add [col_aux],3
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		dec [ren_aux]
		
		inc [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 178,cRojo,bgNegro
		ret
	endp

	BORRA_ENEMIGO proc
		guarda_eposicion
		call DELETE_ENEMY
		ret
	endp

	;Borra la nave del enemigo, que recibe como parámetros las variables ren_aux y col_aux, que indican la posición central de la barra
	DELETE_ENEMY proc
		;IMPLEMENTAR DELETE_ENEMY
		;Similar a PRINT_ENEMY, en este caso se imprime el caracter
		;0 = null y se pasa el color negro simulando el borrado de la nave
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		sub [ren_aux],2
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		dec [ren_aux]
		
		dec [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		
		add [col_aux],3
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		inc [ren_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		dec [ren_aux]
		
		inc [col_aux]
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		ret
	endp

	IMPRIME_BALA_ENEMIGO proc 
		guarda_ebullet
		call PRINT_EBULLET
		ret
	endp

	PRINT_EBULLET proc 
		;IMPLEMENTAR PRINT_PBULLET
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 25,cBlanco,bgNegro
		ret 
	endp

	BORRA_BALA_ENEMIGO proc 
		guarda_ebullet
		call DELETE_PBULLET
		ret
	endp

	DELETE_EBULLET proc  
		;IMPLEMENTAR DELETE_PBULLET
		posiciona_cursor [ren_aux],[col_aux]
		imprime_caracter_color 0,cNegro,bgNegro
		ret
	endp

;VENTANAS DE INICIO Y DE GAME OVER
;  123456789012345678901234567890123456789                                       79
;0 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;1 ;                                     ;                                       ;  
;2 ;                                     ;   									 ;
;3 ;                                     ;   									 ;
;4 ;                                     ;       LIVES							 ;
;5 ;                                     ;   									 ;
;6 ;                                     ;   									 ;
;7 ;        10                  30       ;   									 ;
;8 ;        ;;;;;;;;;;;;;;;;;;;;;        ;   									 ;
;9 ;        ;                   ;        ;   									 ;
;10;        ;                   ;        ;   									 ;
;11;        ;                   ;        ;       HIGH SCORE						 ;
;12;        ;                   ;        ;   									 ;
;13;        ;                   ;        ;   	 SCORE							 ;
;14;        ;                   ;        ;   									 ;
;15;        ;                   ;        ;   									 ;
;16;        ;;;;;;;;;;;;;;;;;;;;;        ;   									 ;
;17;                                     ;   									 ;
;18;                                     ;   									 ;
;19;                                     ;         S       PAU         P         ;
;20;                                     ;  									 ;
;21;                                     ;   									 ;
;22;                 J                   ;   									 ;
;23;                                     ;                                       ;
;24;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	VENTANA_INICIO proc 
		call BORRA_JUGADOR
		call BORRA_ENEMIGO
		call BORRA_BALA_JUGADOR
		call BORRA_BALA_ENEMIGO
		posiciona_cursor 8d,10d
		imprime_caracter_color marcoEsqSupIzq,cAmarillo,bgNegro
		posiciona_cursor 8d,30d  
		imprime_caracter_color marcoEsqSupDer,cAmarillo,bgNegro
		posiciona_cursor 16d,10d  
		imprime_caracter_color marcoEsqInfIzq,cAmarillo,bgNegro
		posiciona_cursor 16d,30d  
		imprime_caracter_color marcoEsqInfDer,cAmarillo,bgNegro
		;imprimir marcos horizontales, superior e inferior
		mov [col_aux],11d 		
	marcos_ihorizontales:
		;Superior
		posiciona_cursor 8d,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor 16d,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		inc col_aux
		cmp col_aux,29d				;ciclo hasta la columna 29
		jbe marcos_ihorizontales

		;imprimir marcos verticales, derecho e izquierdo
		mov [ren_aux],9d 		
	marcos_iverticales:
		;Izquierdo
		posiciona_cursor [ren_aux],10d  
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor [ren_aux],30d  
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		inc ren_aux
		cmp ren_aux,15d  			;ciclo hasta el renglon 15
		jbe marcos_iverticales
		;texto
		posiciona_cursor 10d,16d 
		imprime_cadena_color presiona,8,cBlanco,bgNegro
		posiciona_cursor 12d,18d  
		imprime_cadena_color simbolo_play,3,cBlanco,bgNegro
		posiciona_cursor 14d,14d
		imprime_cadena_color para_comenzar,13,cBlanco,bgNegro
		ret  
	endp

	LIMPIAR_VENTANA_INICIO proc 
		posiciona_cursor 8d,10d
		imprime_caracter_color marcoEsqSupIzq,cNegro,bgNegro
		posiciona_cursor 8d,30d  
		imprime_caracter_color marcoEsqSupDer,cNegro,bgNegro
		posiciona_cursor 16d,10d  
		imprime_caracter_color marcoEsqInfIzq,cNegro,bgNegro
		posiciona_cursor 16d,30d  
		imprime_caracter_color marcoEsqInfDer,cNegro,bgNegro
		;imprimir marcos horizontales, superior e inferior
		mov [col_aux],11d 		
	marcos_lihorizontales:
		;Superior
		posiciona_cursor 8d,[col_aux]
		imprime_caracter_color marcoHor,cNegro,bgNegro
		;Inferior
		posiciona_cursor 16d,[col_aux]
		imprime_caracter_color marcoHor,cNegro,bgNegro
		inc col_aux
		cmp col_aux,29d				;ciclo hasta la columna 29
		jbe marcos_lihorizontales

		;imprimir marcos verticales, derecho e izquierdo
		mov [ren_aux],9d 		
	marcos_liverticales:
		;Izquierdo
		posiciona_cursor [ren_aux],10d  
		imprime_caracter_color marcoVer,cNegro,bgNegro
		;Inferior
		posiciona_cursor [ren_aux],30d  
		imprime_caracter_color marcoVer,cNegro,bgNegro
		inc ren_aux
		cmp ren_aux,15d  			;ciclo hasta el renglon 15
		jbe marcos_liverticales
		;limpiar texto
		posiciona_cursor 10d,16d 
		imprime_cadena_color presiona,8,cNegro,bgNegro
		posiciona_cursor 12d,18d  
		imprime_cadena_color simbolo_play,3,cNegro,bgNegro
		posiciona_cursor 14d,14d
		imprime_cadena_color para_comenzar,13,cNegro,bgNegro
		ret  
	endp

	VENTANA_GAME_OVER proc 
		call BORRA_JUGADOR
		call BORRA_ENEMIGO
		call BORRA_BALA_JUGADOR
		call BORRA_BALA_ENEMIGO
		posiciona_cursor 8d,10d
		imprime_caracter_color marcoEsqSupIzq,cAmarillo,bgNegro
		posiciona_cursor 8d,30d  
		imprime_caracter_color marcoEsqSupDer,cAmarillo,bgNegro
		posiciona_cursor 16d,10d  
		imprime_caracter_color marcoEsqInfIzq,cAmarillo,bgNegro
		posiciona_cursor 16d,30d  
		imprime_caracter_color marcoEsqInfDer,cAmarillo,bgNegro
		;imprimir marcos horizontales, superior e inferior
		mov [col_aux],11d 		
	marcos_gohorizontales:
		;Superior
		posiciona_cursor 8d,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor 16d,[col_aux]
		imprime_caracter_color marcoHor,cAmarillo,bgNegro
		inc col_aux
		cmp col_aux,29d				;ciclo hasta la columna 29
		jbe marcos_gohorizontales

		;imprimir marcos verticales, derecho e izquierdo
		mov [ren_aux],9d 		
	marcos_goverticales:
		;Izquierdo
		posiciona_cursor [ren_aux],10d  
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		;Inferior
		posiciona_cursor [ren_aux],30d  
		imprime_caracter_color marcoVer,cAmarillo,bgNegro
		inc ren_aux
		cmp ren_aux,15d  			;ciclo hasta el renglon 15
		jbe marcos_goverticales
		;texto
		posiciona_cursor 10d,16d 
		imprime_cadena_color gameover,9,cRojo,bgNegro
		posiciona_cursor 12d,12d 
		imprime_cadena_color jugar_de_nuevo,18,cBlanco,bgNegro
		posiciona_cursor 14d,13d 
		imprime_cadena_color para_salir,17,cBlanco,bgNegro
		ret  
	endp

	LIMPIAR_VENTANA_GAME_OVER proc 
		posiciona_cursor 8d,10d
		imprime_caracter_color marcoEsqSupIzq,cNegro,bgNegro
		posiciona_cursor 8d,30d  
		imprime_caracter_color marcoEsqSupDer,cNegro,bgNegro
		posiciona_cursor 16d,10d  
		imprime_caracter_color marcoEsqInfIzq,cNegro,bgNegro
		posiciona_cursor 16d,30d  
		imprime_caracter_color marcoEsqInfDer,cNegro,bgNegro
		;imprimir marcos horizontales, superior e inferior
		mov [col_aux],11d 		
	marcos_lgohorizontales:
		;Superior
		posiciona_cursor 8d,[col_aux]
		imprime_caracter_color marcoHor,cNegro,bgNegro
		;Inferior
		posiciona_cursor 16d,[col_aux]
		imprime_caracter_color marcoHor,cNegro,bgNegro
		inc col_aux
		cmp col_aux,29d				;ciclo hasta la columna 29
		jbe marcos_gohorizontales

		;imprimir marcos verticales, derecho e izquierdo
		mov [ren_aux],9d 		
	marcos_lgoverticales:
		;Izquierdo
		posiciona_cursor [ren_aux],10d  
		imprime_caracter_color marcoVer,cNegro,bgNegro
		;Inferior
		posiciona_cursor [ren_aux],30d  
		imprime_caracter_color marcoVer,cNegro,bgNegro
		inc ren_aux
		cmp ren_aux,15d  			;ciclo hasta el renglon 15
		jbe marcos_goverticales
		;limpiar texto
		posiciona_cursor 10d,16d 
		imprime_cadena_color gameover,9,cNegro,bgNegro
		posiciona_cursor 12d,12d 
		imprime_cadena_color jugar_de_nuevo,18,cNegro,bgNegro
		posiciona_cursor 14d,13d 
		imprime_cadena_color para_salir,17,cNegro,bgNegro
		ret  
	endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;FIN PROCEDIMIENTOS;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

end inicio			;fin de etiqueta inicio, fin de programa

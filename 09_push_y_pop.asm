; 09.- PUSH y POP
; Materia: Lenguajes de Interfaz
; Nombre: Santos Plazola Angel Ernesto 
; Horario: 08:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion: Manipulacion de la pila de memoria para guardar temporalmente y recuperar datos o estados de los registros
INCLUDE Irvine32.inc

.code
main PROC  
    ; SECCIÓN 1: Práctica básica de apilado y desapilado
	mov eax, 40

	push eax        ; Mandamos el contenido de EAX hacia el tope de la pila

	nop

	mov eax, 0
	pop ebx         ; Extraemos el valor guardado previamente y lo depositamos en EBX

	nop

	; SECCIÓN 2: Demostración de la regla LIFO (Último en entrar, Primero en salir)
	mov eax, 10
	push eax        ; Primer elemento apilado

	mov eax, 20
	push eax        ; Segundo elemento apilado

	mov eax, 30
	push eax        ; Tercer elemento apilado

	pop eax         ; Retira el 30 (el más reciente)
	pop ebx         ; Retira el 20
	pop ecx         ; Retira el 10 (el primero que ingresó)

	nop

	; SECCIÓN 3: Resguardo temporal de registros en la pila
	mov eax, 100
	mov ebx, 200

	push eax        ; Protegemos el estado actual de EAX
	push bx         ; (Instrucción original respetada)
	push ebx        ; Protegemos el estado actual de EBX

	mov eax, 999
	mov ebx, 666


	nop

	; SECCIÓN 4: Invocación de subrutinas mediante CALL y RET
	mov eax, 50
	mov ebx, 100

	call aumentarDiez ; Saltamos a la función secundaria para procesar datos
	
	nop
	exit

main ENDP

aumentarDiez PROC ; Subrutina que incrementa en diez unidades el acumulador EAX
    push ebx        ; Salvaguardamos el registro EBX en la pila

	mov ebx, 10 
	add eax, ebx    ; Aplicamos el incremento aritmético

	pop ebx         ; Devolvemos a EBX su valor original

	ret             ; Retornamos la ejecución al bloque principal
aumentarDiez ENDP

END main
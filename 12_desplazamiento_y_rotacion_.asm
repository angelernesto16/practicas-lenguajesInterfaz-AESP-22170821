; 12.- Desplazamiento y Rotacion de bits
;;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Proposito: Practica de operaciones de corrimiento (SHL, SHR, SAR) y rotacion circular (ROL, ROR) sobre registros.
INCLUDE Irvine32.inc

.code
main PROC  

    ; Limpiamos por completo los registros principales para asegurar un entorno de trabajo neutro
    mov eax, 0
	mov ebx, 0
	mov ecx, 0
	mov edx, 0

; 1 SHL: Corrimiento logico a la izquierda (equivale a multiplicar por 2, ingresando un cero por la derecha)
    mov al, 10000110b
	shl al, 1

	call DumpRegs
	call WriteBin
	
; 2 SHR: Corrimiento logico a la derecha (equivale a division entera, ingresando un cero por la izquierda)
    mov al, 00001101b
	shr al, 1

	call DumpRegs
	call WriteBin

; 3 SAR: Desplazamiento aritmetico conservando el bit de signo (evaluando con un numero negativo par)
    mov eax, 0
	mov al, -8
	sar al, 1

	call DumpRegs
	call WriteBin

; 4 SAR: Aplicacion de desplazamiento aritmetico sobre un valor negativo de caracter impar
    mov eax, 0
	mov al, -9
	sar al, 1

; 5 Desplazamiento con constante explicita (desplaza exactamente dos posiciones en un solo paso)
    mov al, 00001100b
	shl al, 2

	call DumpRegs
	call WriteBin

; 6 Desplazamiento dinamico apoyandose en el registro CL para definir la cantidad de saltos
    mov al, 00001100b
	mov cl, 2
	shr al, cl

; 7 ROR, ROL, RCR, RCL: Bloque de rotaciones circulares de bits
; Mascara de prueba: 10000001b

; ROR: Rota los bits hacia la derecha (el bit que sale por el extremo derecho reingresa por la izquierda)
	mov al, 10000001b
	ror al, 1

	call DumpRegs
	call WriteBin

; ROL: Rota los bits hacia la izquierda (el bit expulsado por la izquierda vuelve a entrar por la derecha)
    mov al, 10000001b
	rol al, 1

	call DumpRegs
	call WriteBin

	exit

main ENDP

END main
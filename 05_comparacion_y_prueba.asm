05- CONDICIONALES
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;DESCRIPCION: APLICACION DE ESTRUCTURAS DE CONTROL PARA REPETIR UN BLOQUE DE CODIGO HASTA QUE SE DETECTE EL INGRESO DE UN CERO
INCLUDE Irvine32.inc

.code
main PROC
; BUCLE WHILE
; Evalúa la condición antes de entrar o continuar el bloque de instrucciones.
; Imprime los números del 1 al 100.

; WHILE
    mov ebx, 1 

cicloWhile: 

    cmp ebx, 100 

    jg fin 

    mov eax, ebx
    call WriteDec 
    call Crlf 

    inc ebx 
    jmp cicloWhile 

fin:
    call Crlf 

    mov ebx, 1 

cicloDoWhile:
; BUCLE DO-WHILE
; Ejecuta el bloque de código al menos una vez antes de evaluar la condición.
; También imprime los números del 1 al 100.

    mov eax, ebx 
    call WriteDec 
    call Crlf 

    inc ebx
    cmp ebx, 100 

    jle cicloDoWhile 

    exit 
main ENDP

END main
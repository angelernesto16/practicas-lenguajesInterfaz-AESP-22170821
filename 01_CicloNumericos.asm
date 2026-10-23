; 01- Ciclos Numericos
; Materia: Lenguajes de Interfaz
; Nombre: Santos Plazola Angel Ernesto
; Horario: 8:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion: Este programa en ensamblador imprime una cuenta regresiva del 5 al 1 en la consola.

INCLUDE Irvine32.inc

.data

.code ;Indica el inicio de la sección de código ejecutable.
main PROC 

    mov ecx, 5 

ciclo: ; Aqui en ciclo hacemos que se repita el bloque de instrucciones hasta que ecx sea 0
    mov eax, ecx  
    call WriteDec ; Llama a la función de la biblioteca Irvine32 que imprime en la pantalla el número decimal que está guardado 
    call Crlf 

    loop ciclo 

    exit
main ENDP
END main
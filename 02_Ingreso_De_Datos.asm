; 2.- Ingreso de datos
; Materia: Lenguajes de Interfaz
; Nombre: Angel Ernesto Santos Plazola
; Horario: 08:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion : Programa que solicita un nombre por teclado y lo imprime en la consola.

TITLE Plantilla
INCLUDE C:\irvine\Irvine32.inc

.data ; --- Sección de variables y cadenas ---
mensaje BYTE "Escribe tu nombre: ",0

nombre Byte 15 DUP(0) ; Espacio reservado (buffer de 15 bytes) para el nombre ingresado

.code  
main PROC 
    mov edx, OFFSET mensaje ; Preparamos el puntero al texto en EDX para mostrarlo en pantalla
    call WriteString


    mov edx, OFFSET nombre
    mov ecx, SIZEOF nombre  ; Definimos el límite máximo de caracteres a leer

    call ReadString
    call Crlf

    mov edx, OFFSET nombre ; Apuntamos nuevamente al buffer del nombre para imprimirlo
    call WriteString
    call Crlf
    exit

main ENDP
END main
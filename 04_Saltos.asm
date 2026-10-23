; 04- SALTOS
;MATERIA: Lenguajes De Interfaz
;Nombre: Santos Plazola Angel Ernesto
;Horario: 08:00 - 09:00
;Docente: Jose Luis Medina Jimenez
;Descripcion: Uso de saltos condicionales para evaluar la entrada del usuario y determinar si un valor es mayor, menor o igual a otro


INCLUDE Irvine32.inc
.code
main PROC ; En este codigo se muestra el uso de saltos incondicionales
    mov eax, 5

    jmp continuar
    mov eax, 10

    continuar: 
    call DumpRegs  ;desplegar registros en consola

    exit 
main ENDP

END main
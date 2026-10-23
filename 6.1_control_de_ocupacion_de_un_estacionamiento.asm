; 6.1: Control de incremento y decremento en un estacionamiento
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Proposito: Simulador interactivo de control de acceso vehicular usando acumuladores y validaciones de limites
INCLUDE Irvine32.inc

.data
    msgEntrada BYTE "Ingrese cantidad de autos ",0
    msgOcupados BYTE "Espacios ocupados ",0
    msgDisponibles BYTE "Espacios disponibles ",0
    msgLleno BYTE "Estacionamiento lleno",0
    msgExceso BYTE "No hay suficientes espacios disponibles",0
    msgInvalido BYTE "Cantidad invalida",0

    capacidad = 20      ; Limite maximo de cajones en el estacionamiento
    ocupados DWORD 0    ; Variable contadora del estado actual de ocupacion

.code
main PROC
ingresar:
    ; Desplegamos la peticion en consola y capturamos el numero de vehiculos ingresados
    mov edx, OFFSET msgEntrada
    call WriteString

    call ReadInt

    ; Validamos que la cantidad introducida no sea menor o igual a cero
    cmp eax, 0
    jle invalido

    mov ebx, eax

    ; Calculamos la nueva ocupacion sumando los autos nuevos a los ya existentes
    mov eax, ocupados
    add eax, ebx

    ; Comprobamos si el total sobrepasa la capacidad maxima permitida
    cmp eax, capacidad
    jg exceso

    mov ocupados, eax

    ; Informamos cuantos espacios se encuentran ocupados hasta el momento
    mov edx, OFFSET msgOcupados
    call WriteString

    mov eax, ocupados
    call WriteDec
    call Crlf

    ; Verificamos si el estacionamiento llego exactamente al limite de su capacidad
    mov eax, ocupados
    cmp eax, capacidad
    je lleno

    ; Si aun hay espacio, calculamos y mostramos cuantos cajones libres restan
    mov edx, OFFSET msgDisponibles
    call WriteString

    mov eax, capacidad
    sub eax, ocupados
    call WriteDec
    call Crlf
    call Crlf

    jmp ingresar

exceso: ; Rutina ejecutada cuando se intenta rebasar el limite total de cajones
    mov edx, OFFSET msgExceso
    call WriteString
    call Crlf
    call Crlf

    jmp ingresar

invalido: ; Rutina de error para entradas negativas, nulas o no permitidas
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf
    call Crlf

    jmp ingresar

lleno: ; Mensaje de advertencia cuando el estacionamiento esta al 100% de su capacidad
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf

fin:
    exit

main ENDP

END main
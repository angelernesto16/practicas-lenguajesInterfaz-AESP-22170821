; 02. Ingreso de datos
; Materia: Lenguajes de Interfaz
; Nombre: Angel Ernesto Santos Plazola
; Horario: 08:00 am - 09:00 am
; Docente: Jose Luis Medina Jimenez
; Descripcion : Programa que solicita un nombre por teclado y lo imprime en la consola.

.code 
;CONDICION 1: ZERO FLAGS ;  Se activa (ZF = 1) cuando el resultado de una operación es cero.
    main PROC 
    mov EBX , 1
    cmp ebx, 1
    call dumpRegs 

    mov EAX, 01h
    cmp EAX, EBX
    call dumpRegs

    mov cl, 1111111b
    cmp cl, cl
    call dumpRegs

; CONDICION 2 : SING FLAG ; Se activa (SF = 1) cuando el resultado de una operación aritmética o comparación es negativo.
    mov Eax, 0
    mov EBX, 0

    mov al, -5
    mov bl, 1
    cmp al, bl
    call dumpRegs

; CONDICION 3 : CARRY FLAG ; Se activa (CF = 1) cuando hay un desbordamiento (overflow) en operaciones sin signo.
    mov EAX, 0
    mov EBX, 0

    mov al, 255
    add al, 1

    call dumpRegs

; CASO 4 : OVERFLOW FLAG ; Se activa (OF = 1) cuando hay un desbordamiento en operaciones con signo (el resultado sale del rango permitido).
    mov EAX,0
    mov EBX, 0

    mov al, -128
    mov bl, 1

    cmp al, bl
    call dumpRegs


; CASO 5 : TEST ; Realiza una operación AND lógica bit a bit entre dos operandos, pero sin guardar el resultado,

    mov EAX, 0
    mov EAX, 5 ; 00000101b
    test EAX, 1
    call dumpRegs

    mov EAX, 0 
    mov al, 10000000b
    test al, al
    call dumpRegs

exit
main ENDP

END main

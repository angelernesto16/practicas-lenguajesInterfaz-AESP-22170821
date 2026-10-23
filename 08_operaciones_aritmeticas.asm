; 08- Operaciones Aritmeticas basicas
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Proposito: Practica de calculos aritmeticos elementales (suma, resta, multiplicacion y division) empleando registros y datos directos.
INCLUDE Irvine32.inc


.code
main PROC  

     ; 01 - ADD y SUB: Evaluacion de adicion y sustraccion
     mov eax, 50
     mov ebx, 20

     add eax, ebx       ; Acumulamos la suma en el registro EAX
     sub eax, 15        ; Restamos una cantidad fija al acumulador

     nop

     call DumpRegs      ; Imprimimos el estado actual de los registros

     ; 02 CF: Comprobacion de desbordamiento en operaciones sin signo (Carry)
     mov eax, 0
     mov al, 255
     add al, 1          ; Forzamos un acarreo al sobrepasar el limite de 8 bits

     nop
     call DumpRegs

     ; 03 OF: Activacion de bandera de desbordamiento con signo
     mov eax,0
     mov al, 127
     add al, 1          ; Rompemos el rango permitido para enteros con signo en un byte

     call DumpRegs

     ; 04 MUL: Multiplicacion cuyo resultado cabe perfectamente en 32 bits
     mov eax, 25
     mov ebx, 3
     
     mul ebx            ; Multiplicamos EAX por EBX

     call DumpRegs

     ; 05 MUL: Multiplicacion que genera un producto excedente (fuera de 32 bits)
     mov eax, 65537
     mov ebx, 65537

     mul ebx            ; El resultado amplio se distribuye entre EDX y EAX

     ; 06 IMUL: Multiplicacion avanzada con numeros signados
     mov eax, -5
     mov ebx, 3

     imul ebx, eax, 3   ; Operacion de producto con signo de tres operandos

     nop

     ; 07 DIV: Division entera sin signo con valores pequeños
     mov eax, 125
     mov edx, 0         ; Limpiamos la parte alta del dividendo antes de dividir
     mov ebx, 12

     div ebx            ; Dividimos el par EDX:EAX entre el divisor EBX

     nop

     ; 08 IDIV: Division que incluye enteros con signo
     mov eax, -125
     cdq                ; Extendemos el signo de EAX hacia EDX de forma segura
     mov ebx, 12

     idiv ebx           ; Ejecutamos la division con signo

     nop

     exit

main ENDP

END main
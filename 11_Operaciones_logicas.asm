; 11.- Operaciones logicas a nivel de bits
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Sinopsis: Aplicacion de compuertas logicas (AND, OR, XOR, TEST) para mascara y manipulacion de estados binarios.
INCLUDE Irvine32.inc

; MAPA DE BITS (ESTADOS DEL SISTEMA):
; Bit 0 = Computadora encendida (0: No, 1: Si)
; Bit 1 = Estado de alarma      (0: No, 1: Si)
; Bit 2 = Conexion de corriente  (0: No, 1: Si)
; Configuracion de prueba inicial: 00000101b

.data
    msgEncendida BYTE "Alarma esta encendida", 0
    msgApagada BYTE "Alarma esta apagada", 0

.code
main PROC  

; CASO 1: AND (Utilizado como mascara para aislar el bit de alarma)
    mov al, 00000101b
    and al, 00000010b   ; Filtramos dejando unicamente el bit correspondiente a la alarma

    call WriteBin       ; Mostramos el resultado binario en la consola

; CASO 2: OR (Modificacion para forzar el encendido del bit de alarma)
    mov eax, 0
    mov al, 00000101b
    or al, 00000010b    ; Activamos el bit de la alarma sin alterar los demas

    call WriteBin

; CASO 3: XOR (Invierte o limpia los bits segun la mascara aplicada)
; Base de trabajo: 00000101b
    mov eax, 0
    mov al, 00000101b
    xor al, 00000101b   ; Aplica un operador exclusivo que anula los bits coincidentes

    call WriteBin
    call Crlf
    
; CASO 4: TEST (Evaluacion no destructiva para bifurcacion condicional)
; Verificamos si la alarma esta activa o inactiva para emitir el aviso correspondiente
    mov al, 00000101b
    test al, 00000010b  ; Comprobacion logica bit a bit que actualiza unicamente la bandera Zero (ZF)
    jz alarmaApagada    ; Salto condicional si ZF = 1 (indica que esta apagada)

    mov edx, OFFSET msgEncendida ; Cargamos la direccion de texto para notificar operacion activa
    call WriteString
    call Crlf
    jmp FinPrograma

AlarmaApagada: ; Etiqueta de desviacion en caso de que la prueba resulte en cero
    mov edx, OFFSET msgApagada
    call WriteString
    call Crlf

FinPrograma:
	exit

main ENDP

END main
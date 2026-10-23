;06- DECREMENTO E INCREMENTO
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;DESCRIPCION: USO DE LAS INSTRUCCIONES INC Y DEC APLICADAS A UN CONTADOR PARA SIMULAR LA ENTRADA Y SALIDA DE VEHICULOS DE UN ESTACIONAMIENTO

INCLUDE Irvine32.inc 
.data 
    msgPIN BYTE "Ingrese la clave: ",0  
    msgError BYTE "Clave Incorrecta.",0
    msgAcceso BYTE "Acceso permitido",0
    msgBloqueo BYTE "Sistema Bloqueado",0
    msgIntentos BYTE "Intentos restantes: ",0

    claveCorrecta = 1234

.code
main PROC
    mov ebx, 3          ; Inicializamos el contador de oportunidades en 3
    
    intentar:
    mov edx, OFFSET msgPIN
    call WriteString    ; Solicitamos el PIN en pantalla
    call ReadInt        ; Capturamos el número ingresado por teclado

    cmp eax, claveCorrecta

    je acceso           ; Si la clave es correcta, saltamos al área de éxito

    mov edx, OFFSET msgError 
    call WriteString    ; Informamos que el dato ingresado es erróneo
    call crlf

    dec ebx             ; Restamos uno al total de intentos disponibles

    jz bloqueado        ; Si las oportunidades llegan a 0, pasamos al bloqueo

    mov edx, OFFSET msgIntentos
    call WriteString

    mov eax, ebx
    call WriteDec       ; Imprimimos cuántos intentos le quedan al usuario
    call crlf

    jmp intentar        ; Retornamos al inicio para pedir la clave nuevamente

acceso:
    mov edx, OFFSET msgAcceso
    call WriteString    ; Mostramos mensaje de validación correcta
    jmp fin

bloqueado:
    mov edx, OFFSET msgBloqueo
    call WriteString    ; Mostramos advertencia de seguridad por intentos agotados
    jmp fin

fin:
    exit                ; Finalizamos la ejecución del programa
main ENDP

END main
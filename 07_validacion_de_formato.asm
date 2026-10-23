;7.- VALIDACION DE FORMATOS
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
;VERIFICACION DE LOS DATOS DE ENTRADA PARA ASEGURAR QUE CUMPLEN CON LA LONGITUD, RANGO O TIPO DE CARACTER ESPERADO


INCLUDE Irvine32.inc

.data
    prompt BYTE "Ingresa el codigo (ej. TEC-123): ", 0
    msg_valido BYTE "Formato valido. La cadena cumple todas las reglas.", 13, 10, 0

    ; Avisos de fallo personalizados para cada regla de validacion
    err_longitud BYTE "Formato invalido: La longitud no es igual a 7.", 13, 10, 0
    err_letras   BYTE "Formato invalido: Las posiciones 0-2 no son letras mayusculas (A-Z).", 13, 10, 0
    err_guion    BYTE "Formato invalido: Falta el separador '-' en la posicion 3.", 13, 10, 0
    err_digitos  BYTE "Formato invalido: Las posiciones 4-6 no son digitos (0-9).", 13, 10, 0

    buffer BYTE 20 DUP(0)
    bytesLeidos DWORD ?

.code
main PROC
    ; Desplegamos la peticion en pantalla y capturamos la entrada del usuario
    mov edx, OFFSET prompt
    call WriteString
    mov edx, OFFSET buffer
    mov ecx, SIZEOF buffer
    call ReadString
    mov bytesLeidos, eax

    ; REGLA 1: Comprobamos que la longitud exacta sea de 7 caracteres
    cmp eax, 7
    jne error_longitud     ; Si la dimension no coincide, desviamos al error respectivo
    mov esi, OFFSET buffer ; Inicializamos el puntero base al inicio del buffer
    
    ; REGLA 2: Verificamos caracteres alfabeticos en mayuscula (del indice 0 al 2)
    mov ecx, 3
    validar_letras:
    mov al, [esi]
    cmp al, 'A'
    jb error_letras        ; Salta al error si esta por debajo de la 'A'
    cmp al, 'Z'
    ja error_letras        ; Salta al error si supera la 'Z'
    inc esi
    loop validar_letras

    ; REGLA 3: Validamos la existencia del guion medio exacto en el indice 3
    mov al, [esi]
    cmp al, '-'
    jne error_guion        ; Salta si el separador no es un guion
    inc esi
    
    ; REGLA 4: Checamos que los ultimos tres caracteres sean numeros del 0 al 9
    mov ecx, 3
    validar_digitos:
    mov al, [esi]
    cmp al, '0'
    jb error_digitos       ; Salta al error si es menor que '0'
    cmp al, '9'
    ja error_digitos       ; Salta al error si es mayor que '9'
    inc esi
    loop validar_digitos
    
    ; CASO DE EXITO: Se cumplieron satisfactoriamente todas las condiciones
    mov edx, OFFSET msg_valido
    call WriteString
    jmp fin
    
    ; RUTINAS DE MANEJO DE ERRORES: Despliegue de fallos particulares
    error_longitud:
    mov edx, OFFSET err_longitud
    call WriteString
    jmp fin
    
    error_letras:
    mov edx, OFFSET err_letras
    call WriteString
    jmp fin
    
    error_guion:
    mov edx, OFFSET err_guion
    call WriteString
    jmp fin
    
    error_digitos:
    mov edx, OFFSET err_digitos
    call WriteString
    
    fin:
    exit
main ENDP
END main
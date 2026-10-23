; 14.- Captura y almacenamiento de datos numericos
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Descripcion: Mecanismo de lectura interactiva, validacion estricta de rangos numericos y actualizacion de stock en memoria

INCLUDE Irvine32.inc
.data
    mensajeEntrada BYTE "Cuantas unidades llegaron (1-99): ", 0
    mensajeError BYTE "Entrada invalida. Escribe solo digitos, de 1 a 99.", 13, 10, 0
    mensajeResultado BYTE "Existencia actual: ", 0
    mensajeUnidades BYTE " unidades", 13, 10, 0

    ; Espacio auxiliar reservado: ReadString requiere dimensiones para los caracteres validos y el byte nulo final.
    entrada BYTE 16 DUP(0)
    salida BYTE 11 DUP(0)

    cantidadRecibida DWORD ?
    existenciaActual DWORD 25

.code
main PROC

solicitarEntrada:
    mov edx, OFFSET mensajeEntrada
    call WriteString

    ; La funcion ReadString almacena el texto ingresado y devuelve en EAX el total de caracteres capturados.
    mov edx, OFFSET entrada
    mov ecx, SIZEOF entrada
    call ReadString

    ; Validamos que la longitud de la cadena introducida sea exclusivamente de 1 o 2 caracteres.
    cmp eax, 1
    jb entradaInvalida
    cmp eax, 2
    ja entradaInvalida

    ; Proceso de conversion: transforma cada caracter ASCII obtenido en su valor numerico real.
    mov esi, OFFSET entrada
    mov ecx, eax
    xor ebx, ebx

convertirDigitos:
    movzx eax, BYTE PTR [esi]
    cmp al, '0'
    jb entradaInvalida
    cmp al, '9'
    ja entradaInvalida

    sub eax, '0'
    imul ebx, ebx, 10
    add ebx, eax

    inc esi
    loop convertirDigitos

    ; Filtro de seguridad adicional para rechazar valores fuera del rango permitido o ceros (como "00").
    cmp ebx, 1
    jb entradaInvalida
    cmp ebx, 99
    ja entradaInvalida

    mov cantidadRecibida, ebx

    ; Actualizamos el inventario sumando las nuevas unidades recibidas al registro base.
    mov eax, existenciaActual
    add eax, cantidadRecibida
    mov existenciaActual, eax

    ; Transformamos el resultado numerico en formato de texto legible para imprimirlo en pantalla.
    mov eax, existenciaActual
    mov edi, OFFSET salida
    call DwordToString

    mov edx, OFFSET mensajeResultado
    call WriteString
    mov edx, OFFSET salida
    call WriteString
    mov edx, OFFSET mensajeUnidades
    call WriteString

    exit

entradaInvalida: ; Rutina de manejo de errores: notifica el fallo al usuario y reinicia el ciclo de captura
    mov edx, OFFSET mensajeError
    call WriteString
    jmp solicitarEntrada

main ENDP

; Parametros de entrada: EAX = Valor entero de 32 bits sin signo, EDI = Direccion de memoria del buffer de salida.
; Salida esperada: Cadena de caracteres decimales terminada en cero almacenada en el buffer.
DwordToString PROC USES eax ebx ecx edx edi
    mov ebx, 10
    xor ecx, ecx

    ; Evaluamos si el numero es estrictamente cero para manejarlo de forma directa.
    cmp eax, 0
    jne dividirNumero
    mov BYTE PTR [edi], '0'
    inc edi
    jmp terminarCadena

dividirNumero: ; Bucle iterativo de divisiones sucesivas entre 10 para extraer los digitos uno a uno
    xor edx, edx
    div ebx
    push edx
    inc ecx
    test eax, eax
    jnz dividirNumero

    ; Los restos se obtienen en orden inverso, por lo que la pila nos ayuda a reordenarlos correctamente.
escribirDigitos:
    pop edx
    add dl, '0'
    mov BYTE PTR [edi], dl
    inc edi
    loop escribirDigitos

terminarCadena: ; Anexamos el delimitador nulo al final de la cadena ensamblada
    mov BYTE PTR [edi], 0
    ret
DwordToString ENDP

END main
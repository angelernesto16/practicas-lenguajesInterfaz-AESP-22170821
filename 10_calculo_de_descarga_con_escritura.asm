; 10.- Obtencion de una cadena decimal
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Descripcion: Lectura, conversion y formateo de datos para su representacion en base 10
INCLUDE Irvine32.inc

.data ; Definicion de variables globales y cadenas de texto para la interfaz de consola
    descargados DWORD ?
    pendientes  DWORD ?
    porcentaje  DWORD ?
    grupos      DWORD ?
    residuo     DWORD ? 

    buffer BYTE 11 DUP(?), 0

    msgDesc BYTE "Bytes descargados: ", 0
    msgPend BYTE "Bytes pendientes: ", 0
    msgPorc BYTE "Porcentaje de avance: ", 0
    msgGrup BYTE "Grupos completos de 1024 bytes: ", 0
    msgResi BYTE "Residuo del agrupamiento: ", 0

.code 
main PROC 
    mov eax, 125          ; Asignamos la cantidad de sectores descargados
    mov ebx, 512          ; Establecemos el factor de multiplicacion por sector
    mul ebx               ; Multiplicamos sectores por tamano unitario; el resultado queda en EAX
    mov descargados, eax  ; Guardamos el total de bytes procesados

    ; Calculamos el volumen restante restando los descargados a una meta fija de 100,000
    mov ebx, 100000
    sub ebx, eax
    mov pendientes, ebx

    ; Determinamos el porcentaje de progreso actual mediante una regla de tres
    mov eax, descargados 
    mov ebx, 100
    mul ebx
    mov ebx, 100000
    xor edx, edx
    div ebx
    mov porcentaje, eax

    ; Obtenemos bloques de 1024 bytes (KBs) y el sobrante mediante division entera
    mov eax, descargados 
    mov ebx, 1024
    xor edx, edx
    div ebx
    mov grupos, eax
    mov residuo, edx

    ; Mostramos en pantalla el total de bytes descargados
    mov edx, OFFSET msgDesc 
    call WriteString
    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprimimos los bytes que restan por descargar
    mov edx, OFFSET msgPend 
    call WriteString
    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Presentamos el porcentaje completado en formato legible
    mov edx, OFFSET msgPorc 
    call WriteString
    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString

    mov al, '%'         ; Anexamos manualmente el caracter de porcentaje al final
    call WriteChar      
    call Crlf

    ; Desplegamos la cantidad de bloques de 1024 bytes obtenidos
    mov edx, OFFSET msgGrup 
    call WriteString
    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; Imprimimos el sobrante o residuo del agrupamiento
    mov edx, OFFSET msgResi 
    call WriteString
    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal
    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP

convertirDecimal PROC ; Subrutina personalizada para transformar un valor entero en una cadena de texto ASCII decimal
    pushad
    mov ecx, 0
    mov ebx, 10

DividirLoop: ; Bucle iterativo para aislar cada digito numerico mediante divisiones sucesivas
    xor edx, edx
    div ebx
    add dl, 30h         ; Convertimos el residuo numerico a su respectivo caracter ASCII
    push dx
    inc ecx
    cmp eax, 0
    jne DividirLoop

ExtraerLoop: ; Extraemos los digitos de la pila en orden inverso para alinearlos correctamente en el buffer
    pop dx
    mov [esi], dl
    inc esi
    loop ExtraerLoop

    mov BYTE PTR [esi], 0 ; Delimitamos el fin de la cadena con un byte nulo
    popad
    ret
convertirDecimal ENDP

END main
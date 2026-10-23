; 13.- Obtencion de una cadena hexadecimal
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Descripcion: Lectura, conversion y formateo de datos para su representacion en base a 16
INCLUDE Irvine32.inc

.data ; Seccion de variables: almacena el valor numerico original y el buffer para el texto hexadecimal
    numero    DWORD 12AB34CDh
    bufferHex BYTE 8 DUP('?'), 0    
    mensaje   BYTE "Hexadecimal: ", 0
     
.code ; Bloque principal: gestiona el despliegue del rotulo y llama a la subrutina de conversion
main PROC
    mov edx, OFFSET mensaje
    call WriteString

    mov eax, numero
    mov esi, OFFSET bufferHex
    call ConvertirAHex

    mov edx, OFFSET bufferHex
    call WriteString
    call Crlf

    exit
main ENDP

ConvertirAHex PROC ; Subrutina encargada de transformar un valor numerico de 32 bits a una cadena hexadecimal ASCII
    pushad
    
    add esi, 7              
    mov ecx, 8             

CicloHex: ; Bucle iterativo para aislar y procesar cada nibble (4 bits) en orden inverso
    mov edx, eax
    and dl, 0Fh             

    cmp dl, 9
    jbe EsNumero
    add dl, 37h              ; Ajuste ASCII especifico para letras de la A a la F
    jmp GuardarDigito

EsNumero: ; Etiqueta para tratar digitos numericos puros (0-9) aplicandoles su desplazamiento ASCII
    add dl, 30h             

GuardarDigito: ; Inserta el caracter procesado en el buffer, desplaza el registro y retrocede el puntero
    mov [esi], dl           
    shr eax, 4              
    dec esi                
    loop CicloHex

    popad
    ret
ConvertirAHex ENDP

END main
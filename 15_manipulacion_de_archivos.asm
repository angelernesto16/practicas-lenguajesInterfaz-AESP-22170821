; 15.- Manipulacion de archivos
;MATERIA: LENGUAJES DE INTERFAZ
;ALUMNO: Angel Ernesto Santos Plazola
;HORARIO: 08:00 - 09:00
;DOCENTE: JOSE LUIS MEDINA JIMENEZ
; Descripcion: Creacion, apertura, lectura, escritura o cierre de archivos de texto mediante interrupciones del sistema
INCLUDE Irvine32.inc

.data ; Aqui en data se definen las variables y cadenas de texto que se utilizarán en el programa.
    nombreArchivo BYTE "Inventario.txt", 0 
	texto BYTE "123", 0
	archivoHandle DWORD ?

	mensajeExito BYTE "Archivo guardado:", 0
	mensajeError BYTE "No se pudo guardar el archivo", 0

.code ; Aqui se define el código del programa, que es donde se escriben las instrucciones que se ejecutarán.
main PROC  
    ; 1 Crear el archivo TXT.
	mov edx, OFFSET nombreArchivo
	call CreateOutputFile

	cmp eax, INVALID_HANDLE_VALUE
	je error

	mov archivoHandle, eax

	; 2 Escribir los caracteres ("125").
	mov eax, archivoHandle
	mov edx, OFFSET texto
	mov ecx, SIZEOF texto - 1
    call WriteToFile

	jc errorEscritura

	cmp eax, SIZEOF texto - 1
	jnr error

	; 3 Guardar el archivo o cerrar el archivo.
	mov eax, archivoHandle
	call CloseFile

	test eax, eax
	jz error

	mov edx, OFFSET mensajeExito
	call WriteString
	jmp fin


errorEscritura: ; Mostramos un mensaje de error si no se pudo escribir en el archivo.
    mov eax, archivoHandle
	call CloseFile
error: ; Mostramos un mensaje de error si no se pudo crear el archivo.
    mov edx, OFFSET mensajeError
	call WriteString
fin: 
	exit

main ENDP

END main
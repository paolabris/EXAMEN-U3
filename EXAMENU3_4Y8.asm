;****************************************************************
;EXAMEN UNIDAD 3
;03/06/2021
;4 PAOLA MONSERRAT DIAZ BRISENO
;8 DARIEN RAFEL MARQUEZ VAZQUEZ
;HORA: 11AM 
;****************************************************************
include BIBLIO_MACRO.lib ;incluir biblioteca de macros

.model small              
.stack
.data 
    
    msjTit db 'EXAMEN U3- DARIEN Y PAOLA',10,13,'$'
    
    ruta  db 'C:\EXAMEN U3\',0
    ruta1 db 'C:\EXAMEN U3\WALL-E',0
    ruta2 db 'C:\EXAMEN U3\WALL-E\Riego.txt',0
     
    msjIni db 'Creando directorio...',10,13,'$'
    msjSi  db 'Se ha creado el directorio',10,13,'$'
    msjNO  db 'No se ha creado el directorio',10,13,'$'
     
    msjSiEscribir   db 'Se ha escrito en el archivo. Verifique$'
    msjNoEscribir   db 'No se ha podido ESCRIBIR en el archivo. Verifique$'
      
    msjNOLeer db 'NO se ha podido leer el archivo'
    msjNOAbrir db 'NO se ha podido abrir el archivo'
    

    msjSalida db 10,13, 'Datos le',161,'dos del archivo:',10,13
    leido db 500 dup('$')
    
    ;--DATOS A ESCRIBIR--
    datosRiego  db '18-06-2021 Riego Completo'
    totalEscribir   dw  26
    manejador       dw  0  
    
.code
inicio: mov ax,@data
        mov ds,ax
        mov es,ax  
                   
        MOV DX, offset msjTit
                   
        ;--CREAR ARCHIVOS EN C 
        
        MOV AH,39H
        LEA DX,ruta
        INT 21H 
        
        MOV AH,39H
        LEA DX,ruta1
        INT 21H
        
        jc errorCrear
        
        CADENA_SIN_COLOR msjSi 
        
        jmp fin
        
        ;--ESCRIBIR ARCHIVOS TXT 
        
        ;1. Abrir el archivo
            MOV AH,3DH    ;ABRIR ARCHIVO
            LEA DX,ruta2
            MOV AL,2  ;
            INT 21H
            MOV manejador,AX ;Recuperar ID
                
            JC errorAbrir
             
            ; Se pudo abrir: 
                
                MOV AH,40H          ;Escribir en el archivo
                MOV BX,manejador    
                MOV CX,totalEscribir 
                LEA DX,datosRiego
                INT 21H
                
            JC errorEscribir
            
                CADENA_SIN_COLOR msjSiEscribir
                JMP fin
        
         
        ;--LECTURA DE ARCHIVOS TXT 
        
        ;1. Abrir el archivo
        mov ah,3dh
        lea dx,ruta2
        mov al,2  ;lectura/escritura
        int 21h
        
        mov manejador,ax 
        jc errorAbrir  
        
        ;2. Proceder a la lectura
        mov ah,3fh
        mov cx,15 ;caracteres a leer
        lea dx,leido
        mov bx,manejador
        int 21h
        jc errorLeer 
        
        ;3. Mostrar datos en pantalla
        
        CADENA_SIN_COLOR msjSalida
        CADENA_SIN_COLOR leido
        jmp fin
        
errorCrear: 
    CADENA_SIN_COLOR msjNo
            
errorAbrir: 
    CADENA_SIN_COLOR msjNOabrir
    jmp fin
    
errorEscribir:

    CADENA_SIN_COLOR msjNOEscribir      
    
errorLeer: 
    CADENA_SIN_COLOR msjNOleer
        
        
fin: 
       mov ax,4c00h
       int 21h
        
;************************PROCEDIMIENTOS***************
;no se si los quieras incluir con un bloc de notas 
;o poner aqui
;*****************************************************
end
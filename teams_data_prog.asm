section .data
lines db'--------------------------------------------------------------------------------- ',10
lenlines equ $-lines
Title db 'Welcome to the kenyan soccer teams data management system.With this you will be able to create files which in each file will be categorized by teams and each file will hold the soccer teams information. ' ,10
lenTitle equ $-Title
lines1 db'---------------------------------------------------------------------------------',10
lenlines1 equ $-lines1

Query db 'Please type in the word in the bracket of what you want to do;',10
lenQuery equ $-Query
Options db'1. Create a team file(crt)      2. Open an existing team file to read it(open)  ',10  
lenOptions equ $-Options
Options1 db '3.Delete a  team file(del)',10  
lenOptions1 equ $-Options1

Fname db'Please give the team file you want to create a name(preferably the teams name)',10
lenFname equ $-Fname

Info0 db'Write the teams information:',10
lenInfo0 equ $-Info0
Info1 db'TEAM REGISTRATION NUMBER:',10
lenInfo1 equ $-Info1
Info2 db'NAME OF TEAM:',10
lenInfo2 equ $-Info2
Info3 db'NAME OF OWNER:',10
lenInfo3 equ $-Info3
Info4 db'NAME OF MANAGER:',10
lenInfo4 equ $-Info4
Info5 db'DATE OF FOUNDED(In format of 25-7-1998):',10
lenInfo5 equ $-Info5
Info6 db'YEARLY BUDGET(IN KSH):',10
lenInfo6 equ $-Info6
Info7 db'MONTHLY INCOME(IN KSH):',10
lenInfo7 equ $-Info7
Info8 db'MONTHLY EXPENDITURE(IN KSH):',10
lenInfo8 equ $-Info8
Info9 db'NAME OF SPONSORS:',10
lenInfo9 equ $-Info9
Info10 db'TEAM HOMEGROUND:',10
lenInfo10 equ $-Info10
Info11 db'TEAM TRAINING GROUND:',10
lenInfo11 equ $-Info11
Info12 db'NUMBER OF PLAYERS REGISTERED:',10
lenInfo12 equ $-Info12
Info13 db'NUMBER OF LEAGUE TITLES:',10
lenInfo13 equ $-Info13
Info14 db'NUMBER OF CUP TITLES:',10
lenInfo14 equ $-Info14
Info15 db'CONTACT NUMBER:',10
lenInfo15 equ $-Info15
Info16 db'EMAIL:',10
lenInfo16 equ $-Info16
Info17 db'CLUB ADDRESS:',10
lenInfo17 equ $-Info17



num1 db 'crt',10
lennum1 equ $-num1
num2 db 'open',10
lennum2 equ $-num2
num3 db 'yes',10
lennum3 equ $-num3
num4 db 'no',10
lennum4 equ $-num4
num7 db 'del',10
lennum7 equ $-num7

Oname db'Please give the name of the team file you want to open',10
lenOname equ $-Oname
Finfo db'Team File information is:',10
lenFinfo equ $-Finfo

Query4 db 'Please input name of team file you want to delete: ',10
lenQuery4 equ $-Query4
Query5 db 'Do you want to create another Soccer team file: ',10
lenQuery5 equ $-Query5
Confi1 db 'Team File Created'
lenConfi1 equ $-Confi1
Confi2 db 'Team File Deleted'
lenConfi2 equ $-Confi2

%macro write_string 2 
mov eax, 4 
mov ebx, 1 
mov ecx, %1 
mov edx, %2 
int 80h 
%endmacro

section .bss
ans resb 5
file_name resb 30
write_opt resb 5

Tno resb 20
Tname resb 20
Owname resb 40
Manname resb 40
DF resb 20
Year_budg resb 20
income resb 20
expenditure resb 20
sponsors resb 100
homegrd resb 50
Tragrd resb 50
no_players resb 15
no_leagues resb 15
no_cups resb 15
contact_no resb 15
email resb 25
club_adrr resb 40


del_name resb 30
crt_opt resb 10

fd_out resb 1
fd_in  resb 1
write_opt2 resb 5
info resb  3000
open_name resb 30




section .text
global _start         ;must be declared for using gcc
	
_start:
write_string lines,lenlines
write_string Title,lenTitle 
write_string lines1,lenlines1
write_string Query,lenQuery
write_string Options,lenOptions
write_string Options1,lenOptions1

;Read and strore data input
mov eax,3
mov ebx,0
mov ecx,ans
mov edx,5
int 80h


;Loop for determining choice
mov ecx,[ans]
cmp ecx,[num1]
je L1
cmp ecx,[num2]
je L2
cmp ecx,[num7]
je L3
mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

;Creating a file
L1:
   write_string Fname,lenFname 
   ;Read and store the user input 
    mov eax, 3 
    mov ebx, 2 
    mov ecx, file_name 
    mov edx, 30 ;30 bytes (numeric, 1 for sign) of that information 
    int 80h 

   ;create the file
   mov  eax, 8
   mov  ebx, file_name
   mov  ecx, 0777        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax
write_string Confi1,lenConfi1
;User prompt
write_string Info0,lenInfo0
write_string Info1,lenInfo1
; write string into the file
   mov	edx,lenInfo1       ;number of bytes
   mov	ecx, Info1        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Tno
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, Tno        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info2,lenInfo2
; write string into the file
   mov	edx,lenInfo2       ;number of bytes
   mov	ecx, Info2        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Tname
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, Tname        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info3,lenInfo3
; write string into the file
   mov	edx,lenInfo3       ;number of bytes
   mov	ecx, Info3        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Owname
mov edx, 40 ;40 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,40         ;number of bytes
   mov	ecx, Owname      ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info4,lenInfo4
; write string into the file
   mov	edx,lenInfo4       ;number of bytes
   mov	ecx, Info4        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Manname
mov edx, 40 ;40 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,40         ;number of bytes
   mov	ecx, Manname        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info5,lenInfo5
; write string into the file
   mov	edx,lenInfo5       ;number of bytes
   mov	ecx, Info5        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, DF
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, DF        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info6,lenInfo6
; write string into the file
   mov	edx,lenInfo6       ;number of bytes
   mov	ecx, Info6        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Year_budg
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, Year_budg        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info7,lenInfo7
; write string into the file
   mov	edx,lenInfo7       ;number of bytes
   mov	ecx, Info7        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, income
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20        ;number of bytes
   mov	ecx,income       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info8,lenInfo8
; write string into the file
   mov	edx,lenInfo8       ;number of bytes
   mov	ecx, Info8        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, expenditure
mov edx, 20 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,20         ;number of bytes
   mov	ecx, expenditure        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info9,lenInfo9
; write string into the file
   mov	edx,lenInfo9       ;number of bytes
   mov	ecx, Info9        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, sponsors
mov edx, 100 ;100 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,100        ;number of bytes
   mov	ecx, sponsors        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info10,lenInfo10
; write string into the file
   mov	edx,lenInfo10       ;number of bytes
   mov	ecx, Info10        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, homegrd
mov edx, 50 ;50 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx, 50         ;number of bytes
   mov	ecx, homegrd     ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info11,lenInfo11
; write string into the file
   mov	edx,lenInfo11       ;number of bytes
   mov	ecx, Info11        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, Tragrd
mov edx, 50 ;50 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,50         ;number of bytes
   mov	ecx, Tragrd        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info12,lenInfo12
; write string into the file
   mov	edx,lenInfo12       ;number of bytes
   mov	ecx, Info12        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, no_players
mov edx, 15 ;15 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,15         ;number of bytes
   mov	ecx, no_players        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel

write_string Info13,lenInfo13
; write string into the file
   mov	edx,lenInfo13       ;number of bytes
   mov	ecx, Info13        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, no_leagues
mov edx, 15 ;15 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,15         ;number of bytes
   mov	ecx, no_leagues       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info14,lenInfo14
; write string into the file
   mov	edx,lenInfo14       ;number of bytes
   mov	ecx, Info14        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, no_cups
mov edx, 15 ;15 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,15         ;number of bytes
   mov	ecx, no_cups       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info15,lenInfo15
; write string into the file
   mov	edx,lenInfo15       ;number of bytes
   mov	ecx, Info15        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, contact_no
mov edx, 15 ;15 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,15         ;number of bytes
   mov	ecx, contact_no       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info16,lenInfo16
; write string into the file
   mov	edx,lenInfo16       ;number of bytes
   mov	ecx, Info16        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, email
mov edx, 25 ;25 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,25         ;number of bytes
   mov	ecx, email       ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel


write_string Info17,lenInfo17
; write string into the file
   mov	edx,lenInfo17       ;number of bytes
   mov	ecx, Info13        ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, club_adrr
mov edx, 40 ;40 bytes (numeric, 1 for sign) of that information 
int 80h

; write  input into the file
   mov	edx,40         ;number of bytes
   mov	ecx, club_adrr      ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel







; close the file
   mov eax, 6
   mov ebx, [fd_out]

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

L2:
;Open file for reading

write_string Oname,lenOname
;Read and store the user input 
    mov eax, 3 
    mov ebx, 2 
    mov ecx, open_name
    mov edx, 30 ;5 bytes (numeric, 1 for sign) of that information 
    int 80h

;open the file for reading 
mov eax, 5 
mov ebx, open_name 
mov ecx, 0 ;for read only access 
mov edx, 0777 ;read, write and execute by all 
int 0x80

mov [fd_in], byte eax

write_string Finfo,lenFinfo
;read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, info
   mov edx, 3000
   int 0x80
;print the info 
   mov eax, 4
   mov ebx, 1
   mov ecx, info
   mov edx, 3000
   int 0x80
    
  ; close the file
   mov eax, 6
   mov ebx, [fd_in]

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel

L3:;Delete file
    write_string Query4,lenQuery4
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, del_name
mov edx, 10 ;20 bytes (numeric, 1 for sign) of that information 
int 80h    

;Delete file from folder
    mov eax,10
    mov ebx,del_name
    int 80h
write_string Confi2,lenConfi2
write_string Query5,lenQuery5
;Read and store the user input 
mov eax, 3 
mov ebx, 2 
mov ecx, crt_opt
mov edx, 10 ;20 bytes (numeric, 1 for sign) of that information 
int 80h

;Loop for determining choice
mov ecx,[crt_opt]
cmp ecx,[num3]
je L1

mov eax,1 ;system call number (sys_exit) 
int 0x80 ;call kernel      

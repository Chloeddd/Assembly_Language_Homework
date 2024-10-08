DATASEG SEGMENT
	MSG DB "a"
	LINE DB 13, 10, '$'
DATASEG ENDS

CODESEG SEGMENT ;代码段开始
	ASSUME CS:CODESEG,DS:DATASEG
MAIN PROC FAR ;MAIN过程的开始，程序的入口点。FAR:可以跨段调用
	MOV AX,DATASEG ;将数据段的段地址存入AX寄存器
	MOV DS,AX
	
    MOV CX,2
	MOV AH,2

F:  PUSH CX ;利用PUSH保存CX寄存器的值
    MOV CX,13

S:  MOV AL,[MSG]
	MOV DL,AL
	MOV AH,2
	INT 21H
	INC AL
	MOV [MSG],AL

    LOOP S

    ;打印换行符
	MOV DX,OFFSET LINE
	MOV AH, 9
	INT 21H

    POP CX ;恢复外层循环CX
    LOOP F

	MOV AX,4C00H ;正常退出程序
	INT 21H
MAIN ENDP
CODESEG ENDS
	END MAIN
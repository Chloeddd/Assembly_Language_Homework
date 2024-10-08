STKSEG SEGMENT STACK ;定义栈段
DW 32 DUP(0)
STKSEG ENDS

DATASEG SEGMENT ;定义数据段
	MSG DB "Hello$"
DATASEG ENDS

CODESEG SEGMENT ;代码段开始
	ASSUME CS:CODESEG,DS:DATASEG
MAIN PROC FAR ;MAIN过程的开始，程序的入口点。FAR:可以跨段调用
	MOV AX,DATASEG ;将数据段的段地址存入AX寄存器（累加器）
	MOV DS,AX 
	MOV AH,9 ;AH寄存器用来指定 DOS 的中断功能（9表示调用 DOS 的输出字符串服务）
	;MOV DX,OFFSET MSG 与下行代码实现结果相同
	LEA DX,MSG
	INT 21H
	MOV AX,4C00H ;4C是DOS系统调用，用于正常退出程序，00 表示返回码为0，表明程序成功运行
	INT 21H
MAIN ENDP
CODESEG ENDS
	END MAIN

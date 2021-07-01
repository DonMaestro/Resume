DECIMAL_BASE	EQU 0x0A
REVERSE			EQU 0xFFFFFFFF
HIGH_BIT		EQU 0x80000000


				AREA	FUNCTION, CODE, ALIGN=4
				EXPORT BIN_CHAR
				EXPORT FUNC_Z
					
BIN_CHAR		PROC
				
				PUSH {R5-R6, R10-R12}
				
				MOV R10, #0x20			;SPACE
				MOV R11, R2
				
CLEAR
				SUBS R11, #1
				STRB R10, [R0, R11]
				BNE CLEAR
				
				
				LDR R12, =HIGH_BIT
				AND R11, R1, R12
				CMP R11, R12
				LDREQ R12, =REVERSE
				EOREQ R1, R12
				ADDEQ R1, #1
				MOVEQ R12, #1
				
				MOV R11, #10
				MOV R10, R11			
				ADD R0, R2
				
DEGREE
				SUB R0, #1
				CMP R1, R10
				MULCS R10, R10, R11
				BCS DEGREE	
				
				CMP R12, #1
				SUBEQ R0, #1
				MOVEQ R6, #0x2D
				STRBEQ R6, [R0], #1
CONVERT
				UDIV R10, R11
				UDIV R5, R1, R10
				
				ADD R6, R5, #0x30			;transformation to CHAR
				STRB R6, [R0], #1
				MUL R5, R10
				SUB R1, R5
				
				CMP R10, #1
				BNE	CONVERT

				POP {R5-R6, R10-R12}
				BX LR
				
				ENDP





FUNC_Z			PROC
				
				SUB R0, R1
				LSL R0, R0, #1
				
				BX LR
				ENDP
					
					
				END
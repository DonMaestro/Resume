#ifndef HEADER_H
#define	HEADER_H

#include "I2C.h"
#include "LCD.h"

#define CLK					((unsigned long)16)//MHz

void BIN_CHAR(char* result, int gg, unsigned long size);
int FUNC_Z(unsigned long x, unsigned long y);


void BUTTON_INIT(void);
void TIM9_INIT(void);
void TIM2_INIT(void);
void DISPLAY_4B_INIT(struct LCD *LCD);



void TIM10_IRQHandler(void);
void EXTI15_10_IRQHandler(void);


void convert_int_char (char* result, unsigned long numeric, unsigned short size);
void SLEEP_T9(unsigned short time);




#endif

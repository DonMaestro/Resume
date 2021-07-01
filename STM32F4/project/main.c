#include "stm32f4xx.h"
#include "header.h"

char stage = 0;
struct LCD LCD1;

char press = 0;
#define BUTTON_DELAY		((unsigned long) 0x58000)
#define BUTTON_1C_DELAY		((unsigned long) 0x34000)
#define INITIATE			((unsigned short) 10) //us
#define MAX_TIME			((unsigned short) 0x5AA0) //uс = 400см.


unsigned long HC_SR04 (void) {
	
	TIM2->CNT = 0;
	
	GPIOA->ODR |= GPIO_ODR_ODR_1;
	SLEEP_T9(INITIATE);
	GPIOA->ODR &= ~GPIO_ODR_ODR_1;
	
	while( !(GPIOA->IDR & GPIO_IDR_IDR_0) );
	while( (GPIOA->IDR & GPIO_IDR_IDR_0) );
	//SLEEP_T9(MAX_TIME);

	return TIM2->CNT;
}



int main(void) {
	char d_z[3] = "z: ";
	char d_x[3] = "x: ";
	char d_y[3] = "y: ";
	char spase[3] = "   ";
	unsigned long x, y;
	int z;
	unsigned long distance = 0;
	char dis_x_ascii[3], dis_y_ascii[3], dis_z_ascii[3];

	__disable_irq();
	
	
	TIM2_INIT();
	TIM9_INIT();
	I2C_INIT();
	BUTTON_INIT();
	DISPLAY_4B_INIT(&LCD1);
	
	__enable_irq();	
 	while(1) {
		
		distance = HC_SR04() / 16 / 58;
		
			
		switch(stage){
			case 0:
				x = distance;
				LCD_HOME(&LCD1);
				BIN_CHAR(&dis_x_ascii[0], x, sizeof(dis_x_ascii));
				LCD_PRINT(&LCD1, d_x, sizeof(d_x));
				LCD_PRINT(&LCD1, dis_x_ascii, sizeof(dis_x_ascii));
			break;
			case 1:
				y = distance;
				LCD_HOME(&LCD1);
				BIN_CHAR(&dis_y_ascii[0], y, sizeof(dis_y_ascii));
				LCD_PRINT(&LCD1, d_y, sizeof(d_y));
				LCD_PRINT(&LCD1, dis_y_ascii, sizeof(dis_y_ascii));
			break;
			case 2:
				LCD_HOME(&LCD1);
				LCD_PRINT(&LCD1, d_x, sizeof(d_x));
				LCD_PRINT(&LCD1, dis_x_ascii, sizeof(dis_x_ascii));
				LCD_PRINT(&LCD1, spase, sizeof(spase));
				LCD_PRINT(&LCD1, d_y, sizeof(d_y));
				LCD_PRINT(&LCD1, dis_y_ascii, sizeof(dis_y_ascii));
			break;
			case 3:
				//z = (x - y)*2;
				LCD_HOME(&LCD1);
				z = FUNC_Z(x, y);
				BIN_CHAR(&dis_z_ascii[0], z, sizeof(dis_y_ascii));
				LCD_PRINT(&LCD1, d_x, sizeof(d_x));
				LCD_PRINT(&LCD1, dis_x_ascii, sizeof(dis_x_ascii));
				LCD_PRINT(&LCD1, spase, sizeof(spase));
				LCD_PRINT(&LCD1, d_y, sizeof(d_y));
				LCD_PRINT(&LCD1, dis_y_ascii, sizeof(dis_y_ascii));
				LCD_Set_DDRAM(&LCD1, LCD_DDRAM_SECOND_LINE);
				LCD_PRINT(&LCD1, d_z, sizeof(d_z));
				LCD_PRINT(&LCD1, dis_z_ascii, sizeof(dis_z_ascii));
			break;
		}
		
		SLEEP_T9(0xFFFF); //65535 мкс
		SLEEP_T9(0xFFFF); //65535 мкс
	}
}





//при відпусканні кнопки 
void EXTI15_10_IRQHandler(void) {
	unsigned long i;
	char press = 0;
	
	EXTI->IMR &= ~EXTI_IMR_IM13;
	
	for(i = 0; i < BUTTON_DELAY; i++) {
		//натиск
		if(!(GPIOC->IDR & GPIO_IDR_IDR_13) && i > BUTTON_1C_DELAY) {
			press = 1;
			//чекаємо поки відпущення
			while(!(GPIOC->IDR & GPIO_IDR_IDR_13)) {}
			break;
		}
	}
	
	if(press)
		stage = 0x3;
	else {
		//stage = (stage >= 2) ? 0 : stage++;
		if(stage >= 0x2)
			stage = 0;
		else
			stage++;
	}
	
	LCD_CLEAR(&LCD1);
	
	EXTI->PR |= EXTI_PR_PR13;
	EXTI->IMR |= EXTI_IMR_IM13;
}



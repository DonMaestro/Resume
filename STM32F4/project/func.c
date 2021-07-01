#include "header.h"


void BUTTON_INIT(void) {
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;		//button
	//button
	RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;
	
	SYSCFG->EXTICR[3] |= SYSCFG_EXTICR4_EXTI13_PC;
	
	EXTI->IMR |= EXTI_IMR_IM13;
	EXTI->RTSR |= EXTI_RTSR_TR13;
	
	NVIC_EnableIRQ(EXTI15_10_IRQn);
}



void TIM9_INIT(void) {
	RCC->APB2ENR |= RCC_APB2ENR_TIM9EN;
	
	TIM9->CR1 |= TIM_CR1_OPM;
	TIM9->PSC = CLK-1;
	TIM9->CR1 |= TIM_CR1_CEN;
}

void TIM2_INIT(void) {
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;		//
	//PA0 echo HC_SR04
	GPIOA->MODER |= GPIO_MODER_MODER0_1;
	GPIOA->AFR[0] |= GPIO_AFRL_AFSEL0_0;
	
	//PA1 trig HC_SR04
	GPIOA->MODER |= GPIO_MODER_MODER1_0;
	
	
	
	RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;
	
	//налаштовуємо на вхід
	TIM2->CCMR1 |= TIM_CCMR1_CC1S_0;		//TI1
	
	TIM2->CCER &= ~TIM_CCER_CC1NP;
	TIM2->CCER &= ~TIM_CCER_CC1P;
	
	TIM2->CCER |= TIM_CCER_CC1E;
	
	
	TIM2->SMCR |= 0x5 << TIM_SMCR_SMS_Pos;
	TIM2->SMCR |= 0x5 << TIM_SMCR_TS_Pos;
	//TIM2->DIER |= TIM_DIER_CC1IE;
	//TIM2->DIER |= TIM_DIER_UIE;
	
	TIM2->CR1 |= TIM_CR1_CEN;
	//TIM2->PSC = CLK-1;
	//NVIC_EnableIRQ(TIM2_IRQn);
	//NVIC_ClearPendingIRQ(TIM2_IRQn);
}



void DISPLAY_4B_INIT(struct LCD *LCD) {
	LCD->ADDRESS = 0x7E;
	LCD->FUNC_SET &= ~LCD_FUNCTION_SET_DL;
	
	LCD_MODE(LCD);
	
	LCD->FUNC_SET |= LCD_FUNCTION_SET_N;
	LCD->FUNC_SET &= ~LCD_FUNCTION_SET_F;
	LCD_FUNC_SET(LCD);
		
	LCD->D_ON_OFF = LCD_DISPLAY_ON_D;
	LCD_ON(LCD);
	
	LCD->ENT_MOD_SET |= LCD_ENTRY_MODE_SET_I_D;
	LCD_ENTRY_MODE(LCD);
	
	
	//display
	LCD_BACKLIGHT_ON(LCD);
	LCD_CLEAR(LCD);
}



void SLEEP_T9(unsigned short time) {
	//delay [us]
	TIM9->ARR = time;
	TIM9->CR1 |= TIM_CR1_CEN;
	while(TIM9->CR1 & TIM_CR1_CEN) {}
}




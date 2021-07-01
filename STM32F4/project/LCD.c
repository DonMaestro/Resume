#include "LCD.h"


void sleep(unsigned long sl) {
	int i=0;
	sl = sl << 10;
	for(; i < sl; i++) {}
}


void LCD_MODE(struct LCD *display) {
	char byte;
	
	byte = (display->BACKLIGHT) ? LCD_COTROL_BIT_BACKLIGHT : 0;
	byte += ( display->FUNC_SET & ~HALF_CHAR ) + LCD_FUNCTION_SET + LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
	byte -= LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
}


void LCD_FUNC_SET(struct LCD *display) {
	display_write(display, LCD_FUNCTION_SET, display->FUNC_SET);
}


void LCD_ON(struct LCD *display) {
	display_write(display, LCD_DISPLAY_ON, display->D_ON_OFF);
}


void LCD_ENTRY_MODE(struct LCD *display) {
	display_write(display, LCD_ENTRY_MODE_SET, display->ENT_MOD_SET);
}


void LCD_HOME(struct LCD *display) {
	display_write(display, LCD_HOME_DISPLAY, 0x00);
	sleep(18);
}

void LCD_CLEAR(struct LCD *display) {
	display_write(display, LCD_CLEAR_DISPLAY, 0x00);
	sleep(18);
}



void LCD_BACKLIGHT_ON(struct LCD *display) {
	display->BACKLIGHT = 1;
	display_write(display, 0x00, 0x00);
}

void LCD_BACKLIGHT_OFF(struct LCD *display) {
	display->BACKLIGHT = 0;
	display_write(display, 0x00, 0x00);
}


void LCD_Set_DDRAM(struct LCD *display, char address) {
	display_write(display, LCD_Set_DDRAM_address, address);
}


void display_write(struct LCD *display, char control, char data) {
	char byte;
	
	__disable_irq();
	
	byte = (display->BACKLIGHT) ? LCD_COTROL_BIT_BACKLIGHT : 0;
	byte += ( (data + control) & ~HALF_CHAR ) + LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
	byte -= LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
	
	
	byte = (display->BACKLIGHT) ? LCD_COTROL_BIT_BACKLIGHT : 0;
	byte += ( (data + control) << 4) + LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
	byte -= LCD_COTROL_BIT_K;
	I2C_WRITE(display->ADDRESS, &byte, 1);
	
	__enable_irq();
}




void LCD_PRINT(struct LCD *display, char data[], unsigned long size) {
	unsigned long i;
	char byte;
	
	__disable_irq();
	
	for(i = 0; i < size; i++) {
		byte = (display->BACKLIGHT) ? LCD_COTROL_BIT_BACKLIGHT : 0;
		byte += ( data[i] & ~HALF_CHAR ) + LCD_COTROL_BIT_RS + LCD_COTROL_BIT_K;
		I2C_WRITE(display->ADDRESS, &byte, 1);
		byte -= LCD_COTROL_BIT_K;
		I2C_WRITE(display->ADDRESS, &byte, 1);
		
		byte = (display->BACKLIGHT) ? LCD_COTROL_BIT_BACKLIGHT : 0;
		byte += (data[i] << 4) + LCD_COTROL_BIT_RS + LCD_COTROL_BIT_K;
		I2C_WRITE(display->ADDRESS, &byte, 1);
		byte -= LCD_COTROL_BIT_K;
		I2C_WRITE(display->ADDRESS, &byte, 1);
	}
	
	__enable_irq();
}
/*
HD44780U (LCD-II)
Reference manual https://www.sparkfun.com/datasheets/LCD/HD44780.pdf
*/
#ifndef LCD_HEADER_FILE
#define LCD_HEADER_FILE

#include "I2C.h"

/*
I/D		= 1:    Increment
I/D		= 0:    Decrement
S		= 1:    Accompanies display shift
S/C		= 1:    Display shift
S/C		= 0:    Cursor move
R/L		= 1:    Shift to the right
R/L		= 0:    Shift to the left
DL		= 1:    8 bits, DL = 0:  4 bits
N		= 1:    2 lines, N = 0:  1 line
F		= 1:    5 × 10 dots, F = 0:  5 × 8 dots
BF		= 1:    Internally operating
BF		= 0:    Instructions acceptable
*/

#define LCD_COTROL_BIT_RS			((char)0x1)
#define LCD_COTROL_BIT_R_W			((char)0x2)
#define LCD_COTROL_BIT_K 			((char)0x4)
#define LCD_COTROL_BIT_BACKLIGHT	((char)0x8)


#define LCD_FUNCTION_SET			((char)0x20)
#define LCD_DISPLAY_ON				((char)0x08)
#define LCD_ENTRY_MODE_SET			((char)0x04)
	
#define LCD_CLEAR_DISPLAY			((char)0x01)
#define LCD_HOME_DISPLAY			((char)0x02)

#define LCD_FUNCTION_SET_DL			((char)0x16)
#define LCD_FUNCTION_SET_N			((char)0x08)
#define LCD_FUNCTION_SET_F			((char)0x04)
	
#define LCD_DISPLAY_ON_D			((char)0x04)				//Sets entire display (D) on/off
#define LCD_DISPLAY_ON_C			((char)0x02)				//cursor on/off (C)
#define LCD_DISPLAY_ON_B			((char)0x01)				//andblinking of cursor positioncharacter (B)

#define LCD_ENTRY_MODE_SET_I_D		((char)0x02)
#define LCD_ENTRY_MODE_SET_S		((char)0x01)

#define LCD_Set_DDRAM_address		((char)0x80)
#define LCD_DDRAM_SECOND_LINE		((char)0x40)

#define HALF_CHAR					((char)0x0f)


struct LCD {
	char ADDRESS;
	char BACKLIGHT;
	char FUNC_SET;
	char ENT_MOD_SET;
	char D_ON_OFF;
};





void LCD_MODE(struct LCD *display);
void LCD_FUNC_SET(struct LCD *display);

void LCD_ON(struct LCD *display);
void LCD_ENTRY_MODE(struct LCD *display);

void LCD_HOME(struct LCD *display);
void LCD_CLEAR(struct LCD *display);

void LCD_BACKLIGHT_ON(struct LCD *display);
void LCD_BACKLIGHT_OFF(struct LCD *display);

void LCD_Set_DDRAM(struct LCD *display, char address);

void display_write(struct LCD *display, char control, char data);
void LCD_PRINT(struct LCD *display, char data[], unsigned long size);




void sleep(unsigned long sl);



#endif


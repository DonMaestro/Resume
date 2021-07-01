#ifndef I2C_HEADER_FILE
#define I2C_HEADER_FILE

#include "stm32f4xx.h"

void I2C_INIT (void);
void I2C_WRITE (char address, char *data, unsigned long size);

#endif


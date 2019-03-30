#include <stdint.h>
#include "saxon.h"

#define UART_BASE ((volatile uint32_t*)(0xF0010000))

void delay (uint32_t n) {
    uint32_t i, j;

    for(i = 0; i <= n; i++)
    {
        for(j = 0; j <= 120000; j++);
    }
}

void putchar(char c){
    while((UART_BASE[1] & 0xFFFF0000) == 0);
    UART_BASE[0] = c;
}

void main() {
    GPIO_A->OUTPUT_ENABLE = 0x000000FF;
    GPIO_A->OUTPUT = 0x00000000;
    uint32_t counter = 0;

    while(1){
        GPIO_A->OUTPUT = 0x00000000;
        putchar('0');
        delay(4);
        GPIO_A->OUTPUT = 0x000000FF;
        delay(4);
        putchar('1');
    }
}


/* huw-test.c */

#include <stdio.h>
#include <stdlib.h>

unsigned int adcISRStack[3] = {
   ((unsigned int)0xa5a5a5a5),
   ((unsigned int)0xa5a5a5a5),
   ((unsigned int)0x00000000)
};

/*
 * This prints "i = (value) here.\n" 8 times and sets i to 8:
 */
void ADCStats() {
   int i = 0;
   unsigned char *p;
   p=(unsigned char *)&adcISRStack[0];
   printf("0th byte of 0th cell of adcISRStack = %x\n", *p);
   while (*p++ == (unsigned char)0xa5) { /* comparing ONE byte!!!   */
      printf("i = %u here.\n", ++i);     /* announce each new i     */
   }
   printf("Final value of i = %u\n", i);
   printf("ISR stack high water = %u\n", i/sizeof(unsigned int));
}

void main (void) {
   ADCStats();
}

#include <stdio.h>

int main(void)
{
   int a, b,max, min;

   printf("첫번째 정수를 입력하세요: \n");
   scanf("%d", &a);
   printf("두번째 정수를 입력하세요: \n");
   scanf("%d", &b);
   
   max = (a > b) ? a : b;
   min = (a < b) ? a : b;

   printf("두 수의 합: %d \n", max + min);
   printf("두 수의 차: %d \n", max - min);

   return 0;
}

#include <stdio.h>

int main(void)
{
   int a, b,max, min;

   printf("ù��° ������ �Է��ϼ���: \n");
   scanf("%d", &a);
   printf("�ι�° ������ �Է��ϼ���: \n");
   scanf("%d", &b);
   
   max = (a > b) ? a : b;
   min = (a < b) ? a : b;

   printf("�� ���� ��: %d \n", max + min);
   printf("�� ���� ��: %d \n", max - min);

   return 0;
}

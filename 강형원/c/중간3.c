#include <stdio.h>

int main(void)
{
   int hour, min, sec;
   int total_sec = 0;
   
   printf("�ð��� ���ʷ� �Է��ϼ���(��,��,��) : ");
   scanf("%d %d %d", &hour, &min, &sec);
   
   total_sec = hour*60*60 + min*60 + sec;
   
   printf("%d�ð� %d�� %d�ʴ� �� %d���Դϴ�.\n", hour, min, sec, total_sec);
   
   return 0; 
}

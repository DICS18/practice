#include <stdio.h>

int main(void)
{
   int hour, min, sec;
   int total_sec = 0;
   
   printf("시간을 차례로 입력하세요(시,분,초) : ");
   scanf("%d %d %d", &hour, &min, &sec);
   
   total_sec = hour*60*60 + min*60 + sec;
   
   printf("%d시간 %d분 %d초는 총 %d초입니다.\n", hour, min, sec, total_sec);
   
   return 0; 
}

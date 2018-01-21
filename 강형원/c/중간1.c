#include <stdio.h>

int IsLeapYear(int year);
int GetDaysOfMonth(int year, int month);

int main(void)
{ 
   int year, mon, days;
   
   printf("강형원씨 연도와 월을 입력하세요 : ");
   scanf("%d %d", &year, &mon);
   
   days = GetDaysOfMonth(year, mon);
   printf("강형원씨의 %d년 %d월은 %d일입니다.\n", year, mon, days);
   
   
   return 0;
   
}

int IsLeapYear(int year)
{
   if((year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0))    
      return 29;
   else 
      return 28;              
}
int GetDaysOfMonth(int year, int month)
{
   switch(month)
   {   case 4 :
         return 30;
      case 6 : 
         return 30;
      case 9 :
         return 30;
      case 11 :
         return 30;
      case 2 :
         return IsLeapYear(year);
      default :
         return 31;
   }
}

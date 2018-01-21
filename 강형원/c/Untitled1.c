#include <stdio.h>

int main(void)
{
	
	char x;
	int y;
	float z;
	
	printf("문자를 입력하세요 : ");
	scanf("%c",&x);
	
	printf("정수를 입력하세요 : ");
	scanf("%d",&y);
	
	printf("실수를 입력하세요 : ");
	scanf("%f",&z);
	
	printf("문자 = %c, 정수 = %d, 실수 = %f",x,y,z);

    return 0;
}

# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial03보충.R

##  벡터와 대입 연산자

# 벡터 만들기
x <- c(80, 85, 70)
x

c(80, 85, 70) -> x
x

# 벡터 원소가 하나일 때
x <- c(80)
x

x <- 80
x

# 산술 연산자
x <- 5+2
x

x <- 5/3
x

x <- 5^2
x

x <- 5%%3
x

x <- 5%/%3
x

벡터와 사칙연산
x <- c(1, 2, 3, 4) # 4개 원소
y <- c(2, 3, 4, 5) # 4개 원소
z <- c(1, 2)       # 2개 원소

w <- x+y
w

w <- x+5
w

w <- y/2
w

w <- x+z
w

w <- x/z
w

w <- z/x
w

# 서로 다른 데이터 유형과 연산
x <- c(1, 2, 3)
x

y <- c("A", "B", "c")
y

y <- c("A", 1, 2)
y

z <- y + 1

# 비교 연산자
x <- 5 ＜ 3
x 

y <- c(10, 20, 30)
z <- y <= 10
z

# 논리 연산자
x <- TRUE
y <- FALSE
x | y

x & y

x <- 3
!x

isTRUE(y)

z <- c(TRUE, FALSE, FALSE)
z | y

# 연속적인 값들의 벡터 만들기
x <- seq(1, 10)
x

x <- 1:10
x

x <- seq(10, 1)
x

y <- 10:1
y

x <- seq(1, 10, by=3)
x

y <- seq(1, 10, length.out=5)
y

# 반복적인 값들의 벡터 만들기
x <- c(1, 2, 3)
rep(x, times=2)

rep(x, each=2)

# 벡터의 원소 보기 및 수정
x <- c(1, 2, 3, 4, 5)
x[2]

x[c(1, 3, 5)]

x[-c(2, 4)]

x[x>2]

x[x>=2 & x<=4]

x[2] <- 20
x

x[c(3, 4)] <- 15
x

x[x<=15] <- 10
x

# 벡터에 대한 함수의 사용
x <- seq(1:10)
sum(x)

mean(x)

var(x)
sqrt(var(x))==sd(x)
sqrt(var(x))
sd(x)

sqrt(x)

length(x)

x <- c(1, 2, -3)
abs(x)

# NULL, NA(not available), NaN(not a number)
x <- NULL
is.null(x)

y <- c(1, 2, 3, NA, 5)
y
y+1
z <- 10/0
z

w <- 0/0
w

## 배열 

# 1차원 배열
x <- array(1:3, dim=c(3))
x

# 2차원 배열 만들기 
x <- array(1:6, dim=c(2, 3))
x

x <- array(c(2, 4, 6, 8, 10, 12), dim=c(2, 3))
x

# 2차원 배열의 요소 값 보기와 수정
x[1, 3]

x[, 3]

x[,-3]

x[1, 2] <- 20
x

# 2차원 배열의 행과 열 이름 추가
names <- list(c("1행", "2행"), c("1열", "2열", "3열"))

x <- array(c(2, 4, 6, 8, 10, 12), dim=c(2, 3), dimnames=names)
x

x["1행", ]

# 3차원 배열
x <- array(1:24, dim=c(2, 3, 4))
x

## 행렬

# 행렬 만들기
x <- matrix(1:6, nrow=2)
x

x <- matrix(1:6, nrow=2, byrow=TRUE)
x

x[1, 3]

# 행과 열 이름 주기
names <- list(c("1행", "2행"), c("1열", "2열", "3열"))

matrix(1:6, nrow=2, byrow=TRUE, dimnames=names)

# 벡터 결합에 의한 행렬 만들기
v1 <- c(1, 2, 3, 4)
v2 <- c(5, 6, 7, 8)
v3 <- c(9, 10, 11, 12)
x <- cbind(v1, v2, v3)
x

# 행과 열 이름 주기
rownames(x) <- c("1행", "2행", "3행", "4행")
x

colnames(x) <- c("1열", "2열", "3열")
x

rbind(v1, v2, v3)

## 리스트

# 리스트 만들기
x <- list("홍길동", "2016001", 20, c("IT융합", "데이터 관리"))
x
str(x)
class(x)
mode(x)
y <- list("성명"="홍길동", "학번"="2016001", "나이"=20, "수강과목"=c("IT융합",
"데이터 관리"))
y

# 동일한 결과
y <- list(성명="홍길동", 학번="2016001", 나이=20, 수강과목=c("IT융합", "데이터 관
리"))
y
# 객체 값의 출력
x["성명"]

x[["성명"]]

x$성명

## 데이터 프레임

# 두 명의 고객 정보에 대한 데이터 프레임 만들기
x <- data.frame(성명=c("홍길동", "손오공"), 나이=c(20, 30), 주소=c("서울", "부산"))
x

# 동일한 결과
x <- data.frame("성명"=c("홍길동", "손오공"), "나이"=c(20, 30), "주소"=c("서울", "부산"))

# 열과 행 단위 추가
x <- cbind(x, 학과=c("e-비즈", "경영"))
x

x <- rbind(x, data.frame(성명="장발장", 나이=40, 주소="파리", 학과="행정"))
x

# 요소 값 보기
x[3, 2]

x[3,]

x[, 2]

x[-2,]

x["성명"]

x$성명

x[["성명"]]

x[[1]]

x[[1]][2]

x[1, 2] <- 21
x

x[1, "나이"] <- 22
x

## 데이터 파일 읽기

# 데이터 세트 목록 보기
library(help=datasets)

# data() 함수로도 데이터 세트 목록 조회가 가능함
data()

# 데이터 세트의 데이터 보기
data(quakes)

quakes

head(quakes, n=10)

tail(quakes, n=6)

# 데이터 세트 구조 보기
names(quakes)

str(quakes)

dim(quakes)

# 데이터 세트 요약 보기
summary(quakes)

summary(quakes$mag)

# 데이터 세트 저장하고 읽기
write.table(quakes, "c:/Work/quakes.txt", sep=",")

x <- read.csv("c:/Work/quakes.txt", header=T)
x

x <- read.csv(file.choose(), header=T)
x

# 웹사이트의 데이터 파일 읽기
url <- "https://vincentarelbundock.github.io/Rdatasets/csv/datasets/
Titanic.csv"
x <- read.csv(url)
x

## 함수 만들기

# 인치를 센티미터로 변환하는 함수의 정의와 호출
inch_to_cm <- function(inch) {
    cm <- inch * 2.54
    return(cm)
}

inch_to_cm(3)

celsuis_to_fahrenheit <- function(celsuis) {
  fahrenheit <- celsuis * 1.8 +32
  return(fahrenheit)
  }

celsuis_to_fahrenheit(25)

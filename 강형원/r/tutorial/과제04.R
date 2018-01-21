# 산업경영공학과 R 특강
#
#2017 Summer
#
# 김연수 교수 youskim@paran.com / 032-835-8487
#
# Tutorial04보충.R

## (1) 차트로 영업 실적 비교하기

x <- c(9, 15, 20, 6)
label <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
pie(x, labels=label, main="부서별 영업 실적")

# 단순 바 차트
height <- c(9, 15, 20, 6)
name <- c("영업 1팀", "영업 2팀", "영업 3팀", "영업 4팀")
barplot(height, names.arg = name, main="부서별 영업 실적", col=rainbow(length(height)), xlab="부서",
        ylab="영업 실적(억 원)")

## (2) 애니메이션으로 카운트 다운

# 문자 출력: 카운트 다운 
install.packages("animation")
library(animation)

ani.options(interval = 1)

for (i in 10:0) {
  plot.new()
  rect(0, 0, 1, 1, col="yellow")
  text(0.5, 0.5, i, cex=5, col=rgb(.2, .2, .2, .7))
  ani.pause()
}

## (3) 단양팔경을 구글 맵 위에

# 단양팔경 위치 출력

install.packages("ggplot2")
install.packages("RgoogleMaps")
install.packages("ggmap")
library(ggplot2)
library(RgoogleMaps)
library(ggmap)

names <- c("1.도담삼봉/석문", "2.구담/옥순봉", "3.사인암", "4.하선암", "5.중선암", "6.상선암")
addr <- c("충청북도 단양군 매포읍 삼봉로 644-33",
          "충청북도 단양군 단성면 월악로 3827",
          "충청북도 단양군 대강면 사인암2길 42",
          "충청북도 단양군 단성면 선암계곡로 1337",
          "충청북도 단양군 단성면 선암계곡로 868-2",
          "충청북도 단양군 단성면 선암계곡로 790")

gc <- geocode(enc2utf8((addr)))
gc

df <- data.frame(name=names, lon=gc$lon, lat=gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat))
cen

map <- get_googlemap(center=cen, maptype="roadmap", zoom=11, marker=gc)
ggmap(map, fullpage = TRUE)

## (4) 워드 클라우드로 연설문 키워드 분석

# 키워드와 빈도수에 대한 워드 클라우드 출력
install.packages("wordcloud")
install.packages("RColorBrewer")
library(wordcloud)
library(RColorBrewer)
pal2 <- brewer.pal(8,"Dark2")
x <- c("국민", "신한국사회", "민족")
y <- c(5, 4, 3)
wordcloud(x, y, colors=pal2)

## (5) 동전 던지기 시뮬레이션

# 동전을 5,000번 던질 때 횟에 따라 앞면이 나오는 확률의 변화
iteration <- 5000
plot(0, 0, xlab="동전을 던진 횟수", ylab="앞면이 나오는 비율", xlim=c(0, iteration), ylim=c(0, 1))

abline(a=0.5, b=0, col="red")

sum <- 0

for(x in 1:iteration) {
  y <- sample(c("앞면", "뒷면"), 1, replace=T)
  if ( y == "앞면")
    sum = sum + 1
  prob <- sum / x
  points(x, prob)
}

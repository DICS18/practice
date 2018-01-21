## 준비

setwd("C:/Work")
getwd()

install.packages("ggmap")
install.packages("raster")
install.packages('maptools')
install.packages('rgeos') 
install.packages('rgdal') 
install.packages('viridis')
install.packages('scatterpie')
library(ggmap)
library(ggplot2)
library(raster)
library(maptools)
library(rgeos)
library(rgdal)
library(viridis)
library(scatterpie)

map <- get_map(location='south korea', zoom=7, maptype='roadmap', color = "bw")

a <- read.csv("C:/Users/hwk07/Downloads/상가업소정보+(2017년+3월)/상가업소_201703_01(e).csv", header=T, as.is=T)
b <- read.csv("C:/Users/hwk07/Downloads/상가업소정보+(2017년+3월)/상가업소_201703_02(e).csv", header=T, as.is=T)
c <- read.csv("C:/Users/hwk07/Downloads/상가업소정보+(2017년+3월)/상가업소_201703_03(e).csv", header=T, as.is=T)
d <- read.csv("C:/Users/hwk07/Downloads/상가업소정보+(2017년+3월)/상가업소_201703_04(e).csv", header=T, as.is=T)

e <- merge(x=a,y=b,all=T)
f <- merge(x=e,y=c,all=T)
g <- merge(x=f,y=d,all=T)

## 전국 시도별 상가업소 분포도

korea_sd <- shapefile('2013_si_do.shp')
korea_sd <- fortify(korea_sd, region='code')

g_sd <- data.frame(table(g$시도코드))
colnames(g_sd) <- c("id","상가업소수")
g_kor_sd <- merge(korea_sd, g_sd, by='id')

kormap_sd <- ggmap(map) + geom_polygon(data=g_kor_sd, aes(x=long, y=lat, group=group, fill=상가업소수), alpha=.75) 
+ scale_fill_viridis(direction=-1) + theme_void()

kormap_sd <- kormap_sd + geom_polygon(data=korea_sd, aes(x=long, y= lat, group=group), fill=NA , color='black')

kormap_sd

## 전국 시도별 상가업소 업종 대분류 파이 차트

g_fd <- subset(g, 상권업종대분류명 == "음식")
g_sdfd <- data.frame(table(g_fd$시도코드))
colnames(g_sdfd) <- c("id","음식점_업소수")

g_md <- subset(g, 상권업종대분류명 == "의료")
g_sdmd <- data.frame(table(g_md$시도코드))
colnames(g_sdmd) <- c("id","의료_업소수")

g_st <- subset(g, 상권업종대분류명 == "학문/교육")
g_sdst <- data.frame(table(g_st$시도코드))
colnames(g_sdst) <- c("id","교육_업소수")

g_sv <- subset(g, 상권업종대분류명 == "생활서비스")
g_sdsv <- data.frame(table(g_sv$시도코드))
colnames(g_sdsv) <- c("id","생활서비스_업소수")

g_rt <- subset(g, 상권업종대분류명 == "소매")
g_sdrt <- data.frame(table(g_rt$시도코드))
colnames(g_sdrt) <- c("id","소매_업소수")

g_re <- subset(g, 상권업종대분류명 == "부동산")
g_sdre <- data.frame(table(g_re$시도코드))
colnames(g_sdre) <- c("id","부동산_업소수")

bp_sd <- merge(g_sdfd, g_sdmd, by = "id")
bp_sd <- merge(bp_sd, g_sdst, by = "id")
bp_sd <- merge(bp_sd, g_sdsv, by = "id")
bp_sd <- merge(bp_sd, g_sdrt, by = "id")
bp_sd <- merge(bp_sd, g_sdre, by = "id")

korea_sd_mean_long <- aggregate(korea_sd$long ~ korea_sd$id, FUN = mean) 
colnames(korea_sd_mean_long) <- c("id","long")
korea_sd_mean_lat <- aggregate(korea_sd$lat ~ korea_sd$id, FUN = mean)
colnames(korea_sd_mean_lat) <- c("id","lat")

korea_sd_mean <- merge(korea_sd_mean_lat, korea_sd_mean_long, by = "id")

bp_sd_id <- merge(bp_sd, korea_sd_mean, by = "id")

ggmap(map) + geom_scatterpie(aes(x=long, y=lat, r=0.15),
                             data=bp_sd_id, 
                             cols=c("음식점_업소수", "의료_업소수", "교육_업소수", "생활서비스_업소수", "소매_업소수", "부동산_업소수"))
+ theme_void()

## 전국 시군구별 상가업소 분포도

korea_sig <- shapefile('TL_SCCO_SIG.shp')
korea_sig <- fortify(korea_sig, region='SIG_CD')
g_sig <- data.frame(table(g$시군구코드))
colnames(g_sig) <- c("id","상가업소수")
g_kor_sig <- merge(korea_sig, g_sig, by='id')

kormap_sig <- ggmap(map) + geom_polygon(data=g_kor_sig, aes(x=long, y=lat, group=group, fill=상가업소수), alpha=.75)
+ scale_fill_viridis(direction=-1) + theme_void()
kormap_sig <- kormap_sig + geom_polygon(data=korea_sig, aes(x=long, y= lat, group=group), fill=NA , color='black')
kormap_sig


## 인천 시군구별 상가업소 분포도

inc <- korea_sig[korea_sig$id <= 28720 & korea_sig$id >=28110, ]
g_inc_sig <- merge(inc, g_sig, by='id')
myLocation <- c(lat=37.46, lon=126.44)
incmap <- get_map(location=myLocation, zoom=10, maptype = 'roadmap', color = "bw")
incmap_sig <- ggmap(incmap) + geom_polygon(data=g_inc_sig, aes(x=long, y=lat, group=group, fill=상가업소수), alpha = .75) 
+ scale_fill_viridis(direction=-1) + theme_void()
incmap_sig <- incmap_sig + geom_polygon(data=inc, aes(x=long, y= lat, group=group), fill=NA , color='black')
incmap_sig

## 인천 시군구별 상가업소 업종 대분류 파이 차트

g_sigfd <- data.frame(table(g_fd$시군구코드))
colnames(g_sigfd) <- c("id","음식점_업소수")

g_sigmd <- data.frame(table(g_md$시군구코드))
colnames(g_sigmd) <- c("id","의료_업소수")

g_sigst <- data.frame(table(g_st$시군구코드))
colnames(g_sigst) <- c("id","교육_업소수")

g_sigsv <- data.frame(table(g_sv$시군구코드))
colnames(g_sigsv) <- c("id","생활서비스_업소수")

g_sigrt <- data.frame(table(g_rt$시군구코드))
colnames(g_sigrt) <- c("id","소매_업소수")

g_sigre <- data.frame(table(g_re$시군구코드))
colnames(g_sigre) <- c("id","부동산_업소수")

bp_sig <- merge(g_sigfd, g_sigmd, by = "id")
bp_sig <- merge(bp_sig, g_sigst, by = "id")
bp_sig <- merge(bp_sig, g_sigsv, by = "id")
bp_sig <- merge(bp_sig, g_sigrt, by = "id")
bp_sig <- merge(bp_sig, g_sigre, by = "id")

korea_sig_mean_long <- aggregate(korea_sig$long ~ korea_sig$id, FUN = mean) 
colnames(korea_sig_mean_long) <- c("id","long")
korea_sig_mean_lat <- aggregate(korea_sig$lat ~ korea_sig$id, FUN = mean)
colnames(korea_sig_mean_lat) <- c("id","lat")

korea_sig_mean <- merge(korea_sig_mean_lat, korea_sig_mean_long, by = "id")

bp_sig_id <- merge(bp_sig, korea_sig_mean, by = "id")
bp_sig_id$id <- as.character(bp_sig_id$id)

bp_sig_id <- bp_sig_id[bp_sig_id$id <= 28720 & bp_sig_id$id >=28110, ]
ggmap(incmap) + geom_scatterpie(aes(x=long, y=lat, r=0.014), data=bp_sig_id,
                                cols=c("음식점_업소수", "의료_업소수", "교육_업소수", "생활서비스_업소수", "소매_업소수", "부동산_업소수")) 
+ theme_void()

## 인천 연수구 음식점 밀집도

ys <- subset(g, 시군구명 == "연수구")
ys_fd <- subset(ys, 상권업종대분류명 == "음식")
yslocation = c(lat=37.385, lon=126.65) 
map_ys <- get_map(location=yslocation, zoom=14, maptype = 'roadmap') 
ggmap(map_ys) + geom_point(data=ys_fd, aes(x=경도,y=위도), size= 2) + theme_void()
ggmap(map_ys) + stat_density_2d(data = ys_fd, aes(x=경도, y=위도)) + theme_void()

## 인천 연수구 송도 치킨집 위치

ys_ck <- subset(ys, 표준산업분류명 == "치킨 전문점")
ys_ck <- ys_ck[ys_ck$위도 >= 37.365 & ys_ck$위도 <= 37.405 & ys_ck$경도 >= 126.625 & ys_ck$경도 <= 126.665, ]
ggmap(map_ys) + geom_point(data=ys_ck, aes(x=경도,y=위도, color = 상호명), size= 3.5) + theme_void()




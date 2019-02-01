##### 데이터 불러오기 #####
### 데이터 : 2013. 11. 1. ~ 2018. 11. 1. 개봉 영화

setwd("c:/Users/박보정/Desktop/data")
movie <- read.csv("movie.csv")
movie2 <- movie %>% filter(audience>1000)
summary(movie)

####### 1.EDA 및 데이터 전처리 #######
library(tidyverse)
library(stringr)

##### 1.1.audience #####

ggplot(movie, aes(audience)) + geom_histogram()
ggplot(movie, aes(audience)) + geom_histogram(bins=100) 
quantile(movie$audience, seq(0, 1, 0.1)) # 30% 이상이 1
# audience = 1은 관객 상영 목적이 아니라고 판단

movie %>% filter(audience < 100) %>%
  ggplot(aes(audience)) + geom_histogram(bins=100)

movie %>% filter(audience < 100 & audience > 1) %>%
  ggplot(aes(audience)) + geom_histogram(bins=100)

movie %>% filter(audience == 1) %>%
  ggplot(aes(genre)) + geom_bar()

movie %>% filter(audience > 1) %>%
  ggplot(aes(genre)) + geom_bar()
# audience = 1 인 경우의 genre 분포와, 아닌 경우를 비교했을 때, 
# 성인물의 비율이 컸다. 영화관 상영 목적이 아닌, VOD 판매수익을 위한 영화라고 추측된다.

### => 개봉 영화의 경우 대부분 관객수가 만 명 이하이며, 
# 만 명을 넘는 경우는 전체의 약 20%에 그쳤다.
# 대부분 만 명 이하의 관객수를 갖고,
# 몇몇 흥행작이 대부분의 관객수를 점유하는 표준편차가 큰 분포를 따른다. 

### 예측할 영화의 관객수가 1000명은 넘을 것이라 가정하고,
# audience > 1000인 영화를 분석 대상으로 선정

movie2 <- movie %>% filter(audience>1000)

quantile(movie2$audience, seq(0, 1, 0.1))
# 관객 수 천 명 이상의 경우에도,
# 대부분의 영화가 적은 관객수를 가지고, 몇 몇 흥행작이 대부분의 관객수를 점유

##### 1.2.year #####
movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  group_by(year) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(year, aud_mean)) +
  geom_bar(stat="identity")
# 2015, 2016, 2017년의 평균 관객수가 높다.

movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  filter(audience>5000000) %>%
  group_by(year) %>%
  summarise(count = n())
# 연간 평균 관객수는 5백만 관객수를 돌파한 영화 수와 비례
### => 평균 관객수는 몇몇 outliyer들의 영향을 크게 받는다.

movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  filter(audience<5000000) %>%
  group_by(year) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(year, aud_mean)) +
  geom_bar(stat="identity")

### year 분산분석 

movie.date <- movie2 %>% separate(date, c("year", "month", "day"), sep="-")

lm.year <- lm(audience ~ year, data=movie.date)
anova(lm.year)
# year의 Pr=0.9048로 year에 따른 차이가 없다고 판단한다.

##### 1.3.month #####

movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  group_by(month) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(month, aud_mean)) +
  geom_bar(stat="identity")

movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  filter(audience>5000000) %>%
  group_by(month) %>%
  summarise(count = n())
# 월별 평균 관객수가 5백만 관객수를 돌파한 영화 수와 비례
# => 관객수 5백만 이상의 흥행작이 7, 8, 12월에 많았다.

# 관객수 5백만 이상의 outliyer를 제거하고 다시 분석

movie2 %>% separate(date, c("year", "month", "day"), sep="-") %>%
  filter(audience<5000000) %>%
  group_by(month) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(month, aud_mean)) +
  geom_bar(stat="identity")
### => 평균 관객수가 7, 12월에 가장 높고, 그 때를 중심으로 점차 감소하다 증가한다.
# => 학교 방학이 영화 관객수에 영향을 줄 것이라고 추측된다.



##### 1.4.genre #####

movie2 %>% ggplot(aes(genre)) + geom_bar()
# 드라마, 애니메이션, 액션 영화의 제작편수가 많고, 뮤지컬, 전쟁, 사극 영화는 적음

### genre별 audeince

mean(movie2$audience) # 421440.4

movie2 %>% group_by(genre) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(genre, aud_mean)) + geom_bar(stat="identity") + 
  geom_hline(aes(yintercept=421440.4), color="red")

movie2 %>% filter(genre == "사극") %>% select(title, audience)
# 사극의 개수가 23개로 굉장히 개수가 적은데 비해,
# 명량, 사도, 덕혜옹주, 안시성 등 절반 이상이 관객수 백만을 넘었다.
# 사극의 경우 제작비가 많이 들기 때문에 제작 편수가 적고, 흥행률이 높은 것으로 보인다.

movie2 %>% filter(genre != "사극") %>% summarise(mean = mean(audience)) # 398995.4

movie2 %>% filter(genre != "사극") %>% group_by(genre) %>% 
  summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(genre, aud_mean)) + geom_bar(stat="identity") + 
  geom_hline(aes(yintercept=398995.4), color="red")
# 액션, 범죄, 어드벤처, 판타지, SF와 같은 제작비가 큰 영화가 높은 관객수를 가지는 것으로 보인다.

## => 제작비가 영화의 관객수에 영향을 미칠 것이라 예상된다.
  
### 장르의 범주가 너무 많으면 분석에 악영향을 미치기 때문에
### 사극, 액션, 범죄, 어드벤처, 판타지, Sf, 드라마, 애니메이션과 other로 구분

movie2$genre <- as.character(movie2$genre)

for (i in 1:nrow(movie2)) {
if(!(movie2[i, "genre"] %in% c("사극","액션","범죄","어드벤처","판타지","sf","드라마","애니메이션"))){
  movie2[i, "genre"] <- "other"
}
}

table(movie2$genre)

movie2 %>% group_by(genre) %>% summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(genre, aud_mean)) + geom_bar(stat="identity") + 
  geom_hline(aes(yintercept=421440.4), color="red")

## audience에 로그를 취해 분포 비교
movie2 %>%
  ggplot(aes(genre, log(audience), fill=genre)) +
  geom_violin()
# 액션, 범죄는 비슷한 분포를 따른다.
# 드라마는 other과 분포가 비슷하다.
# 사극이 흥행률이 압도적으로 높은 것으로 보인다.



##### 1.5.country #####
movie2 %>% group_by(country) %>%
  summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(country, aud_mean)) +
  geom_bar(stat="identity")

table(movie2$country)

### country 중 미국, 한국을 제외한 다른 변수는 other로 통합

movie2$country <- as.character(movie2$country)

for(i in 1:nrow(movie2)){if(movie2[i, "country"] == "한국"){
}else if(movie2[i, "country"] == "미국"){
}else{movie2[i, "country"] <- "other"}
}

movie2$country <- as.factor(movie2$country)

### country

movie2 %>% group_by(country) %>%
  summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(country, aud_mean)) +
  geom_bar(stat="identity")
# 한국영화가 미국영화보다 평균 관객수가 많으며, 그 외 국가는 관객수가 적다.



##### 1.6.screen #####
movie2 %>% ggplot(aes(screen, audience)) +
  geom_point() +
  geom_smooth()
# => screen 수가 많을수록 audience 커진다.
# screen수가 많아져서 audience가 커지는 관계,
# audience가 커서 보다 많은 screen에서 상영하는 관계
# 양방향적인 관계로 추측할 수 있다.



##### 1.7.rating #####

table(movie2$rating)

movie2 %>% group_by(rating) %>%
  summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(rating, aud_mean)) +
  geom_bar(stat="identity")

table(movie2$rating)

### 상영등급이 두개인 경우, 낮은 등급에 포함

movie2$title <- as.character(movie2$title)
movie2$rating <- as.character(movie2$rating)

movie2[movie2$rating=="12세이상관람가,15세이상관람가",]
movie2[1448, "rating"] <- "12세이상관람가"

movie2[movie2$rating=="15세이상관람가,전체관람가",]
movie2[2360, "rating"] <- "전체관람가"

movie2[movie2$rating=="청소년관람불가,15세이상관람가",]
movie2[291, "rating"] <- "15세이상관람가"

movie2 %>% group_by(rating) %>%
  summarise(aud_mean = mean(audience)) %>%
  ggplot(aes(rating, aud_mean)) +
  geom_bar(stat="identity")
# 12세이상관람가, 15세이상관람가, 청소년관람불가 순으로 평균 관객수가 높다.

movie2 %>%
  ggplot(aes(rating,audience, fill=rating)) +
  geom_violin()
# 분포 비교가 힘들다 => 로그변환하여 확인

movie2 %>%
  ggplot(aes(rating,log(audience), fill=rating)) +
  geom_violin()
# 12세이상관람가의 영화가 흥행 비율이 높다.
# 청소년관람불가 영화가 관객수가 적은 비율이 높다.

################데이터 전처리(결론나면 지워도됨)##################

setwd("c:/Users/박보정/Desktop/data")
movie <- read.csv("movie.csv")
movie2 <- movie %>% filter(audience>1000)

movie2$genre <- as.character(movie2$genre)
for (i in 1:nrow(movie2)) {
  if(!(movie2[i, "genre"] %in% c("사극","액션","범죄","어드벤처","판타지","sf","드라마","애니메이션"))){
    movie2[i, "genre"] <- "other"}}

movie2$country <- as.character(movie2$country)
for(i in 1:nrow(movie2)){if(movie2[i, "country"] == "한국"){
}else if(movie2[i, "country"] == "미국"){
}else{movie2[i, "country"] <- "other"}}
movie2$country <- as.factor(movie2$country)

movie2$title <- as.character(movie2$title)
movie2$rating <- as.character(movie2$rating)
movie2[1448, "rating"] <- "12세이상관람가"
movie2[2360, "rating"] <- "전체관람가"
movie2[291, "rating"] <- "15세이상관람가"

#################################################

##### 1.8.director-점수 수치화 #####
# 1. 100만명 이상 관객수 영화 개수 더하기
# 2. 감독한 영화들의 관객수 평균 구하기

## 감독이 여러명인 경우도 있어서 생각보다 어렵다..

# 감독이 한 명인 경우
movie2 %>% 
  filter(audience >300000) %>%
  group_by(director) %>%
  summarise(count=n()) %>%
  filter(count>1) 

# 감독이 두 명인 경우
movie2 %>%
  filter(audience > 300000) %>%
  separate(director, c("dir1", "dir2"), sep=",") %>%
  filter(is.na(dir2)==F) %>%
  select(dir1, dir2, audience)
  


##### 1.9.distributor 점수 수치화 #####

##### 1.10. netizen_grade #####

### 네이버 영화 관람객 평점 크롤링

library(rvest)

title <- movie2$title
title2 <- gsub(" ","",title)
netizen_grade = c()


for (i in 1:2526){
  url_base <- "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query="
  url <- paste0(url_base,title2[i])
  
  htxt <- read_html(url)
  table <- html_nodes(htxt,".r_grade")
  r_grade <- html_text(table)
  
  try(
    {grade1 <- strsplit(r_grade,split="   ")
    grade2 <- grade1[[1]][2]
    grade <- substr(grade2,1,4)
    
    netizen_grade[i] <- grade},silent = T)
}

grade_data <- data.frame(title=title, netizen_grade = netizen_grade)

### 평점과 관객수의 연관성

movie3 <- inner_join(movie2, grade_data)



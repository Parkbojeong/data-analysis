################## R 기초 문법 ####################
###### 교재 : 빅데이터 분석도구 R 프로그래밍 ######

################### 2장. 벡터 #####################

##### 2.1 스칼라, 벡터, 배열, 행렬

x <- c(88,5,12,13)
x <- c(x[1,3],168,x[4]) # 벡터에 원소 추가
# 벡터의 크기는 처음 만들어 질 때 정해지므로
# 추가, 삭제하고 싶다면 벡터를 새로 할당해야함.

length(x) # 벡터의 길이 파악

# 배열(array)과 행렬, 리스트는 모두 추가 클래스 속성을 가지고 있는 벡터다. 

##### 2.2 선언

# 벡터의 특정 원소를 언급하고 싶다면,
# 그 내용을 미리 '선언'해야한다.

y[1] <- 1 # Error : object 'y' not found

y <- vector(length=2) # F를 원소로 갖는 길이가 2인 벡터 생성
y[1] <- 1

##### 2.3 재사용(Recycle Rule)

# 두 벡터를 사용하는 연산을 할 때 각각의 길이가 다르다면,
# R은 짧은 쪽을 재사용 또는 반복 사용해 긴 쪽에 맞춘다.

c(1,2,3,4) + c(2,4,8)

x <- matrix(1:6,3,2)
x + c(1,2) # 행렬의 연산에도 recycle rule 적용. 벡터가 byrow=F로 recycle된다.

##### 2.4 일반 벡터산 연산

# +, -, *, / 와 같은 기호는 실제로는 함수이다.
# 이 연산은 원소 단위로 이루어진다.

x <- c(1,2,3)
x * c(5,0,-1)
# 결과 : c(5,0,-3)

### 인덱싱
y <- c(1.2,3.9,0.4,0.12)
y[c(1,1,3)] # 인덱싱
y[-1:-2] # 1부터 2까지의 원소 제외
y[-length(y)] # 마지막 원소 제외

i <- 5
1:i-1 # :연산 먼저 적용 => c(1,2,3,4,5) - 1
1:(i-1) # 괄호 안에 있는 i-1 먼저 적용 => c(1,2,3,4) - 1

### seq() : 수열 생성
seq(from=12,to=30,by=3) # sequance 생성 (디폴트)
seq(from=1.1, to=2, length=10)

### req() : 반복 벡터 생성
rep(1:3,2) # c(1,2,3,1,2,3)
rep(1:3,each=2) # c(1,1,2,2,3,3)

##### 2.5 all()과  any() 사용하기
# all(), any()는 벡터의 원소에 대한 조건문이다.

x <- 1:10
any(x>8) # x[i]>8인 원소가 있는가 => TRUE
all(x>8) # 모든 원소가 x[i]>8인가 => FALSE

##### 2.6 벡터화 연산

# 벡터에 함수를 적용하면 실제로는 내부의 원소에 각각 적용됨을 뜻하는
# '벡터화'한 연산을 사용하면 처리속도를 올릴 수 있다.
# ex) +, -, /, *, sqrt(), log(), sin(), ==, >, ...

y <- c(12,5,13)
'+'(y,4) # y + 4

##### 2.7 NA와 NULL값

# NA는 존재하나 누락된 값 => 건너뛰고 계산 가능
# NULL은 존재하지 않는 값 => 어떤 형식도 취하지 않는 특별한 객체

v <- NULL
length(v) # v는 어떤 원소도 가지지 않는 빈 벡터 => 길이는 0
u <- NA
length(u) # NA를 원소로 가지는 벡터 => 길이는 1

##### 2.8 필터링

z <- c(5,2,-3,8)
w <- z[z*z > 8] # w = c(5,-3,8)

# 필터링 프로세스
z*z > 8 # STEP 1. ">" 함수를 적용해 논리벡터 생성 => c(TRUE, FALSE, TURE, TURE)
z[c(TRUE, FALSE, TRUE, TRUE)] # STEP 2. 논리값이 TRUE인 값만 필터링

z[z<0] <- 0 # z에서 음수인 원소를 0으로 치환

# subset()을 이용한 필터링
x <- c(6,1:3,NA,12)
x[x>5] # c(6,NA,12)
subset(x,x>5) # c(6,12) => NA값이 제거됨

# which()
which(x>5) # x>5가 TRUE인 인덱스 추출
x[which(x>5)] # subset(x,x>5)와 결과가 같음

##### 2.9 벡터화된 조건문 : ifelse() 함수

# ifelse(b,u,v)
# b는 불리언 벡터, u와 v는 벡터
# => 원소 i에 대해 b[i]가 참이면 u[i], 거짓이면 v[i]로 구성된 벡터
# 벡터화 되어 있어 표준 if-then-else 구조보다 훨씬 빠르다.

##### 2.10 벡터 동일성 테스트

x <- 1:2
y <- c(1,2)
all(x == y) # x와 y의 모든 원소값이 동일하면 TRUE

identical(x,y) # 이 함수는 x,y의 저장 형식까지 동일해야한다.
typeof(x) # x의 타입 : integer
typeof(y) # y의 타입 : double

##### 2.11 벡터 원소의 이름

# 벡터 원소에 이름을 지정할 수 있다.
x <- c(1,2,4)
names(x) <- c("a","b","ab")
x

x["a"] # 이름을 인덱스로도 사용 가능

names(x) <- NULL # 원소의 이름 삭제

##### 2.12 c() 이상의 것

c(5,2,"abc") # 모두 문자형으로 변환
c(5,2,list(a=1,b=4)) # 모두 리스트로 변환
c(5,2,c(1.5,6)) # 형태를 1.5에 맞춤



################### 3장. 행렬과 배열 ######################

# '행렬'은 행의 개수와 열의 개수라는 두 가지 속성을 추가로 갖는 벡터
# '행렬'은 '배열(array)'의 특이한 형태
# 3차원 배열은 행, 열, 층으로 구성되어 있다.

##### 3.1 행렬 만들기

y <- matrix(1:4, nrow=2, ncol=2, byrow=F)
y
# 행렬의 내부 저장소는 열 우선 배열 형식
# => byrow=T 인수를 설정하여 행 우선 배열 방식으로 입력

##### 3.2 일반 행렬 연산

y * y # *는 벡터화 연산이므로 각 원소끼리 곱해줌
y %*% y # 행렬 간 곱
3 * y # 행렬-상수 간 곱 : 3을 2*2행렬로 recycle
y + y # 행렬 간 합

# 행렬 인덱싱
y[,2]
y[,2] <- c(1,2) # 행렬에 새로운 값 할당

### 확장 예제 : 이미지 다루기
library(pixmap)
setwd("C:/Users/박보정/Desktop/미래설계/R grammar")
mtrush1 <- read.pnm("mtrush1.pgm")

str(mtrush1) # class는 각 요소가 $가 아닌 @로 지정된 S4유형이다.

# 루즈벨트 대통령 날리기
plot(mtrush1)
locator()
# x는 133~176 (열)
# y는 38~104 => 92(196-38)~158(196-104) (행)

mtrush2 <- mtrush1
mtrush2@grey[92:158, 133:176] <- 1
plot(mtrush2)

# 행렬 필터링
x <- matrix(c(1:3,2:4), nrow=3)
x[x[,2]>=3,] # x[,2]>=3인 행만 필터링

x[,2]>=3 # c(FALSE, TRUE, TRUE)
x[c(FALSE, TRUE, TRUE),] # 2,3번째 행만 필터링

##### 3.3 행렬의 행과 열에 함수 적용하기

# apply(m, dimcode, f, fargs)
# m : 행렬
# dimcode : 차원수. 1이면 함수를 행에 적용, 2면 열에 적용
# f : 적용할 함수
# fargs : f에 필요한 인수의 집합 (선택사항)

apply(x,2,mean) # 각 열의 mean 함수 적용

# 확장 예제 : 아웃라이어 탐색
findols <- function(x) {
  findol <- function(xrow) {
    mdn <- median(xrow) # x의 중앙값 계산
    devs <- abs(xrow-mdn) # 각 관측치에서 중앙값으로부터의 거리 계산
    return(which.max(devs)) # 중앙값으로부터 가장 멀리 떨어진 관측치의 인덱스
  }
  return(apply(x,1,findol))
}

findols(x)

##### 3.4 행렬에 행과 열 추가 및 제거하기

# 행렬은 고정된 길이와 차원을 가지고 있기 대문에 행이나 열을 추가/삭제할 수 없다.
# 행렬을 '재할당'하여 행,열을 추가/삭제한 것 처럼 보일 수 있다.

one <- rep(1,4)
z <- matrix(c(1:4,rep(c(1,0),each=2),rep(c(1,0),2)), nrow=4)
cbind(one,z) # column으로 결합

one <- rep(1,3)
rbind(one,z) # row로 결합

# cbind(), rbind()도 행렬을 재할당 한 결과이다.

##### 3.5 벡터, 행렬을 더 정확히 구분하기

z <- matrix(1:8, nrow=4)
length(z) # 행렬은 벡터이므로 length 함수 적용 가능 (벡터의 속성)

dim(z)
ncol(z)
nrow(z)
# 행, 열 속성이 추가된 행렬의 속성

attributes(z)
# R의 대부분은 S3 클래스를 포함하는데, 여기서는 구성요소가 $로 표기된다.
# matrix 클래스에서는 dim이라는 하나의 속성을 더 갖는다.

##### 3.6 의도하지 않은 차원 축소 피하기

r <- z[2,]
attributes(r) # NULL => r은 행과 열 속성을 갖지 않음
str(r) # 길이 2인 벡터
# 행렬 z에서 추출한 r이 벡터가 됨

r <- z[2,,drop=FALSE] # drop=F 옵션을 이용해 차원 축소를 피할 수 있음
attributes(r) # dim : 1*2 인 행렬

##### 3.7 행렬의 행과 열에 이름 붙이기

colnames(z) <- c("a","b")
rownames(z) <- c(1:4)
z[,"a"]

##### 3.8 고차원 배열

firsttest <- matrix(c(46,21,50,30,25,48), nrow=3)
secondtest <- matrix(c(46,41,50,43,35,49), nrow=3)
test <- array(data=c(firsttest, secondtest), dim=c(3,2,2))

attributes(test) # dim : 3*2*2(행,열,층)
test[3,2,1]

################### 4장. 리스트 ####################

# 벡터 : 모든 원소가 같은 형식을 띤다.
# 리스트 : 다른 형의 객체끼리도 결합 가능

##### 4.1 리스트 생성하기 

j <- list(name="Joe", salary=55000, union=T)
j$sal # 리스트 구성요소의 이름은 축약해서 사용 가능

##### 4.2 일반 리스트 연산

# 인덱싱
j$salary
j["salary"]
j[[2]] # j의 2번째 구성요소(salary)에 접근해 salary의 데이터 형(벡터)으로 가져옴
j[2] # j의 부분 리스트를 가져옴

# 리스트의 원소 추가/삭제
j$sex <- "Female" # 리스트의 마지막에 sex="Female" 추가
j$sex <- NULL # sex 삭제

# 리스트의 크기 확인하기
length(j) # 리스트는 벡터이므로 length() 사용 가능

### 확장 예제 : 텍스트 일치 확인하기(1)

# 텍스트 파일 안에 있는 단어들의 위치를 리스트로 만들어주는 함수 만들기
findwords <- function(tf) {
  txt <- scan(tf,"") # tf라는 파일을 불러와 ""형태(문자형)로 저장 => 문자형 벡터 생성
  wl <- list() # wl라는 빈 리스트 선언
  for (i in 1:length(txt)) {
    wrd <- txt[i] # wrd는 txt라는 문자형 벡터의 i번째 원소(단어)
    wl[[wrd]] <- c(wl[[wrd]],i) # wrd="that"일 경우, wl라는 리스트에 "that"이라는 구성요소
                                # 생성 후, 위치인 i를 원소로 추가한다.
  }
  return(wl)
}
wl <- findwords("testconcorda.txt")

# 보충설명
a <- list()
a[["z"]] <- c(a[["z"]],2)
# 리스트 a에 "z"라는 구성요소가 없으면 a[["z"]]는 NULL
# c(NULL, 2)가 되므로 a[["z"]]에 2를 넣는다.

a[["z"]] <- c(a[["z"]],3)
# 리스트 a에 "z"라는 구성요소가 이미 존재. a[["z"]] = 2이다.
# 따라서 c(2,3)이 되므로 a[["z"]] = c(2,3)이 된다.


##### 4.3 리스트 구성요소와 값에 접근하기

names(j)
ulj <- unlist(j) # j의 리스트를 풀어 원소로 이루어진 벡터로 만든다.
class(ulj) # 문자형 벡터
unname(ulj) # 이름 제거

##### 4.4 리스트에 함수 적용하기

# lapply(), sapply()
lapply(list(1:3,25:29), median) # 각 구성요소에 median 함수 적용
sapply(list(1:3,25:29), median) # 각 구성요소에 median 적용한 후, 벡터로 반환

### 확장 예제 : 텍스트 일치 확인하기(2)

# 알파벳 순서로 단어를 정렬하는 함수 생성
alphawl <- function(wrdlst) {
  nms <- names(wrdlst) # wrdlst라는 리스트의 이름만 뽑은 벡터
  sn <- sort(nms) # 벡터 nms를 알파벳 순서로 정렬한 벡터
  return(wrdlst[sn]) # wrdlst리스트에서 sn에 저장된 순서대로 리스트를 반환
}

alphawl(wl)

# 단어의 빈도 순서대로 정렬하는 함수 생성
freqwl <- function(wrdlst){
  freqs <- sapply(wrdlst, length) # 리스트의 구성요소에 대해 길이를 계산해 저장한 벡터
  return(wrdlst[order(freqs)]) # order(freqs) : freqs가 작은 순서대로 위치를 저장하는 벡터
}

freqwl(wl)

# order 보충설명
z <- c(2,4,1)
order(z)

# 빈도수 상위 10% bar chart로 표현
snyt <- freqwl(wl)
nwords <- length(snyt) # 전체 단어의 개수
high_freq <- snyt[round(0.9*nwords):nwords]
barplot(sapply(high_freq, length))

##### 4.5 재귀 리스트

# 리스트는 리스트 내에 리스트를 갖는 재귀적 구조가 가능하다.

b <- list(u=5, v=12)
c <- list(w=13)
a <- list(b,c)
a # b라는 리스트와 c라는 리스트를 구성요소로 갖는 리스트

a <- c(b,c,recursive=T)
a # 연결함수 c()에 recursive=T 옵션을 이용하면 편평화(flattening) 된다.
# 즉, 리스트가 아닌 벡터 형태로 저장

################### 5장. 데이터 프레임 ####################

# 데이터 프레임은 동일한 길이의 벡터로 이루어진 리스트를 구성요소로 갖는 리스트
# 리스트의 각 구성요소가 데이터 프레임의 열로 구성된다

##### 5.1 데이터 프레임 생성하기

kids <- c("Jack","Jill")
ages <- c(12,10)
d <- data.frame(kids, ages, stringsAsFactors = FALSE)
# kids, ages를 변수로 갖는 데이터 프레임 생성
# stringAsFactors 는 문자열 벡터를 인수(factor)로 바꾸는 옵션
# stringAsFactors=TRUE가 디폴트

str(d)

##### 5.2 기타 행렬 방식 연산

examsquiz <- read.table("ExamsQuiz.txt", header=TRUE)

# 부분 데이터 프레임 추출하기
examsquiz[examsquiz$MIDTERM >= 3,]

# NA 값을 다루는 추가적인 방법들
x <- c(2,NA,3)
mean(x) # 계산 안됨
mean(x, na.rm=T) # na.rm=T는 NA를 제외 하고 두 값의 평균을 구함

kids <- c("Jack", NA, "Jillian", "John")
states <- c("CA", "MA", "MA", NA)
d4 <- data.frame(kids, states)

complete.cases(d4) # d4의 각 관측치(행)가 결측치를 포함하면 FALSE를 저장하는 벡터
d4[complete.cases(d4),] # 결측치가 없는 관측치만 출력

# rbind(), cbind() 및 관련 함수 사용하기
rbind(d, list("Laura",19)) # 추가되는 행은 보통 데이터 프레임이나 리스트 형태
d$one <- 1
d # 재사용 법칙 적용

apply(examsquiz, 1, max)
apply(examsquiz, 2, max)

##### 5.3 데이터 프레임 결합하기

d1 <- data.frame(kids=c("Jack", "Jill", "Jillian", "John"),
                 states=c("CA","MA","MA","HI"))
d2 <- data.frame(ages=c(10,7,12),kids=c("Jill","Lillian","Jack"))
merge(d1,d2) # 두 데이터 프레임이 같은 이름의 변수를 가지면 자동으로 결합한다

d3 <- data.frame(ages=c(12,10,7),pals=c("Jack","Jill","Lillian"))
merge(d1,d3,by.x="kids",by.y="pals")
# 변수가 같은 정보를 가지고 있으나 이름이 다를 경우 by.x, by.y로 직접 지정한다.

d2a <- rbind(d2, list(15,"Jill"))
merge(d1,d2a)
# 키로 작용하는 변수에 같은 이름의 관측치가 두 개 이상 있을 경우,
# 가능한 조합을 모두 만든다. => 중복된다.

##### 5.4 데이터 프레임에 함수 적용하기

# 데이터 프레임은 리스트이므로 lapply(), sapply() 모두 적용 가능하다.

lapply(d1, sort) # d1의 각 column에 sort 함수를 적용해 리스트로 출력한다.
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
################### 7장. R 프로그래밍 구조 ####################

##### 7.1 조건문

### for, while, repeat
for(i in c(5,12,13)){ # 첫 번째 반복에선 5, 12, 13
  print(i^2)
}

i <- 1

while(i<=10){i <- i+4} # i<=10이 참일 때 까지 실행해라
i # 13

# 위와 유사한 반복문
while(TRUE) { # 계속 실행하라 (repeat)
  i <- i+4
  if (i>10) break # i>10이면 멈춰라
} 

i <- 1
repeat { # = while(TRUE)
  i <- i+4
  if (i>10) break
}
# repeat은 불리언 상태값을 갖지 않으므로
# break, return()과 함께 사용해야 한다.

### 벡터 이외의 유형을 사용하는 반복문

# R은 벡터 외의 유형에서 직접적으로 반복을 지원하지는 않는다.
# => lapply(), get()을 이용해 벡터 이외의 유형(행렬, 리스트 등)에서 반복 적용

# get()
# 객체의 이름을 뜻하는 문자열을 인수로 받아 해당 이름의 객체 반환 
u <- matrix(c(1:3,1,2,4), nrow=3)
v <- matrix(c(8,12,20,15,10,2), nrow=3)

for (m in c("u","v")){
  z <- get(m) # 문자열 "u", "v"로 각각 행렬 u, v 반환
  print(lm(z[,2]~z[,1]))
}

### if-else
# 구조 : if (condition) {expression1} else {expression2}

if (r==4){
  x <- 1 
} else {
  x <- 3
  y <- 4
}
# if 부분이 x <- 1 한 문장으로 이루어져 있지만,
# else 앞에 } 가 있어야 R 파서가 if문이 아닌, if-else문이라고 파악할 수 있다.
# 따라서 if 조건문 뒤에 괄호를 붙여줘야 한다.

##### 7.2 산술 및 불리언 연산과 값

##### 7.3 인수의 기본값

read.table
#function (file, header = FALSE, sep = "", quote = "\\"'", dec = ".", 
#numerals = c("allow.loss", "warn.loss", "no.loss"), row.names, 
#col.names, as.is = !stringsAsFactors, na.strings = "NA", 
#colClasses = NA, nrows = -1, skip = 0, check.names = TRUE, 
#fill = !blank.lines.skip, strip.white = FALSE, blank.lines.skip = TRUE, 
#comment.char = "#", allowEscapes = FALSE, flush = FALSE, 
#stringsAsFactors = default.stringsAsFactors(), fileEncoding = "", 
#encoding = "unknown", text, skipNul = FALSE)   

# header, sep, ...은 argument(인자)
# header=FALSE : 이 인수가 선택적이고, 기본값이 FALSE이다.

##### 7.4 반환값

# 함수의 반환 값은 어떤 R 객체도 가능. ex) 리스트, 함수, ...

oddcount <- function(x){
  k <- 0
  for (n in x) {
    if (n%%2 == 1) k <- k+1 # %%은 나머지 연산자
  }
  return(k) # k를 반환해라 
}
# 여기서 return(k)가 없으면, 마지막으로 수행되는 문장이 for이므로 NULL을 반환
# => NULL은 따로 할당돼 저장되지 않으면 버려지므로 반환값 없음.

##### 7.5 함수는 객체다.

# R 함수는 "function" class의 1차 객체이다.
# 함수는 객체이므로 이를 할당하고 다른 함수의 인수로 활용할 수 있다.
# 여러 함수로 만들어진 리스트를 반복사용할 수 있다.

g1 <- function(x) return(sin(x))
g2 <- function(x) return(sqrt(x^2+1))
g3 <- function(x) return(2*x-1)
plot(c(0,1),c(-1,1.5),type="n")
for (f in c(g1,g2,g3)) plot(f,0,1,add=T)
# add=T 옵션이 있어야 기존 그래프 위에 그림 (플로팅)

################### 11장. 문자열 처리 ####################

##### 11.1 문자열 처리 함수 개요

# grep(pattern, x)
# 문자열 벡터 x에서 특정 부분 문자열 pattern을 가진 원소의 인덱스을 가지는 벡터
grep("Pole", c("Equator", "North Pole", "South Pole")) # c(2,3)
grep("pole", c("Equator", "North Pole", "South Pole")) # 빈 벡터

# nchar(x)
# 문자열 x의 길이를 반환
nchar("South Pole") # 10

# paste(a,b) : 문자열 합치기
paste("North","Pole") # 기본적으로 띄어쓰기 한 칸이 생긴다.
paste("North","Pole",sep="") # 구분기호를 따로 지정할 수 있다.
# 이 경우 paste0("North","Pole")과 같은 결과를 가진다.

# sprintf() : 주어진 형식에 맞춰 문자열 조합
i <- 8
s <- sprintf("the square of %d is %d", i, i^2)

# strsplit(x, split)
# x에서 문자열 split을 기준으로 나눠 부분 문자열의 리스트를 만든다.
strsplit("6-16-2011",split="-")

# regexpr(pattern, text)
# text 내에서 pattern이 처음 나타나는 위치를 찾는다.
regexpr("uat","Equator")

# gregexpr(pattern, text)
# regexpr()과 비슷하지만, pattern이 나타나는 모든 위치를 찾는다.
gregexpr("iss","Mississippi")

##### 11.2 정규 표현식

# 정규 표현식은 문자열 관련 다양한 클래스를 축양해 정의한 것

# "[au]" : a나 u 문자 중 하나라도 포함된 문자열
grep("[au]", c("Equator","North Pole","South Pole"))

# "o.e" : o다음 단일문자가 오고 e가 나오는 3개의 문자를 포함한 문자열
# ex) ebo, elo, ego, ...
grep("o.e", c("Equator","North Pole","South Pole"))
# 같은 방식으로 "N..t"는 N과 t사이에 두 개의 문자가 있는 문자열
grep("N..t", c("Equator","North Pole","South Pole"))
# . 처럼 문자 그대로 사용되지 않는 문자를 메타문자(metacharacter)라고 한다.

# 그렇다면 "."를 포함한 문자열을 찾으려면?
# => "\\"를 앞에 붙여서 메타문자 성격에서 벗어나야 한다.
grep("\\.", c("abc","de","f.g"))

### 확장 예제 : 주어진 확장자의 파일명 테스트

testsuffix <- function(filename, suffix){
  parts <- strsplit(filename, ".", fixed=TRUE)
  # fixed=T를 사용해야 .이 메타문자가 아니라 있는 그대로의 문자로 작용한다.
  # split는 문자열을 분리하여 리스트로 저장한다.
  nparts <- length(parts[[1]])
  # nparts : 문자열이 몇 개로 분리되었나
  return(parts[[1]][nparts] == suffix)
  # .을 기준으로 분리된 마지막 문자열이 suffix와 같은가
}

# 보충 설명 : strsplit의 결과
strsplit("name.txt", ".", fixed=TRUE)

# strsplit(filename, "\\.") 을 사용하여 메타문자의 성격에서 벗어날 수 있다.

# 같은 기능을 하는 다른 형태의 함수
testsuffix <- function(filename, suffix){
  ncf <- nchar(filename)
  suf.start <- ncf - nchar(suffix) + 1
  return(substr(filename, start=suf.start, stop=ncf)==suffix)
}

testsuffix("name.txt", "txt") # TRUE
testsuffix("name.txt", "csv") # FALSE

################### 12장. 그래픽 ####################

##### 12.1 그래프 만들기

# plot()
# 여러 다양한 종류의 그래프를 그려주는 역할을 하는 함수
# 대부분의 R의 기본 그래픽 연산의 밑바탕
# plot()은 generic 함수 => 관련 함수군의 대표 역할
# => 해당 객체의 클래스에 따라 달라진다.
plot(c(1,2,3),c(1,2,4))
plot(c(-3,3),c(-1,5),type="n",xlab="x",ylab="y")
# type="n" : 어떤 그래프도 그리지 않음
# xlab, ylab : x축, y축 title 설정

# abline() : 선 추가
# 기울기와 y절편으로 직선을 추가한다. 
# plot이 선언된 후에 그릴 수 있다.
x <- c(1,2,3)
y <- c(1,3,8)
plot(x,y)
lmout <- lm(y~x) # 리스트의 일종인 lm이라는 클래스. Intercept와 x기울기가 저장되어 있음
abline(lmout)

class(lmout)
mode(lmout)

# lines()
# 기본 인수는 x값 벡터와 y값 벡터
# 이 벡터들로 만들어진 (x,y)쌍들을 잇는 선이 그려진다.
lines(c(2,3),c(1,2))

# 기존 그래프를 유지한 상태로 새 그래프 그리기
hist(x) # 기존 그래프
windows() # 윈도우 : windows(), 리눅스 : x11(), 맥 : macintosh()
hist(y) # 새 창에 그래프 그려짐

### 확장 예제 : 한 화면에 두 개의 밀도 추정 그래프 그리기
d1 <- density(examsquiz$MIDTERM, from=0, to=10)
d2 <- density(examsquiz$FINAL, from=0, to=10)
plot(d1, main="", xlab="")
lines(d2)

# points() : 이미 있는 그래프 위에 점 추가

# legend() : 범례 추가

# text() : 텍스트 추가
text(5.3, 0.3, "Midterm")
text(6, 0.1, "Final")

# locator() : 위치 찾기
# 클릭한 지점의 x,y좌표 반환
locator()

##### 1,2.2 그래프 꾸미기

# cex 옵션 : 문자 크기 조절
text(8, 0.2, "Test Score", cex=1.5) # 글씨가 1.5배 커진다.

# xlim, ylim 옵션 : 축의 범위 바꾸기
plot(c(0,9), c(0,0.5), type="n", xlab="score", ylab="density")
lines(d2)
lines(d1)

# polygon() : 다각형 추가
polygon(c(2,4,4),c(0,0.1,0),col="gray") #(x,y)쌍을 잇는 다각형 생성

# lowess(), loess() : 선의 곡선화(비모수 회귀추정)
plot(examsquiz$MIDTERM, examsquiz$FINAL)
lines(lowess(examsquiz$MIDTERM, examsquiz$FINAL))

# curve() : 명시적 함수 그래프화
curve((x^2+1)^0.5,0,5) # 기존 그래프 위에 그리려면 add=T옵션을 추가한다.

##### rvest를 이용한 영화 평점 크롤링 #####

library(rvest)

title <- movie2$title
title2 <- gsub(" ","",title) #URL에 공백이 있으면 에러가 발생하므로 공백 제거
netizen_grade = c()

for (i in 1:length(title2)){
  url_base <- "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query="
  url <- paste0(url_base,title2[i])
  
  htxt <- read_html(url)
  #read_html 함수를 사용하여 URL 주소의 html 페이지를 htxt에 저장한다.
  table <- html_nodes(htxt,".r_grade")
  #html_nodes 함수를 사용하여 관람객 평점이 포함된 class가 .r_grade인 부분을 저장한다.
  r_grade <- html_text(table)
  #html_text 함수를 사용하여 table 변수에 저장한 html 문서의 text 부분을 r_grade에 저장한다.
  
  try(      # 오류가 발생할 경우, try안에 삽입된 문장은 건너뛴다.
    {grade1 <- strsplit(r_grade,split="   ")
    grade2 <- grade1[[1]][2]
    grade <- substr(grade2,1,4)
    
    netizen_grade[i] <- grade},silent = T) # try(문장, silent=T) : 문장에 오류가 있을 경우 오류메세지를 띄우지 않는다.
}

##### Summary #####

# 1. rvest를 이용한 크롤링
#   - read_html(url) : URL의 html 페이지를 불러온다.
#   - html_nodes(html1, ".class") : html 문서에서 특정 class인 부분을 불러온다.
#   - html_text(html1) : html 문서에서 text만 불러온다.

# 2. for loop에서 오류 건너뛰기 : try()
#   - try(문장, silent=T) : silent=T를 사용하면 Error Message를 출력하지 않는다.
#   - trycatch()도 있음





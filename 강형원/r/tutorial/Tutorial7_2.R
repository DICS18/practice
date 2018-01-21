#Tutorial 7-2

setwd("C:\\Work")
install.packages("googleVis")
install.packages ( "googlevis" , repos = c ( CRAN = " https://cran.r-project.org/ " )) 
library(googleVis)
Fruits
Fruits1<- gvisMotionChart(Fruits, idvar="Fruit", timevar="Year")
plot(Fruits1)

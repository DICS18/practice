data(mtcars)

install.packages("psych")

require("psych")

describe(mtcars)

des <- describe(mtcars)

des1 <- des[c(1,4,7),c(3,4,11,12)]

des1


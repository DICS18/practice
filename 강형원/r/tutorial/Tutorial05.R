# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial05.R

# Part #1
setwd("C:Work")
objects()
list.files()
list.dirs()
date()
Sys.Date()
Sys.time()
# 
# Selecting cases

# Load data
?mtcars
data(mtcars)
mtcars
View(mtcars)
edit(mtcars)
fix(mtcars)
class(mtcars)
str(mtcars)
# Mean quarter-mile time (for all cars)
mean(mtcars$qsec)

# Mean quarter-mile time (for 8-cylinder cars)
# Use square brackets to indicate what to select
# in this format: [rows]
mean(mtcars$qsec[mtcars$cyl == 8])

# Median horsepower (for all cars)
median(mtcars$hp)

# Mean MPG for cars above median horsepower
mean(mtcars$mpg[mtcars$hp > median(mtcars$hp)])

# Create new data frame for 8-cylinder cars
# To create a new data frame, must indicate
# which rows and columns to copy in this
# format: [rows, columns]. To select all
# columns, leave second part blank.
cyl.8 <- mtcars[mtcars$cyl == 8, ]

# Select 8-cylinder cars with 4+ barrel carburetors
mtcars[mtcars$cyl == 8 & mtcars$carb >= 4, ]

rm(list = ls())  # Clean up

# Part #2
# 
# Analyzing by subgroups

# Load data
?iris
data(iris)
iris
mean(iris$Petal.Width)

# Split the data file and repeat analyses
# with "aggregate"
# Compare groups on mean of one variable
aggregate(iris$Petal.Width ~ iris$Species, FUN = mean)

# Compare groups on several variables
# Use cbind to list outcome variables
aggregate(cbind(iris$Petal.Width, iris$Petal.Length) ~ iris$Species, FUN = mean)

rm(list = ls())  # Clean up


# Part #3
# 
# Merging files

# Load data
?longley
data(longley)

# Split up longley
a1 <- longley[1:14, 1:6]  # Starting data
a2 <- longley[1:14, 6:7]  # New column to add (with "Year" to match)
b <- longley[15:16, ]     # New rows to add
write.table(a1, "C:/Work/longley.a1.txt", sep="\t")
write.table(a2, "C:/Work/longley.a2.txt", sep="\t")
write.table(b, "C:/Work/longley.b.txt", sep="\t")
rm(list=ls()) # Clear out everything to start fresh

# Import data
a1t <- read.table("C:/Work/longley.a1.txt", sep="\t")
a2t <- read.table("C:/Work/longley.a2.txt", sep="\t")

# Take early years (a1t) and add columns (a2t)
# Must specify variable to match cases
a.1.2 <- merge(a1t, a2t, by = "Year")  # Merge two data frames
a.1.2  # Check results

# Add two more cases at bottom
b <- read.table("C:/Work/longley.b.txt", sep="\t")
all.data <- rbind(a.1.2, b)  # "Row Bind"
all.data  # Check data
row.names(all.data) <- NULL  # Reset row names
all.data  # Check data

rm(list=ls())  # Clean up



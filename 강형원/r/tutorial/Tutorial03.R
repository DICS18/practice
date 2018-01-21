# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial03.R

# Part #1

getwd()
setwd("C:/work")
getwd()
# Calculating frequencies

# LOAD DATASET
# Data is the number of hits (in millions) for each word on Google
groups <- c(rep("blue",   3990),
            rep("red",    4140),
            rep("orange", 1890),
            rep("green",  3770),
            rep("purple",  855))
groups
?head()
head(groups)
head(groups, n=10)
tail(groups, n=5)
# CREATE FREQUENCY TABLES
groups.t1 <- table(groups)  # Creates frequency table 
groups.t1  # Print table

# MODIFY FREQUENCY TABLES
groups.t2 <- sort(groups.t1, decreasing = TRUE)  # Sorts by frequency, saves table
groups.t2  # Print table

# PROPORTIONS AND PERCENTAGES
prop.table(groups.t2)  # Give proportions of total
round(prop.table(groups.t2), 2)  # Give proportions w/2 decimal places
round(prop.table(groups.t2), 2) * 100  # Give percentages w/o decimal places

rm(list = ls())  # Clean up
 
#  Part #2
# Calculating descriptives

# LOAD DATASET
require("datasets")
?cars
cars
View(cars)
str(cars)
data(cars)

# CALCULATE DESCRIPTIVES
summary(cars$speed)  # Summary for one variable
summary(cars)  # Summary for entire table

# Tukey's five-number summary: minimum, lower-hinge,
# median, upper-hinge, maximum. No labels.
fivenum(cars$speed)

# Boxplot stats: hinges, n, CI, outliers
boxplot.stats(cars$speed)

# ALTERNATIVE DESCRIPTIVES
# From the package "psych"
help(package = "psych")
install.packages("psych")
require("psych")
describe(cars)

# Clean up
detach("package:psych", unload=TRUE)
rm(list = ls())

 
# Part #3
# Single proportion: Hypothesis test and confidence interval

# In the 2012 Major League Baseball season,
# the Washington Nationals had the best record 
# at the end of the regular season: 98 wins out
# of 162 games (.605). Is this significantly 
# greater than 50%?

# PROP TEST
# 98 wins out of 162 games (default settings)
prop.test(98, 162)

# One-tailed test with 90% CI
prop.test(98, 162, alt = "greater", conf.level = .90)

rm(list = ls())  # Clean up



# Part #4
# Single mean: Hypothesis test and confidence interval

# Load data
?quakes
quakes[1:5, ]  # See the first 5 lines of the data
mag <- quakes$mag  # Just load the magnitude variable
mag[1:5]  # First 5 lines

# Use t-test for one-sample
# Default t-test (compares mean to 0)
t.test(mag)

# One-sided t-test w/mu = 4
t.test(mag, alternative = "greater", mu = 4)

rm(list = ls())  # Clean up



# Part #5
# Single categorical variable: One sample chi-square test

# Load data
?HairEyeColor
str(HairEyeColor)
HairEyeColor

# Get marginal frequencies for eye color
margin.table(HairEyeColor, 2)

# Save eye color to data frame
eyes <- margin.table(HairEyeColor, 2)
eyes
round(prop.table(eyes), 2)  # Show as proportions w/2 digits

# Use Pearson's chi-squared test
# Need one-dimensional goodness-of-fit test
# Default test (assume equal distribution)
chi1 <- chisq.test(eyes)  # Save tests as object "chi1"
chi1  # Check results

# Compare to population distribution
# Population data from:
browseURL("http://www.statisticbrain.com/eye-color-distribution-percentages/")
# Approximate proportions:
#  Brown: .41 (Combining Brown Irises with Specks & Dark Brown Irises)
#  Blue:  .32 (Blue / Grey Irises)
#  Hazel: .15 (Blue / Grey / Green Irises with Brown / Yellow Specks)
#  Green  .12 (Green / Light Brown Irises with Minimal Specks)
# p = c(.41, .32, .15, .12)
chi2 <- chisq.test(eyes, p = c(.41, .32, .15, .12))
chi2

rm(list = ls())  # Clean up



# Part #6
# Robust statistics for univariate analyses

# See "A Brief Overview of Robust Statistics" by Olfa Nasraoui, at
browseURL("http://j.mp/12YPV5L")

# Or see the CRAN Task View on robust statistics at
browseURL("http://cran.r-project.org/web/views/Robust.html")

# Load data
?state.area
data(state.area)  # Gets error message
area <- state.area  # But can save as vector
area
hist(area)
boxplot(area)
boxplot.stats(area)
summary(area)

# Robust methods for describing center:
mean(area)  # NOT robust
median(area)
mean(area, trim = .05)  # 5% from each end (10% total)
mean(area, trim = .10)  # 10% from each end (20% total)
mean(area, trim = .20)  # 20% from each end (40% total)
mean(area, trim = .50)  # 50% from each end = median

# Robust methods for describing variation:
sd(area)  # NOT robust
mad(area)  # Median absolute deviation
IQR(area)  # Interquartile range (Can select many methods)
fivenum(area)  # Tukey's hinges (similar to quartiles)

rm(list = ls())  # Clean up

# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial04.R

# Part #1

# 
# Examining outliers

# Categorical data
# Outlier is < 10%
# Worldwide shipments of smartphone OS
# in millions for 2013 Q1

OS <- read.csv("C:/Work/OS.csv", header = TRUE)
View(OS)
OS

# Outlier has proportion < .10
# Either combine into "other" (if homogeneous) or delete
OS.hi <- subset(OS, Proportion > 0.1)
OS.hi

# Quantitative data
# See outliers in boxplots
require("datasets")
?rivers
data(rivers)  # Lengths of Major North American Rivers
hist(rivers)
boxplot(rivers, horizontal = TRUE)
boxplot.stats(rivers)
rivers.low  <- rivers[rivers < 1210]  # Remove outliers
boxplot(rivers.low, horizontal = TRUE)  # Has new outliers
boxplot.stats(rivers.low)
rivers.low2  <- rivers[rivers < 1055]  # Remove again
boxplot(rivers.low2)  # Still one outlier

rm(list = ls())  # Clean up


# # Part #2
#  
# Transforming variables

# Load Data
require("datasets")
# The areas in thousands of square miles of the
# landmasses which exceed 10,000 square miles.
?islands
islands
hist(islands, breaks = 16)
boxplot(islands)

# z-scores
islands.z <- scale(islands)  # M = 0, SD = 1
islands.z  # Makes matrix with attribute information
hist(islands.z, breaks = 16)  # Histogram of z-scores
boxplot(islands.z)  # Boxplot of z-scores
mean(islands.z)  # M should equal 0
round(mean(islands.z), 2)  # Round off to see M = 0
sd(islands.z)  # SD = 1
attr(islands.z, "scaled:center")  # Show original mean
attr(islands.z, "scaled:scale")  # Showoriginal SD
islands.z <- as.numeric(islands.z)  # Converts from matrix back to numeric
islands.z

# Logarithmic Transformations
islands.ln <- log(islands)  # Natural log (base = e)
# islands.log10 <- log10(islands)  # Common log (base = 10)
# islands.log2 <- log2(islands)  # Binary log (base = 2)
hist(islands.ln)
boxplot(islands.ln)
# Note: Add 1 to avoid undefined logs when X = 0
# x.ln <- log(x + 1)

# Squaring
# For negatively skewed variables
# Distribution may need to be recentered so that all values are positive (0 is okay)

# Ranking
islands.rank1 <- rank(islands)
hist(islands.rank1)
boxplot(islands.rank1)
# ties.method = c("average", "first", "random", "max", "min")
islands.rank2 <- rank(islands, ties.method = "random")
hist(islands.rank2)
boxplot(islands.rank2)

# Dichotomizing
# Use wisely and purposefully!
# Split at 1000 (= 1,000,000 square miles)
# ifelse is the conditional element selection
continent <- ifelse(islands > 1000, 1, 0)
continent

rm(list = ls())  # Clean up


# Part #3
# 
# Computing composite variables

# Create variable rn1 with 1 million random normal values
# Will vary from one time to another
rn1 <- rnorm(1000000)
hist(rn1)
summary(rn1)

# Create variable rn2 with 1 million random normal values
rn2 <- rnorm(1000000)
hist(rn2)
summary(rn2)

# Average scores across two variables
rn.mean <- (rn1 + rn2)/2
hist(rn.mean)

# Multiply scores across two variables
rn.prod <- rn1 * rn2
hist(rn.prod)
summary(rn.prod)

# Kurtosis comparisons
# The package "moments" gives kurtosis where a
# mesokurtic, normal distribution has a value of 3.
# The package "psych" recenters the kurtosis values
# around 0, which is more common now.
install.packages("psych")
help(package = "psych")
require("psych")
kurtosi(rn1)
kurtosi(rn2)
kurtosi(rn.mean)
kurtosi(rn.prod)  # Similar to Cauchy distribution

# Clean up
detach("package:psych", unload=TRUE)
rm(list = ls())


# Part #4
#  
# Coding missing data

# NA = "Not Available"
# Makes certain calculations impossible
x1 <- c(1, 2, 3, NA, 5)
summary(x1)  # Works with NA
mean(x1)  # Doesn't work

# To find missing values
which(is.na(x1))  # Give index number

# Ignore missing values with na.rm = T
mean(x1, na.rm = T)

# Replace missing values with 0 (or other number)
# Option 1: Using "is.na"
x2 <- x1
x2[is.na(x2)] <- 0
x2
# Option 2: using "ifelse"
x3 <- ifelse(is.na(x1), 0, x1)
x3

# For data frames, R has many packages to deal
# intelligently with missing data via imputation.
# These are just three:
# mi: Missing Data Imputation and Model Checking
browseURL("http://cran.r-project.org/web/packages/mi/index.html")
# mice: Multivariate Imputation by Chained Equations
browseURL("http://cran.r-project.org/web/packages/mice/index.html")
# imputation
browseURL("http://cran.r-project.org/web/packages/imputation/index.html")

rm(list = ls())  # Clean up
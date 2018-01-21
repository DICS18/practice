# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial08.R

# Part #1

# 
# 
# Calculating correlations

# Load data
?swiss
data(swiss)

# Correlation matrix for data frame
cor(swiss)
round(cor(swiss), 2)  # Rounded to 2 decimals

# Can test one pair of variables at a time
# Gives r, hypothesis test, and confidence interval
cor.test(swiss$Fertility, swiss$Education)

# Install "Hmisc" package to get p-values for matrix
install.packages("Hmisc")
require("Hmisc")

# Need to coerce from data frame to matrix
# to get correlation matrix and p-values
rcorr(as.matrix(swiss))

# Clean  up
detach("package:Hmisc", unload = TRUE)
rm(list = ls())

# Part #2
#  
#  
# Computing a bivariate regression

# Load data
?trees
data(trees)
trees[1:5, ]  # Show first 5 lines

# Quick graphical check on data
hist(trees$Height)
hist(trees$Girth)
plot(trees$Girth, trees$Height)
abline(lm(trees$Height ~ trees$Girth))

# Linear regression model
reg1 <- lm(Height ~ Girth, data = trees)
reg1
summary(reg1)

# Confidence intervals for coefficients
confint(reg1)

# Predict values based on regression equation
predict(reg1)  # Predicted height based on girth
predict(reg1, interval = "prediction")  # CI for predicted height

# Regression diagnostics
lm.influence(reg1)
influence.measures(reg1)

rm(list = ls())  # Clean up


#  
# Part #3
# Comparing means with the t-test

# Load data
?sleep
sleep[1:5, ]
sd <- sleep[, 1:2]  # Save just the first two variables
sd[1:5, ]  # Show the first 5 cases

# Some quick plots to check data
hist(sd$extra, col = "lightgray")
boxplot(extra ~ group, data = sd)

# Independent 2-group t-test (with defaults)
t.test(extra ~ group, data = sd)

# t-test with options
t.test(extra ~ group,
       data = sd,
       alternative = "less",  # One-tailed test
       conf.level = 0.80)  # 80% CI (vs. 95%)

# Create two groups of random data in separate variables
# Good because actual difference is known
x <- rnorm(30, mean = 20, sd = 5)
y <- rnorm(30, mean = 22, sd = 5)
t.test(x, y)

rm(list = ls())  # Clean up

#  
# Part #4
# Comparing paired means: Paired t-test

# Load data
# Create random data
t1 <- rnorm(50, mean = 52, sd = 6)  # Time 1
dif <- rnorm(50, mean = 6, sd = 12)  # Difference
t2 <- t1 + dif  # Time 2

# Some quick plots to check data
hist(t1)
hist(dif)
hist(t2)
boxplot(t1, t2)

# Save variables in dataframe and use "MASS"
# to create parallel coordinate plot
pairs <- data.frame(t1, t2)
require("MASS")
parcoord(pairs, var.label = TRUE)

# Paired t-test (with defaults)
t.test(t2, t1, paired = TRUE)

# Paired t-test with options
t.test(t2, t1, 
       paired = TRUE,
       mu = 6,  # Specify non-0 null value
       alternative = "greater",  # One-tailed test
       conf.level = 0.99)  # 99% CI (vs. 95%)

# Clean up
detach("package:MASS", unload=TRUE)
rm(list = ls())

# Part #5
#  
# Comparing means with ANOVA

# Load data
# Each group in separate variable
x1 <- rnorm(30, mean = 40, sd = 8)
x2 <- rnorm(30, mean = 41, sd = 8)
x3 <- rnorm(30, mean = 45, sd = 8)
x4 <- rnorm(30, mean = 45, sd = 8)
# Formula result is F(3, 116) = 3.24, p = .025
boxplot(x1, x2, x3, x4)  # Quick graphical check
# Combine vectors into a single data frame
xdf <- data.frame(cbind(x1, x2, x3, x4))
summary(xdf)
# Stack data to get one column with outcome
# and second columns with group
xs <- stack(xdf)

# Conduct one-way ANOVA
anova1 <- aov(values ~ ind, data = xs)
anova1
summary(anova1)

# Post-hoc comparisons
TukeyHSD(anova1)
?pairwise.t.test  # Other post-hoc tests
?p.adjust  # Specific methods

rm(list = ls())  # Clean up

# Part #6
#  
# Comparing proportions

# Load data
# Need two vectors:
# One specifies the total number of people in each group
# This creates a vector with 5 100s in it, for 5 groups
# Same as "number of trials"
n5 <- c(rep(100, 5))
# Another specifies the number of people who are in category
# Same as "number of successes"
x5 <- c(65, 60, 60, 50, 45)
prop.test(x5, n5)

# If there are only two groups, then it gives a confidence
# interval for the difference between the groups; 
# the default CI is .95
n2 <- c(40, 40)  # Number of trials
x2 <- c(30, 20)  # Number of successes
prop.test(x2, n2, conf.level = .80)

rm(list = ls())  # Clean up

# Part #7
#  
# Creating crosstabs for categorical variables

# Load data
?Titanic
str(Titanic)
Titanic
ftable(Titanic)  # Makes "flat" table

# Convert table to data frame with one row per observation
tdf <- as.data.frame(lapply(as.data.frame.table(Titanic), function(x)rep(x, as.data.frame.table(Titanic)$Freq)))[, -5]
tdf[1:5, ]  # Check first five rows of data

# Create contingency table
ttab <- table(tdf$Class, tdf$Survived)
ttab

# Call also get cell, row, and column %
# With rounding to get just 2 decimal places
# Multiplied by 100 to make %
round(prop.table(ttab, 1), 2) * 100 # row %
round(prop.table(ttab, 2), 2) * 100 # column %
round(prop.table(ttab), 2) * 100    # cell %

# Chi-squared test
tchi <- chisq.test(ttab)
tchi

# Additional tables
tchi$observed   # Observed frequencies (same as ttab)
tchi$expected   # Expected frequencies
tchi$residuals  # Pearson's residual
tchi$stdres     # Standardized residual

rm(list = ls())  # Clean up


# Part #8
#  
# Computing robust statistics for bivariate associations

# Robust regression: A sampling of packages
help(package = "robust")
help(package = "robustbase")
help(package = "MASS")  # See rlm ("robust linear model")
help(package = "quantreg")  # Quantile regression

# Example from "quantreg" package
install.packages("quantreg")
require(quantreg)
?rq  # Help on "quantile regression" in quantreg package
data(engel)
?engel
attach(engel)

plot(income,  # Create plot frame
     foodexp,
     xlab = "Household Income",
     ylab = "Food Expenditure",
     type = "n", 
     cex = .5)
points(income,  # Points in plot
       foodexp,
       pch = 16,
       col = "lightgray")
taus <- c(.05, .1, .25, .75, .9, .95)  # Quantiles
xx <- seq(min(income), max(income), 100)  # X values
f <- coef(rq((foodexp)~(income), tau=taus))  # Coefficients
yy <- cbind(1, xx)%*%f  # Y values
for(i in 1:length(taus)){  # For each quantile value...
  lines(xx, yy[, i], col = "darkgray")  # Draw regression
}
abline(lm(foodexp ~ income),  # Standard LS regression
       col = "darkred",
       lwd = 2)
abline(rq(foodexp ~ income),  # Median regression
       col = "blue",
       lwd = 2)
legend(3000, 1000,  # Plot legend
       c("mean fit", "median fit"),
       col = c("darkred", "blue"),
       lty = 1,
       lwd = 2)

# Clean up
detach(engel)
detach("package:robust", unload=TRUE)
detach("package:quantreg", unload=TRUE)
detach("package:MASS", unload=TRUE)
detach("package:rrcov", unload=TRUE)
rm(list = ls())  

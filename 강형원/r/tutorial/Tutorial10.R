# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial10.R

# Part #1
#  
# Computing a multiple regression

# Load data
?USJudgeRatings
data(USJudgeRatings)
USJudgeRatings[1:5, ]

# Basic multiple regression
reg1 <- lm(RTEN ~ CONT + INTG + DMNR + DILG + CFMG + 
             DECI + PREP + FAMI + ORAL + WRIT + PHYS,
           data = USJudgeRatings)
reg1  # Gives the coefficients only
summary(reg1)  # Much more

# More detailed summaries
anova(reg1)
coef(reg1)  # Or coefficients(reg1)
confint(reg1)  # CI for coefficients
resid(reg1)  # Or residuals; Residuals case-by-case
hist(residuals(reg1))  # Histogram of residuals
# And others

# Possibility of stepwise variables selection
# (backwards and forwards); exercise caution!

# Backwards stepwise regression
# Repeating the first regression model, which contains
# all of the predictor variables and serves as the 
# starting point
reg1 <- lm(RTEN ~ CONT + INTG + DMNR + DILG + CFMG + 
             DECI + PREP + FAMI + ORAL + WRIT + PHYS,
           data = USJudgeRatings)
regb <- step(reg1,
             direction = "backward",
             trace = 0)  # Don't print the steps
summary(regb)

# Forwards stepwise regression
# Start with model that has nothing but a constant
reg0 <- lm(RTEN ~ 1, data = USJudgeRatings)  # Minimal model
reg0
regf <- step(reg0,  # Start with minimal model
             direction = "forward",
             scope = (~ CONT + INTG + DMNR + DILG + 
                        CFMG + DECI + PREP + FAMI + 
                        ORAL + WRIT + PHYS),
             data = USJudgeRatings,
             trace = 0)  # Don't print the steps
summary(regf)

# For many more options, see the "rms" package
# ("Regression Modeling Strategies")

rm(list = ls())  # Clean up

# Part #2
#  
# Comparing means with a two-factor ANOVA

# Load data 
# Built-in dataset "warpbreaks"
?warpbreaks
data(warpbreaks)
boxplot(breaks ~ wool*tension, data = warpbreaks)

# Model with interaction
aov1 <- aov(breaks ~ 
              wool + tension + wool:tension, 
            # or: wool*tension, 
            data = warpbreaks)
summary(aov1)

# Additional information on model
model.tables(aov1)
model.tables(aov1, type = "means")
model.tables(aov1, type = "effects")  # "effects" is default

# Post-hoc test
TukeyHSD(aov1)

remove(list = ls())  # Clean up


# Part #3
#  
# Conducting a cluster analysis

# Load data
?mtcars
data(mtcars)
mtcars[1:5, ]
mtcars1 <- mtcars[, c(1:4, 6:7, 9:11)]  # Select variables
mtcars1[1:5, ]

# Three major kinds of clustering:
#   1. Split into set number of clusters (e.g., kmeans)
#   2. Hierarchical: Start separate and combine
#   3. Dividing: Start with a single group and split

# We'll use hierarchical clustering
# Need distance matrix (dissimilarity matrix)
d <- dist(mtcars1)
d  # Huge matrix

# Use distance matrix for clustering
c <- hclust(d)
c

# Plot dendrogram of clusters
plot(c)

# Put observations in groups
# Need to specify either k = groups or h = height
g3 <- cutree(c, k = 3)  # "g3" = "groups 3"
# cutree(hcmt, h = 230) will give same result
g3
# Or do several levels of groups at once
# "gm" = "groups/multiple"
gm <- cutree(c, k = 2:5) # or k = c(2, 4)
gm

# Draw boxes around clusters
rect.hclust(c, k = 2, border = "gray")
rect.hclust(c, k = 3, border = "blue")
rect.hclust(c, k = 4, border = "green4")
rect.hclust(c, k = 5, border = "darkred")

# k-means clustering
km <- kmeans(mtcars1, 3)
km

# Graph based on k-means
require(cluster)
clusplot(mtcars1,  # data frame
         km$cluster,  # cluster data
         color = TRUE,  # color
         #          shade = TRUE,  # Lines in clusters
         lines = 3,  # Lines connecting centroids
         labels = 2)  # Labels clusters and cases

rm(list = ls())  # Clean up


# Part #4
#  
# Conducting a principal components/factor analysis

# From "psych" package documentation (p. 213)
# "The primary empirical difference between a components 
# versus a factor model is the treatment of the variances
# for each item. Philosophically, components are weighted
# composites of observed variables while in the factor
# model, variables are weighted composites of the factors."

# Load data 
?mtcars
data(mtcars)
mtcars[1:5, ]
mtcars1 <- mtcars[, c(1:4, 6:7, 9:11)]  # Select variables
mtcars1[1:5, ]

# Principle components model using default method
# If using entire data frame:
pc <- prcomp(mtcars1,
             center = TRUE,  # Centers means to 0 (optional)
             scale = TRUE)  # Sets unit variance (helpful)
# Or specify variables:
# pc <- prcomp(~ mpg + cyl + disp + hp + wt + qsec + am + 
#                gear + carb, data = mtcars, scale = TRUE)
?prcomp  # Generally preferred
?princomp  # Very slightly different method, similar to S

# Get summary stats
summary(pc)

# Screeplot
plot(pc)

# Get standard deviations and how variables load on PCs
pc

# See how cases load on PCs
predict(pc)

# Biplot
biplot(pc)

# Factor Analysis
# Varimax rotation by default
# Gives chi square test that number of factors
# is sufficient to match data (want p > .05).
# Also gives uniqueness values for variables,
# variable loadings on factors, and variance
# statistics.
factanal(mtcars1, 1)
factanal(mtcars1, 2)
factanal(mtcars1, 3)
factanal(mtcars1, 4)  # First w/p > .05

rm(list = ls())  # Clean up

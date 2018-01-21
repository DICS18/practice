# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial07.R
# 
# 
# Part_01
# Creating bar charts of group means

# Load data
?InsectSprays
spray <- InsectSprays  # Load data with shorter name

# To plot means, first get the means for the groups 
means <- aggregate(spray$count ~ spray$spray, FUN = mean)
means
plot(means)  # Gets lines for means

# To get a barplot, need to extract means and reorganize
mean.data <- t(means[-1])  # Removes first columns, transposes second
colnames(mean.data) <- means[, 1]
mean.data

# Basic barplot for means
barplot(mean.data)

# Modified barplot
barplot(mean.data,
        col = "lightblue",
        main = "Effectiveness of Insect Sprays",
        xlab = "Spray Used",
        ylab = "Insect Count")

rm(list = ls())


# Part_02
# 
# Creating grouped boxplots

# Load data
# Use dataset "painters" from the package "MASS
require(MASS)
?painters
# For an interesting follow-up on this data, see
# "Taste Endures! The Rankings of Roger de Piles (†1709)
# and Three Centuries of Art Prices" by Kathryn Graddy at
browseURL("http://people.brandeis.edu/~kgraddy/published%20papers/DePiles_complete.pdf")
data(painters)
painters

# Draw boxplots of outcome (Expression) by group (School)
# Basic version
boxplot(painters$Expression ~ painters$School)

# Modified version
require("RColorBrewer")
boxplot(painters$Expression ~ painters$School,
        col = brewer.pal(8, "Pastel2"),
        names  = c("Renais.",
                   "Mannerist",
                   "Seicento",
                   "Venetian",
                   "Lombard",
                   "16th C.",
                   "17th C.",
                   "French"),
        #         notch = TRUE,  # Not good because of small samples; don't use
        boxwex = 0.5,  # Width of box
        whisklty = 1,  # Whisker line type; 1 = solid line
        staplelty = 0,  # Staple type; 0 = none
        outpch = 16,  # Outlier symbol; 16 = filled circle
        outcol = brewer.pal(8, "Pastel2"),  # Outlier color
        main = "Expression Ratings of Painters by School\nFrom \"painters\" Dataset in \"MASS\" Package",
        xlab = "Painter's School",
        ylab = "Expression Ratings")

# Clean up
detach("package:MASS", unload=TRUE)
detach("package:RColorBrewer", unload=TRUE)
rm(list = ls())


# Part_03
#  
# Creating scatterplots

# Load data
?cars
data(cars)
cars

# Basic scatterplot
plot(cars)

# Modified scatterplot
plot(cars,
     pch = 16,
     col = "gray",
     main = "Speed vs. Stopping Distance for Cars in 1920s\nFrom \"cars\" Dataset",
     xlab = "Speed (MPH)",
     ylab = "Stopping Distance (feet)")
# Linear regression line
abline(lm(cars$dist ~ cars$speed), 
       col = "darkred", 
       lwd = 2)  
# "locally weighted scatterplot smoothing"
lines(lowess (cars$speed, cars$dist), 
      col = "blue", 
      lwd = 2)  

# "car" package ("Companion to Applied Regression")
# Has many variations on scatterplots
install.packages("car")
help(package = "car")
require(car)
# "scatterplot" has marginal boxplots, smoothers, and quantile regression intervals
scatterplot(cars$dist ~ cars$speed,
            pch = 16,
            col = "darkblue",
            main = "Speed vs. Stopping Distance for Cars in 1920s\nFrom \"cars\" Dataset",
            xlab = "Speed (MPH)",
            ylab = "Stopping Distance (feet)")

# Clean up
detach("package:car", unload=TRUE)
rm(list = ls())



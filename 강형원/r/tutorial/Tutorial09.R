# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial09.R

# Part #1

#  
# Creating clustered bar chart for frequencies

# Load data
# Built-in dataset "warpbreaks"
?warpbreaks
# Doesn't work:
barplot(breaks ~ wool*tension, data = warpbreaks)

data <- tapply(warpbreaks$breaks,
               list(warpbreaks$wool,
                    warpbreaks$tension),
               mean)

barplot(data,
        beside = TRUE,
        col = c("steelblue3", "thistle3"),
        bor = NA,
        main = "Mean Number of Warp Breaks\nby Tension and Wool",
        xlab = "Tension",
        ylab = "Mean Number of Breaks")

# For legend, "locator(1)" is interactive and lets you click
# where you want to put the legend. You can also specify
# with coordinates.
legend(locator(1),
       rownames(data),
       fill = c("steelblue3", "thistle3"))

rm(list = ls())  # Clean up


# Part #2
#  
# Creating scatterplots for grouped data

# Load data
?iris
data(iris)
iris[1:5, ]

# Load "car" package
require(car)  # "Companion to Applied Regression"

# Single scatterplot with groups marked
# Function can be called "scatterplot" or "sp"
sp(Sepal.Width ~ Sepal.Length | Species,
   data = iris, 
   xlab = "Sepal Width", 
   ylab = "Sepal Length", 
   main = "Iris Data", 
   labels = row.names(iris))

# Clean up
detach("package:car", unload=TRUE)
rm(list = ls())


# Part #3
#  
# Creating scatterplot matrices

# Load data
?iris
data(iris)
iris[1:5, ]

# Basic scatterplot matrix
pairs(iris[1:4])

# Modified scatterplot matrices

# Create palette with RColorBrewer
require("RColorBrewer")
display.brewer.pal(3, "Pastel1")

# Put histograms on the diagonal (from "pairs" help)
panel.hist <- function(x, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(usr[1:2], 0, 1.5) )
  h <- hist(x, plot = FALSE)
  breaks <- h$breaks; nB <- length(breaks)
  y <- h$counts; y <- y/max(y)
  rect(breaks[-nB], 0, breaks[-1], y,  ...)
  # Removed "col = "cyan" from code block; original below
  # rect(breaks[-nB], 0, breaks[-1], y, col = "cyan", ...) 
}

pairs(iris[1:4], 
      panel = panel.smooth,  # Optional smoother
      main = "Scatterplot Matrix for Iris Data Using pairs Function",
      diag.panel = panel.hist, 
      pch = 16, 
      col = brewer.pal(3, "Pastel1")[unclass(iris$Species)])

# Similar with "car" package
# Gives kernal density and rugplot for each variable
library(car)
scatterplotMatrix(~Petal.Length + Petal.Width + Sepal.Length + Sepal.Width | Species,
                  data = iris,
                  col = brewer.pal(3, "Dark2"),
                  main="Scatterplot Matrix for Iris Data Using \"car\" Package")

# Clean up
palette("default")  # Return to default
detach("package:RColorBrewer", unload = TRUE)
detach("package:car", unload=TRUE)
rm(list = ls())


# Part #4
#  
# Creating 3-D scatterplots

# Load data
?iris
data(iris)
iris[1:5, ]

# Static 3D scatterplot
# Install and load the "scatterplot3d" package
install.packages("scatterplot3d")
require("scatterplot3d")

# Basic static 3D scatterplot
scatterplot3d(iris[1:3])

# Modified static 3D scatterplot
# Coloring, vertical lines
# and Regression Plane 
s3d <-scatterplot3d(iris[1:3],
                    pch = 16,
                    highlight.3d = TRUE,
                    type = "h",
                    main = "3D Scatterplot")
plane <- lm(iris$Petal.Length ~ iris$Sepal.Length + iris$Sepal.Width) 
s3d$plane3d(plane)

# Spinning 3D scatterplot
# Install and load the "rgl" package ("3D visualization 
# device system (OpenGL)")
# NOTE: This will cause RStudio to crash when graphics 
# window is closed. Instead, run this in the standard, 
# console version of R.
install.packages("rgl")
require("rgl")
require("RColorBrewer")
plot3d(iris$Petal.Length,  # x variable
       iris$Petal.Width,   # y variable
       iris$Sepal.Length,  # z variable
       xlab = "Petal.Length",
       ylab = "Petal.Width",
       zlab = "Sepal.Length",
       col = brewer.pal(3, "Dark2")[unclass(iris$Species)],
       size = 8)

# Clean up
detach("package:scatterplot3d", unload = TRUE)
detach("package:rgl", unload = TRUE)
detach("package:RColorBrewer", unload = TRUE)
rm(list = ls())


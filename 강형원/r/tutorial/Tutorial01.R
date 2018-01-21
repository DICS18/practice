# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial01.R

# Part #1

getwd()

setwd("C:/Work")

getwd()

# Taking a first look at the interface

8 + 5  # Basic math; press cmd/ctrl-enter

1:250  # Prints numbers 1 to 250 across several lines

print("Hello World!")  # Prints "Hello World" in console

# Variables
x <- 1:5  # Put the numbers 1-5 in the variable x
x  # Displays the values in x

y <- c(6, 7, 8, 9, 10)  # Puts the numbers 6-10 in y
y

a <- 1  # Use <- and not =
2 -> a  # Can go other way, but silly
a <- b <- c <- 3  # Multiple assignments

# Vector Math
x
y
x + y  # Adds corresponding elements in x and y
x * 2  # Multiplies each element in x by 2

# "Google's R Style Guide"
browseURL("https://google.github.io/styleguide/Rguide.xml")

# Clean up
rm(x)  # Remove an object from workspace
rm(a, b)  # Remove more than one
rm(list = ls())  # Clear entire workspace

# Part #2

# 
# Installing and managing packages

# LISTS OF PACKAGES
# Opens CRAN Task Views in browser
# Opens "Available CRAN Packages By Name" (from UCLA mirror) in browser
browseURL("http://cran.stat.ucla.edu/web/packages/available_packages_by_name.html")
# See also CRANtastic
browseURL("http://crantastic.org/")

# See current packages
library()  # Brings up editor list of installed packages
search()   # Shows packages that are currently loaded

# TO INSTALL AND USE PACKAGES
# Can use menus: Tools > Install Packages... (or use Package window)
# Or can use scripts, which can be saved in incorporated in source
install.packages("ggplot2")  # Downloads package from CRAN and installs in R
?install.packages
library("ggplot2")  # Make package available; often used for loading in scripts
require("ggplot2")  # Preferred for loading in functions; maybe better?
library(help = "ggplot2")  # Brings up documentation in editor window

# VIGNETTES
vignette(package = "grid")  # Brings up list of vignettes (examples) in editor window
?vignette
browseVignettes(package = "grid")  # Open web page with hyperlinks for vignette PDFs etc.
vignette()  # Brings up list of all vignettes for currently installed packages
browseVignettes()  # HTML for all vignettes for currently installed packages
# If links are dead, go to CRAN and search by name
browseURL("http://cran.stat.ucla.edu/web/packages/available_packages_by_name.html")

# UPDATE PACKAGES
# In RStudio, Tools > Check for Package Updates
update.packages()  # Checks for updates; do periodically
?update.packages

# UNLOAD/REMOVE PACKAGES
# By default, all loaded packages are unloaded when R quits
# Can also open Packages window and manually uncheck
# Or can use this code
# To unload packages
detach("package:ggplot2", unload = TRUE)
?detach

# To permanently remove (delete) package
install.packages("psytabs")  # Adds psytabs
remove.packages("psytabs")   # Deletes it
?remove.packages

# Part #3


# Using R’s built-in datasets

?datasets
library(help = "datasets")
# To load "datasets," the built-in R datasets package,
# either click on "datasets" in the package manager or
# type either of the following:
?library
library(datasets)
?require
require(datasets)

# To remove the datasets package
detach(package:datasets)

# To see a list of the available datasets
data()

# You can see the same list with clickable links
# to descriptions for each dataset at
browseURL("http://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html")

# For information on a specific dataset
?airmiles

# To load a dataset from the package into the Workspace
data(airmiles)  # Listed as "ts" for "time-series"

# To see the contents of the dataset
# (Don't actually need to load for this)
airmiles

# To see its "structure"
?str
str(airmiles)

# Or, in RStudio, click on the dataset in "Workspace,"
# which uses the "fix" function and makes it possible
# edit the dataset in a new window

# Now a dataset that has rows and columns
?anscombe
data(anscombe)  # Appears under "Data" in the Workspace

# See its structure
str(anscombe)

# See its data (or click on name in Workspace)
anscombe

rm(list = ls())  # Clean up

# Part #4


# Entering data manually

# Create sequential data
x1 <- 0:10  # Assigns number 0 through 10 to x1
x1  # Prints contents of x1 in console

x2 <- 10:0  # Assigns number 10 through 0 to x2
x2

x3 <- seq(10)  # Counts from 1 to 10
x3
?seq

x4 <- seq(30, 0, by = -3)  # Counts down by 3
x4

# Manually enter data
x5 <- c(5, 4, 1, 6, 7, 2, 2, 3, 2, 8)  # Concatenate
x5
?c

x6 <- scan()  # After running this command, go to console
# Hit return after each number
# Hit return twice to stop
x6
?scan

ls()  # List objects (same as Workspace viewer)
?ls

rm(list = ls())  # Clean up


# Part #5

getwd()
setwd("c:/Work")
getwd()

# Importing data

# EXCEL FILES
# Don't do it
browseURL("http://cran.r-project.org/doc/manuals/R-data.html#Reading-Excel-spreadsheets")

# TEXT FILES
# Load a spreadsheet that has been saved as tab-delimited text file
# Need to give complete address to file
# This command gives an error on missing data
# but works on complete data
# "header = TRUE" means the first line is a header
trends.txt <- read.table("C:/Work/GoogleTrends.txt", header = TRUE)
?read.table

# This works with missing data by specifying the
# separator: \t is for tabs, sep = "," for commas
# R converts missing to "NA"
trends.txt <- read.table("C:/Work/GoogleTrends.txt", header = TRUE, sep = "\t")
trends.txt
str(trends.txt)  # This gives structure of object sntxt
# Or click on file in Workspace viewer, which brings up this:
View(trends.txt)
edit(trends.txt)
fix(trends.txt)
?View

# CSV FILES
# Don't have to specify delimiters for missing data
# because CSV means "comma separated values"
trends.csv <- read.csv("C:/Work/GoogleTrends.csv", header = TRUE)
str(trends.csv)
View(trends.csv)

rm(list = ls())  # Clean up


# Part #6


# Converting tabular data to row data

# Load data
?UCBAdmissions
str(UCBAdmissions)
UCBAdmissions

# The problem
admit.fail <- (UCBAdmissions$Admit)  # Doesn't work
barplot(UCBAdmissions$Admit)  # Doesn't work
plot(UCBAdmissions)  # DOES work but not what we wanted now

# Get marginal frequencies from original table
margin.table(UCBAdmissions, 1)  # Admit
margin.table(UCBAdmissions, 2)  # Gender
margin.table(UCBAdmissions, 3)  # Dept
margin.table(UCBAdmissions)     # Total
?margin.table

# Save marginals as new table
admit.dept <- margin.table(UCBAdmissions, 3)  # Dept
str(admit.dept)
barplot(admit.dept)
admit.dept  # Show frequencies
prop.table(admit.dept)  # Show as proportions
round(prop.table(admit.dept), 2)  # Show as proportions w/2 digits
round(prop.table(admit.dept), 2) * 100  # Give percentages w/o decimal places
?prop.table
?round

# Go from table to one row per case
admit1 <- as.data.frame.table(UCBAdmissions)  # Coerces to data frame
admit1
str(admit1)
class(admit1)
admit2 <- lapply(admit1, function(x)rep(x, admit1$Freq))  # Repeats each row by Freq
admit2
admit3 <- as.data.frame(admit2)  # Converts from list back to data frame
admit3
admit4 <- admit3[, -4]# Removes fifth column with frequencies
admit4
# Or do it all in one go
admit.rows <- as.data.frame(lapply(as.data.frame.table(UCBAdmissions), function(x)rep(x, as.data.frame.table(UCBAdmissions)$Freq)))[, -4]
str(admit.rows)
admit.rows[1:10, ]  # View first ten rows of data (of 4526)

rm(list = ls())  # Clean up

data()
search()
# Part #6


# Working with color

# Barplot
x = c(12, 4, 21, 17, 13, 9)
barplot(x)

# R specifies color in several ways
?colors
# Web page with PDFs of colors in R
browseURL("http://research.stowers.org/mcm/efg/R/Color/Chart/")

# Color names
# R has names for 657 colors, arranged alphabetically except for white (first)
# "Gray" or "grey": either is acceptable
colors()  # Gives list of color names
barplot(x, col = "slategray3")

# Color numbers
# From color name's position in alphabetically-order vector of colors()
# Specify colors() [i], where i is index number in vector
barplot(x, col = colors() [102])  # darkseagreen
barplot(x, col = colors() [602])  # Back to slategray3

# RGB Triplets
# Separately specify the red, green, and blue components of the color
# By default, colors are specified in 0-1 range
# Can specify 0-255 range by adding "max = 255"
?rgb
# Can convert color names to rgb with "col2rgb"
?col2rgb
col2rgb("navyblue")  # Yields (0, 0, 128)
barplot(x, col = rgb(.54, .0, .0))  # darkred
barplot(x, col = rgb(159, 182, 205, max = 255))  # Back to slategray3

# RGB Hexcodes
# Can also use shortcut hexcodes (base 16), which are equivalent to
# RGB on the 0-255 scale, as FF in hex equals 255 in decimal
barplot(x, col = "#FFEBCD")  # blanchedalmond
barplot(x, col = "#9FB6CD")  # Back to slategray3

# MULTIPLE COLORS
# Can specify several colors (using any coding method) in vector
barplot(x, col = c("red", "blue"))  # Colors will cycle
barplot(x, col = c("red", "blue", "green", "yellow"))  # Colors will cycle

# USING COLOR PALETTES
# Palettes can be more attractive and more informative
# Easiest to use
help(package=colorspace)  # Lots of info on color spaces
?palette

# Built-in palettes
# rainbow(n, s = 1, v = 1, start = 0, end = max(1, n - 1)/n, alpha = 1)
# heat.colors(n, alpha = 1)  # Yellow through red
# terrain.colors(n, alpha = 1)  # Gray through green
# topo.colors(n, alpha = 1)  # Purple through tan
# cm.colors(n, alpha = 1)  # Blues and pinks
help(package = colorspace)
palette()
barplot(x, col = 1:6)
barplot(x, col = rainbow(6))
barplot(x, col = heat.colors(6))
barplot(x, col = terrain.colors(6))
barplot(x, col = topo.colors(6))
barplot(x, col = cm.colors(6))
palette("default")  # Return to default

rm(list = ls())  # Clean up


# Part #7


# Exploring Color with RColorBrewer

# Barplot
x = c(12, 4, 21, 17, 13, 9)
barplot(x)

# RColorBrewer
browseURL("http://colorbrewer2.org/")  # Uses Flash
install.packages("RColorBrewer")
help(package = "RColorBrewer")
require("RColorBrewer")
search()
# Show all of the palettes in a graphics window
display.brewer.all()

# To see palette colors in separate window, give number
# of desired colors and name of palette in quotes
display.brewer.pal(8, "Accent")
display.brewer.pal(4, "Spectral")

# Barplots
# Can save palette as vector or call in function
blues <- brewer.pal(6, "Blues")
barplot(x, col = blues)
barplot(x, col = brewer.pal(6, "Greens"))
barplot(x, col = brewer.pal(6, "YlOrRd"))
barplot(x, col = brewer.pal(6, "RdGy"))
barplot(x, col = brewer.pal(6, "BrBG"))
barplot(x, col = brewer.pal(6, "Dark2"))
barplot(x, col = brewer.pal(6, "Paired"))
barplot(x, col = brewer.pal(6, "Pastel2"))
barplot(x, col = brewer.pal(6, "Set3"))

# Clean up
palette("default")  # Return to default
detach("package:RColorBrewer", unload = TRUE)
rm(list = ls())  


# Part #8 -Problem

#
# Solution

# Creating color palettes

# For all of these challenges, create barplots with the
# required number of bars, all at uniform height

# Create values for barplot
n <- 5  # Number of bars needed
x <- c(rep(10, n))  # Creates n bars of uniform height
barplot(x, col = rainbow(n))  # Uses x and n

# Using R's built-in palettes

# 1. Show 5 different categories
n <- 5
x <- c(rep(10, n))
barplot(x, col = rainbow(n))

# 2. Show 8 sequential values
n <- 8
x <- c(rep(10, n))
barplot(x, col = heat.colors(n))

# 3. Show 11 divergent values
n <- 11
x <- c(rep(10, n))
barplot(x, col = cm.colors(n))

# Using RColorBrewer
require("RColorBrewer")
display.brewer.all()

# 4. Show 7 different categories
n <- 7
x <- c(rep(10, n))
barplot(x, col = brewer.pal(n, "Set1"))
display.brewer.pal(n, "Set1")

# 5. Show 6 sequential values
n <- 6
x <- c(rep(10, n))
barplot(x, col = brewer.pal(n, "BuPu"))
display.brewer.pal(n, "BuPu")

# 6. Show 9 divergent values
n <- 9
x <- c(rep(10, n))
barplot(x, col = brewer.pal(n, "PRGn"))
display.brewer.pal(n, "PRGn")

# Clean up
detach("package:RColorBrewer", unload=TRUE)
rm(list = ls()) 
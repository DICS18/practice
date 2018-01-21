# 산업경영공학과 R 특강
#
# 2017 Summer
# 
# 김연수 교수 yonskim@paran.com / 032-835-8487
# 
# Tutorial02.R

# Part #1

getwd()
setwd("C:/work")
# 
# Creating bar charts for categorical variables

# HELP ON PLOTS

?plot

# LOAD DATASETS PACKAGE
search()
require("datasets")
data()

# ONE ROW PER CASE
?chickwts
chickwts  # Look at data
data(chickwts)  # Load data into workspace
str(chickwts)
chickwts
# Quickest Method
plot(chickwts$feed)  # Plot feed from chickwts
?plot

# "barplot" offers more control but must prepare data:
# R doesn't create bar charts directly from the categorical
# variables; instead, we must first create a table that
# has the frequencies for each level of the variable.

feeds <- table(chickwts$feed)
feeds
barplot(feeds)  # Identical to plot(chickwts$feed)
?barplot

# To put the bars in descending order, add "order":
barplot(feeds[order(feeds, decreasing = TRUE)])

# Customize the chart
par(oma = c(1, 1, 1, 1))  # Sets outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)], 
        horiz  = TRUE,
        las    = 1,  # las gives orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",  # \n = line break
        xlab   = "Number of Chicks")
?par

rm(list = ls())  # Clean up

# 
# Part #2
# Creating pie charts for categorical variables

# LOAD DATASETS PACKAGE
require("datasets")

# ONE ROW PER CASE
data(chickwts)

# Create a table with frequencies
feeds <- table(chickwts$feed)
feeds

# Make the pie chart with the defaults
pie(feeds)
?pie

# Modify the pie chart
pie(feeds[order(feeds, decreasing = TRUE)],
    init.angle = 90,   # Starts as 12 o'clock instead of 3
    clockwise = TRUE,  # Default is FALSE
    col = c("seashell", "cadetblue2", "lightpink", "lightcyan", "plum1", "papayawhip"),
    main = "Pie Chart of Feeds from chickwts")

# THE PROBLEM WITH PIE CHARTS
# Three data sets
pie.a <- c(22, 14, 18, 20, 14, 12)
pie.b <- c(20, 18, 16, 18, 16, 12)
pie.c <- c(12, 14, 20, 18, 14, 22)

# Changing graphical parameters for a minute
oldpar <- par()   # Stores old graphical parameters
par(mfrow    = c(1, 3),  # Num. rows/cols
    cex.main = 3)   #  Main title 3x bigger
colors <- c("grey98", "grey90", "lightskyblue", "lightgreen", "grey98", "grey90")
?colors

# Three pie charts side by side
# Is the green slice or blue slice bigger?
pie(pie.a, main = "Pie A", col = colors)
pie(pie.b, main = "Pie B", col = colors)
pie(pie.c, main = "Pie C", col = colors)

# Three bar charts side by side
# Is the green bar or blue bar bigger?
barplot(pie.a, main = "Bar A", col = colors)
barplot(pie.b, main = "Bar B", col = colors)
barplot(pie.c, main = "Bar C", col = colors)

# CONCLUSION
# From R help on pie charts:
?pie

# Pie charts are a very bad way of displaying information.
# The eye is good at judging linear measures and bad at
# judging relative areas. A bar chart or dot chart is a
# preferable way of displaying this type of data.
# 
# Cleveland (1985), page 264: “Data that can be shown by
# pie charts always can be shown by a dot chart. This means
# that judgements of position along a common scale can be
# made instead of the less accurate angle judgements.”
# This statement is based on the empirical investigations
# of Cleveland and McGill as well as investigations by
# perceptual psychologists.

par(oldpar)  # Restore old graphical parameters
# Note that cin, cra, csi, cxy, and din are read-only
# parameters that were written to oldpar but cannot be
# rewritten; just ignore the warning messages for these.
?par

rm(list = ls())  # Clean up

# 
# Part #3
# Creating histograms for quantitative variables

# LOAD DATASETS PACKAGE
require("datasets")
?lynx
data(lynx)  # Annual Canadian Lynx trappings 1821-1934

# Make a histogram using the defaults
hist(lynx)
?hist

# Modify histogram
h <- hist(lynx,  # Save histogram as object
          breaks = 11,  # "Suggests" 11 bins
          #           breaks = seq(0, 7000, by = 100),
          #           breaks = c(0, 100, 300, 500, 3000, 3500, 7000),
          freq = FALSE,
          col = "thistle1", # Or use: col = colors() [626]
          main = "Histogram of Annual Canadian Lynx Trappings\n1821-1934",
          xlab = "Number of Lynx Trapped")

# IF freq = FALSE, this will draw normal distribution
curve(dnorm(x, mean = mean(lynx), sd = sd(lynx)), 
      col = "thistle4", 
      lwd = 2,
      add = TRUE)
?curve

rm(list = ls())  # Clean up

# 
# Part #4
# Creating boxplots for quantitative variables
data()
# LOAD DATASET
search()
require("datasets")
# Lawyers' Ratings of State Judges in the US Superior Court (c. 1977)
?USJudgeRatings
USJudgeRatings  # View data
str(USJudgeRatings)
class(USJudgeRatings)
mode(USJudgeRatings)
view(USJudgeRatings)
data(USJudgeRatings)  # Load into workspace
View(USJudgeRatings)
edit(USJudgeRatings)
# At least two errors in data file:
# 1. Data appears to be on 1-10 or 0-10 scale but Callahan
#    has a 10.6 on CONT. 8.6 seems more likely.
# 2. Santaniello's last name is misspelled
# Best to fix errors in spreadsheet and reimport

# Make boxplot using the defaults
boxplot(USJudgeRatings$RTEN)
?boxplot

# Modify boxplot
boxplot(USJudgeRatings$RTEN,
        horizontal = TRUE,
        las = 1,  # Make all labels horizontal
        notch = TRUE,  # Notches for CI for median
        ylim = c(0, 10),  # Specify range on Y axis
        col = "slategray3",   # R's named colors (n = 657)
        #         col = colors() [602], # R's color numbers
        #         col = "#9FB6CD",      # Hex codes for RBG
        #         col = rgb(159, 182, 205, max = 255),  # RGB triplet with max specified
        boxwex = 0.5,  # Width of box as proportion of original
        whisklty = 1,  # Whisker line type; 1 = solid line
        staplelty = 0,  # Staple (line at end) type; 0 = none
        outpch = 16,  # Symbols for outliers; 16 = filled circle
        outcol = "slategray3",  # Color for outliers
        main = "Lawyers' Ratings of State Judges in the\nUS Superior Court (c. 1977)",
        xlab = "Lawyers' Ratings")

# Multiple boxplots
boxplot(USJudgeRatings,
        horizontal = TRUE,
        las = 1,  # Make all labels horizontal
        notch = TRUE,  # Notches for CI for median
        ylim = c(0, 10),  # Specify range on Y axis
        col = "slategray3",   # R's named colors (n = 657)
        boxwex = 0.5,  # Width of box as proportion of original
        whisklty = 1,  # Whisker line type; 1 = solid line
        staplelty = 0,  # Staple (line at end) type; 0 = none
        outpch = 16,  # Symbols for outliers; 16 = filled circle
        outcol = "slategray3",  # Color for outliers
        main = "Lawyers' Ratings of State Judges in the\nUS Superior Court (c. 1977)",
        xlab = "Lawyers' Ratings")

rm(list = ls())  # Clean up


# 
# Part #5
# Overlaying Plots
search()
# LOAD DATASET
require("datasets")
data()
?swiss
swiss
str(swiss)
class(swiss)
mode(swiss)
data(swiss)
View(swiss)
edit(swiss)
fix(swiss)
fertility <- swiss$Fertility
str(fertility)
class(fertility)
mode(fertility)

# PLOTS
# Plot 1: Histogram
h <- hist(fertility,
          prob = TRUE,  # Flipside of "freq = FALSE"
          ylim = c(0, 0.04),
          xlim = c(30, 100),
          breaks = 11,
          col = "#E5E5E5",
          border = 0,
          main = "Fertility for 47 French-Speaking\nSwiss Provinces, c. 1888")

?hist 
h
str(h)
?dnorm
# Plot 2: Normal curve (if prob = TRUE)
curve(dnorm(x, mean = mean(fertility), sd = sd(fertility)), 
      col = "red", 
      lwd = 3,
      add = TRUE)

# Plot 3 & 4: Kernel density lines (if prob = TRUE)
lines(density(fertility), col = "blue")
lines(density(fertility, adjust = 3), col = "darkgreen")

# Plot 5: Rug (That is, lineplot under histogram)
rug(fertility, col = "red")

rm(list = ls())  # Clean up


# 
# Part #6
# Exporting charts

# Load data
search()
load("datasets")
require("datasets")
data()
data("chickwts")
str(chickwts)
chickwts
View(chickwts)
feeds <- table(chickwts$feed)
feeds

# The hard way: Via R's code

# For PNG file (Run entire block at once)
png(filename= "C:/work/Tutorial02a.png",  # Open device
    width = 888,
    height = 571)
par(oma = c(1, 1, 1, 1))  # Outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)],  # Create the chart
        horiz  = TRUE,
        las    = 1,  # Orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",
        xlab   = "Number of Chicks")
dev.off()  # Close device (run in same block)

# OR this one for PDF file (Run entire block at once)
pdf("C:/work/Tutorial02a.pdf",
    width = 9,
    height = 6)
par(oma = c(1, 1, 1, 1))  # Outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)],  # Create the chart
        horiz  = TRUE,
        las    = 1,  # Orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",
        xlab   = "Number of Chicks")
dev.off()  # Close device (run in same block)

# The easy Way: With RStudio "Export"

par(oma = c(1, 1, 1, 1))  # Outside margins: b, l, t, r
par(mar = c(4, 5, 2, 1))  # Sets plot margins
barplot(feeds[order(feeds)],  # Create the chart
        horiz  = TRUE,
        las    = 1,  # Orientation of axis labels
        col    = c("beige", "blanchedalmond", "bisque1", "bisque2", "bisque3", "bisque4"),
        border = NA,  # No borders on bars
        main   = "Frequencies of Different Feeds\nin chickwts Dataset",
        xlab   = "Number of Chicks")

rm(list = ls())  # Clean up






library(ggplot2)
library(tidyverse)
library(ggstatsplot)

data <- read.csv("longformat_data.csv")
# Assuming the data frame is named 'dat'
head(data)
dayone_dat <- subset(data,  Population %in% c("1(2month)", "2(coorgnov2023)", "3pop(day1)", "4(lonavala)"))

# Display the filtered data
head(dayone_dat)
View(dayone_dat)

dayone_dat <-dayone_dat %>%
  mutate(
    Population = case_when(
      Population == "1(2month)" ~ "PopIII",  # Group "1(2month)" and "1(8month)" as  populations 3 vinitha
      Population == "2(coorgnov2023)" ~ "PopI",  # "2(coorgnov2023)" as  populations I dephanbhat
      Population == "3pop(day1)" ~ "PopII",  # Group "3pop(day1)", "3pop(day2)", and "3pop(1month)" as  populations II
      Population == "4(lonavala)" ~ "PopIV",  # "4(lonavala)" as  populations IV
      TRUE ~  Population  # Keep other  populations unchanged
    )
  )
View(dayone_dat)

head(dayone_dat,1)

dayone_dat

# Define the variables

variables1 <- c("Emergence.time", "Time.spent.in.outer.area", "Time.spent.in.chamber.A", "Time.spent.in.front.of.the.gate")



# Loop through each variable and create a plot

for (x in variables1) {
  plot1 <- ggbetweenstats(
    data = dayone_dat,
    x = Population,
    y = !!sym(x),  # Use rlang::sym to refer to the variable name correctly
    type = "nonparametric",boxplot.args = list(width = 0)
  )
  
  # Print or save the plot
  print(plot1)
  
}

variables2 <- c("Crossing.the.center", "Vertical.movement", "Surfacing", "Chamber.switching")

for (x in variables2) {
  plot2 <- ggbetweenstats(
    data = dayone_dat,
    x = Population,
    y = x,  # Use rlang::sym to refer to the variable name correctly
    type = "nonparametric",boxplot.args = list(width = 0)
  )
  
  # Print or save the plot
  print(plot)
}

variables <- c("Emergence.time","Time.spent.in.outer.area","Time.spent.in.chamber.A" ,"Time.spent.in.front.of.the.gate", 
                "Crossing.the.center","Vertical.movement","Surfacing","Chamber.switching")

for (var in variables) {
  # Create a readable y-axis label by replacing '.' with a space
  y_label <- gsub("\\.", " ", var)
  
  plot1 <- ggbetweenstats(
    data = dayone_dat,
    x = Population,
    y = !!sym(var),  # Use rlang::sym to refer to the variable name correctly
    type = "nonparametric",
    boxplot.args = list(width = 0)
  ) +
    xlab("Populations")+
    ylab(y_label)  # Use ylab() correctly with the clean label
  
  # Print or save the plot
  print(plot1)
}











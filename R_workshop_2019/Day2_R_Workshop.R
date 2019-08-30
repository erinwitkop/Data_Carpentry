# Day 2 Intro to R workshop 

# Load tidyverse packages
library(tidyverse)

# Download data
download.file(url="https://raw.githubusercontent.com/erinroberts/Data_Carpentry/master/messy_data.csv",  
              destfile = "messy_data.csv")

messy_data <- read_csv("messy_data.csv")

# Inspect data
head(messy_data)

# View summary
summary(messy_data)
View(messy_data)

# Fix sex column 
unique(messy_data$sex) # view all sex options

# Use recode() to fix sex column
recode(messy_data$sex, "f"="F", "m"="M",
       "MALE"="M","FEMALE"="F")
messy_data$new_sex <- recode(messy_data$sex, "f"="F",
                         "m"="M",
                         "MALE"="M","FEMALE"="F")
head(messy_data)

# Separate genus and species into separate columns
separate(messy_data, species, 
         into = c("Genus","Species"),
         sep = " ") %>% head()
messy_data_separated <- separate(messy_data, species, 
                                 into = c("Genus","Species"),
                                 sep = " ")
# Spread out measurement
spread(messy_data_separated, measurement, value) %>% head()
messy_data_separated_spread <- 
  spread(messy_data_separated, measurement, value)

# Remove rare species 
species_counts <- messy_data_separated_spread %>%
  count(species_id) %>%
  filter(n >= 50)
View(species_counts)

messy_complete <- messy_data_separated_spread %>%
  drop_na() %>%
  filter(species_id %in% species_counts$species_id)

# Plotting data as a timeseries
# Plot number of counts for a genus in every year in our data

yearly_counts <- messy_complete %>%
  count(year, Genus)
View(yearly_counts)

# Scatterplot of genus counts for each year
ggplot(data=yearly_counts, mapping = aes(x=year, y=n)) + 
  geom_point()

ggplot(data=yearly_counts, mapping = aes(x=year, y=n,
  color = Genus, group=Genus)) + 
  geom_line()

# Plot the monthly counts for each genus as a timeseries, 
# with each genus as its own color

monthly_counts <- messy_complete %>% # put in correct name
  count(month, Genus)
head(monthly_counts)  

ggplot(monthly_counts, mapping = aes(x=month,
                                     y=n, color =Genus)) +
  geom_line()

# change month to a factor
ggplot(monthly_counts, 
       mapping = aes(x= as.factor(month),
       y=n, group = Genus, color = Genus)) +
  geom_line() +
  scale_x_discrete(labels=c("1"="Jan",
   "2"="Feb","3"="Mar", "4"="Apr", "5"="May",
   "6"="June","7"="July","8"="Aug","9"="Sept",
   "10"="Oct", "11"="Nov","12"="Dec"))


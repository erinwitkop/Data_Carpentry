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
monthly_counts_plot <- ggplot(monthly_counts, 
       mapping = aes(x= as.factor(month),
       y=n, group = Genus, color = Genus)) +
  geom_line() +
  scale_x_discrete(labels=c("1"="Jan",
   "2"="Feb","3"="Mar", "4"="Apr", "5"="May",
   "6"="June","7"="July","8"="Aug","9"="Sept",
   "10"="Oct", "11"="Nov","12"="Dec")) +
  xlab("Month") + ylab("Individuals in Each Genus") +
  theme_bw() +
  ggtitle("Montly counts for each Genus")
monthly_counts_plot

# Export plot
ggsave("monthly_counts_plot.png",
       monthly_counts_plot,
       width = 10, dpi = 300)

# Plotting continued
# Load tidyverse
library(tidyverse)

# Download raw data
download.file(url="https://ndownloader.figshare.com/files/2292169",
              destfile = "portal_data_joined.csv")

# Read in data
surveys <- read_csv('portal_data_joined.csv')

#Filter species with > 50 observations
common_species <- surveys %>%  count(species_id) %>% filter(n>50) %>% pull(species_id)

# Starting data = c('common_species_data','messy_complete')
# Filter all data down to just those common species
common_species_data  <- surveys %>% 
  drop_na() %>% 
  filter(species_id %in% common_species)

# Calculate mean weight by plot_type * species_id
common_species_data %>% group_by(plot_type,species_id) %>%
  summarize(mean_weight=mean(weight)) %>%
  spread(plot_type,value = mean_weight) %>% 
  View()

#Spread plot type into new columns
spread_weights <- common_species_data %>% group_by(plot_type,species_id) %>%
  summarize(mean_weight=mean(weight)) %>%
  spread(plot_type,value = mean_weight)

# Regather that data
gathered_weights <- gather(spread_weights,
                           key = "plot_type",
                           value = mean_weight,
                           -species_id) %>% View()

# Find most common species
common_species_data %>% count(species_id) %>% arrange(desc(n))

# Filter to DM species
most_common <- common_species_data %>% filter(species_id == "DM")

# Plot violin plot for weight by sex
ggplot(most_common,aes(x=sex,y=weight,group=sex)) +
  geom_violin() + 
  geom_jitter(alpha=0.2,aes(color=sex)) +
  theme_bw()

ggplot(common_species_data,aes(x=sex,y=weight,group=sex)) +
  geom_violin() + 
  geom_jitter(alpha=0.2,aes(color=sex)) +
  theme_bw() +
  facet_wrap(vars(species_id),scales = "free")


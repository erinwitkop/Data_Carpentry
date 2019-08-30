# Intro to R

?head()

# Download file
download.file(url="https://ndownloader.figshare.com/files/2292169", 
              destfile = "portal_data_joined.csv")

# Read csv into R 
read.csv("portal_data_joined.csv", header = TRUE)

surveys <- read.csv("portal_data_joined.csv", 
                    header = TRUE)
# View head
head(surveys)

View(surveys)

class(surveys)

# View structure and class
str(surveys) # viewing the structure

# View data summary 
summary(surveys)


ggplot(surveys, aes(x= weight, y=hindfoot_length)) + 
  geom_point()

surveys_plot <- ggplot(surveys, aes(x=weight,
                                    y=hindfoot_length))

surveys_plot + geom_point()

surveys_plot + geom_point(color = "purple")

# Plot challenge 1
calculate mean hindfoot_length and then plot
it by plot_type

challenge1_group <- surveys %>%
  drop_na() %>%
  group_by(plot_type) %>%
  summarize(mean_hindfoot_length = mean(hindfoot_length))

ggplot(challenge1_group, aes(x=plot_type, 
 y = mean_hindfoot_length, 
 color=plot_type)) +
  geom_point()

# Surveys plot 

surveys_plot + geom_point(color = "purple") +
  xlab("Weight (g)") + ylab("Hindfoot Length (cm)") + 
  ggtitle("Hindfoot Length by Weight")

# Set surveys plot color by plot_type
ggplot(surveys, aes(x=weight, y = hindfoot_length,
                    color = plot_type)) +
  geom_point() 

# Add x and y axis labels and a plot title 
  # to the above graph


# Make a boxplot 
ggplot(surveys, aes(x=plot_type,y=weight )) + 
  geom_boxplot()

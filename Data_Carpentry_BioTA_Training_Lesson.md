Lesson Plan for Bio TA R Training
=================================

Details:

-   Time: Thursday 1-5 and Friday 8:30-12 - lunch will be served both
    days at 12.
-   Audience: future Intro Bio TA's
-   Experience Level: Novice
-   Location: pharmacy 240

Agenda
======

1.  Introduction: Code of Conduct, Etherpad, sticky notes
2.  Brief introduction to Ecology Dataset
3.  Basics of R
4.  Manipulating Ecology Dataset in R with dplyr
5.  Plotting dataset in R
6.  Loading Messy data into R

Agenda by Time
==============

Day 1: 1-5 12:45: help people load R and troubleshot

1:00-1:30: Intro to us and the idea of R (Erin) 1:30-2:00: Basics of R
(Erin) and data loading 2:00-3:00: tidyverse and playing with data
3:00-5:00: working with data in ggplot

Day 2: 8:00-10:00: Loading in messy data and basic plot 10:15-12:00:
Basic stats, two join

Introduction
============

1.  Introduce Myself and Bob

I am starting the fourth year of my PhD and my research focuses on
disease, genetics and immunology and oysters, focusing on genes involved
in disease resistance. I use R extensively in my research for data
analysis.

1.  Data Carpentries code of conduct

In order to foster a positive and professional learning environment we
encourage the following kinds of behaviors in all platforms and events:

-   Use welcoming and inclusive language
-   Be respectful of different viewpoints and experiences
-   Gracefully accept constructive criticism
-   Focus on what is best for the community
-   Show courtesy and respect towards other community members

1.  Intro to the Etherpad we will be using for posting questions,
    comments, ideas

-   HTML for the Etherpad:
    <https://pad.carpentries.org/RTraining_URI_08292019>

1.  Intro to the sticky notes you will receive.

Please put your red sticky note on top of your computer if you have an
issue and a helper will come around. Please put up the green sticky note
when you have completed a task or are ready to move on.

1.  Introduction around the room for participants.

-   Who are you and why are you taking this workshop?
-   Where do you hope to apply the skills learned?

Introduction to Ecology Dataset
===============================

We will be working from the Ecology Data Carpentry Lesson. The material
is available later for your use at the Data Carpentry website.
<https://datacarpentry.org/R-ecology-lesson/index.html>.

Data files for the lesson are available and can be downloaded manually
here: <https://doi.org/10.6084/m9.figshare.1314459>

However, we will download them directly from R during the lessons when
we need them.

Basics of R
===========

R and R Studio Basics
---------------------

Before we start, please have both R and RStudio both downloaded and
installed on your computer -Download R <https://cran.cnr.berkeley.edu>
-Download RStudio <https://www.rstudio.com/products/rstudio/download/>.
Download the free RStudio Desktop.

1.  What is "R"? The term “R” is used to refer to both the programming
    language and the software that interprets the scripts written using
    it. RStudio is currently a very popular way to not only write your R
    scripts but also to interact with the R software. To function
    correctly, RStudio needs R and therefore both need to be installed
    on your computer.

2.  Why Learn R?

-   Critical for allowing reproducibility
-   Working with scripts makes analysis clear
-   R is interdisciplinary
-   R works with data of all shapes and sizes
-   R is free, open source and cross platform

1.  R Studio Interface:

RStudio is divided into 4 “Panes”: a. Source for your scripts and
documents (top-left). This is where you will type your scripts. b.
Environment/History (top-right). This is where you see the data objects
you have loaded or created. It is "clickable" and you can see the type
of data that you have. c. Files/Plots/Packages/Help/Viewer
(bottom-right) c. R Console (bottom-left). This

1.  Setting up a new project

It is good practice to keep related data, analyses, and scripts in a
single folder called a working directory. Scripts in this folder use
"relative paths" which refer to the location that the files are housed
in.

R Studio uses a "project" interface. Rstudio can create a new project
directory for you, or you can work out of an existing directory.

Lets make a new project for this lesson. - To do this go to File &gt;
New Project. &gt; Choose New Directory &gt; Choose New Project. - Enter
a name for this new folder (or “directory”), and choose a convenient
location for it. This will be your working directory for the rest of the
day (e.g., ~/data-carpentry). - Click on Create Project. - Create a new
R script by going to File &gt; New File &gt; R script

1.  Finding help and troubleshooting

When you are unsure of how a function works you can type the following
in the context.

    ?head()

When you get an error message you are unsure how to interpret it, start
by googling the issue. There are several online platforms for code
developers, like stackoverflow.com

#### Load files into R

We can download the file directly from the internet using the following
function.

    download.file(url="https://ndownloader.figshare.com/files/2292169", # need to make sure you're on the URI secure!
                  destfile = "portal_data_joined.csv")

The data can now be loaded using the `read.csv` function.

    # Use the read.csv function to load in data with comma separated values
    # Use this as an example to introduce how to save things as a variable 

    # Use this as an opportunity to explain why we comment out code for each new command we do 
    read.csv("portal_data_joined.csv", header =TRUE) # setting header=TRUE will conserve your column names from your CSV

    surveys <- read.csv("portal_data_joined.csv", header =TRUE) # setting header=TRUE will conserve your column names from your CSV

Our surveys object is a class of data structure called a data frame. A
data frame is the typical data structure used in data manipulation for
plotting and statistics. Dplyr and tidyr are designed for efficient use
with data frames.

A data frame is the representation of data in the format of a table
where the columns are vectors that all have the same length. Because
columns are vectors, each column must contain a single type of data
(e.g., characters, integers, factors). For example, here is a figure
depicting a data frame comprising a numeric, a character, and a logical
vector.

To view what the beginning of the file look like, we can use the
function `head()`

    # take the head of surveys 
    head(surveys)

Take some time now to view the dataset. To work with the data we need to
know what it looks like and think about how this was taken:

First observations: - We have several columns, record\_id, month, day,
year , species\_id, sex, hindfoot\_lenght, eight, genus, species, taxa,
plot\_type - What is our main numerical data points? Hindfoot length,
weight, - We can deduce that in this experiment, data for species
hindfoot length was recorded daily for both males and females across
several different plot types - To visualize this I'll draw a picture: -
We have several different plot types, each with different plot IDs :
"Control" "Long-term Krat Exclosure" "Rodent Exclosure" "Short-term Krat
Exclosure" "Spectab exclosure" - Every day we go to the plot and we
sample rodents in the plot, and we record their hindfoot length, their
sex, and their weight -We observe in the data their are often NA's, and
there are several blankcs. This can be used in several situations, so
its important that when data is initally collected, particularly when
collected collaboratively, that you decide what NA versus a blank mean -
NA for weight could mean it was too large to weigh and the scale
wouldn't work, NA could mean you forgot to bring the scale,
hindfoot\_length NA could mean they ran away...whereas a blank could
mean someone just forgot to enter the data - Notice that we have month,
day, and year separated. This is very smart for loading data into R.
There are several different ways that people load dates, but splitting
it up now allows you to be better able to subset data later. - We also
observe that most columns have only numerical or only character data ,
while others have a mixture. -Taking note of what your data looks like
is critical.

To view the entire dataset in a tab, use the command `View`.

    View(surveys)

PAUSE: explore the data and talk about the missing values and ways we
might want to manipulate the data

To inspect the structure of our data we can use the `str()` function, or
the `class()` function.

    str(surveys)
    class(surveys)

We can also get a summary of our data set, including the length, class,
and content of each column using the `summary()` function.

    summary(surveys)

BREAK 1 : Switch to Bob
=======================

Manipulating Ecology Data Set
=============================

We are studying the species repartition and weight of animals caught in
plots in our study area. The dataset is stored as a comma separated
value (CSV) file. Each row holds information for a single animal.

Load packages
-------------

R has many, many functions that it can do already. However, developers
have created "packages" which contain groups of other specialized
functions. To be able to use these packages, they first have to be
installed and then loaded. To load a package you will load it as a
`library`. Today we will be using the `tidyr`, `dplyr`, `RSQLite`,
`ggplot2`, and `tibble` packages.

    # Install packages (always comment out your code using the hashtag to explain what a code chunk is doing)
    # Packages only need to be installed once
    #install.packages('tidyverse') #put object you will work on inside parentheses

    # Load libraries
    # Libraries need to be loaded every time you re-open your R session
    library(tidyverse)

    ## ── Attaching packages ────────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ───────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

Data Manipulation using `dplyr` and `tidyr`
===========================================

`dplyr` is a package for making tabular data manipulation easier. It
pairs nicely with tidyr which enables you to swiftly convert between
different data formats for plotting and analysis. Both `dplyr` and
`tidyr` are included in the tidyverse package.

Selecting columns and filtering rows
------------------------------------

To select columns of a data frame, use `select()`.

    select(surveys, plot_id, species_id, weight)

To select exclude particular columns, use a "-" symbol before the name
of the column.

    select(surveys, -record_id, -species_id) # record_id and species_id will be excluded

To filter rows based on specific criteria use `filter()`.

    filter(surveys, year ==1995)

Challenge 1
-----------

    # Select species_id, year, and month

    species_id_year <- select(surveys, species_id, year, month) 

    # filter for all years except 2000 (lets say maybe there was a major weather event)

    filter(species_id_year, year !=2000)

    # filter only data from may
    filter(species_id_year, month==5)

Pipes
-----

Can you select and filter at the same time? Yes! This can be done best
via the using of piping, or when you pass the results of one command
directly into another command without stopping to save it as a data
frame. In dplyr pipes look like this: `%>%`.

For example if we wanted to filter animals weighing less than 5 g, and
only wanted to see the species\_id, sex, and weight data we could do the
following.

    surveys %>%   # note the pipe has to be on the first line for R to know to pipe to the next line
      filter(weight < 5) %>%
      select(species_id, sex, weight)

The pipe sends the full surveys data set to our filter, so that only
rows with animals who weigh less than 5 g get passed to our final
command which only selects three columns.

To save the output of this filter and select, we can save it to a new
data frame with a different name. Note, if you save new data to an
existing data frame, it will replace the existing data and what was
saved previously will be lost. Create a new data frame if you would like
the original data to stay untouched.

    surveys_sml <- surveys %>% 
        filter(weight < 5) %>%
        select(species_id,sex,weight)

Now we can introduce several very useful functions for working with
pipes

`group_by()` and `summarize()`
------------------------------

Now we can create groups of data and then perform a function only on a
group of data.

    # To see hindfoot_length by species
    surveys %>% 
      group_by(species_id) %>%
      summarize(mean = mean(hindfoot_length)) # the mean is just all NA's, mean returns NA if there are NA's in the data set

    ## # A tibble: 48 x 2
    ##    species_id  mean
    ##    <fct>      <dbl>
    ##  1 AB            NA
    ##  2 AH            NA
    ##  3 AS            NA
    ##  4 BA            NA
    ##  5 CB            NA
    ##  6 CM            NA
    ##  7 CQ            NA
    ##  8 CS            NA
    ##  9 CT            NA
    ## 10 CU            NA
    ## # … with 38 more rows

    # now we fix by addin in a filter
    surveys %>% 
      filter(!is.na(hindfoot_length)) %>%
      group_by(species_id) %>%
      summarize(mean = mean(hindfoot_length))

    ## # A tibble: 25 x 2
    ##    species_id  mean
    ##    <fct>      <dbl>
    ##  1 AH          33  
    ##  2 BA          13  
    ##  3 DM          36.0
    ##  4 DO          35.6
    ##  5 DS          49.9
    ##  6 NL          32.3
    ##  7 OL          20.5
    ##  8 OT          20.3
    ##  9 OX          19.1
    ## 10 PB          26.1
    ## # … with 15 more rows

Challenge 2
-----------

    # Filter out missing data in the sex column and find the maximum hindfoot lenght in each sex

    surveys

Mutate
------

Often we will want to create new columns based on values in existing
columns. To do this we can use the `mutate()` function.

To create a new column of weight in kg

    surveys %>%
      mutate(weight_kg = weight/1000) 
    # in the mutate function, you first give it the name of the new column you want to create and set it equal to the action you want to perform (i.e. divide by 1000)

You can also create a new column based on the first new column in the
same column of mutate.

    surveys %>% 
      mutate(weight_kg = weight/1000,
      weight_kg2 = weight_kg * 2)

Several of the columns include `NA`s. These are input automatically into
your dataframe where there is missing data. You can include a filter to
get rid of rows with NA's for the weight column using the `is.na()`
function.

    surveys %>% 
      filter(!is.na(weight)) %>% # the exclamation point means "not"
      mutate(weight_kg = weight/1000) %>% 
      head() # piping to head will only print out the beginning of the output 

The `is.na()` function determines when something is an `NA`. The `!`
negates the result, so we're asking for every row where weight is not an
`NA`.

Challenge
---------

Create new data frame from the `surveys` data that contains only the
`species_id` column and a new column you make called `hindfoot_half`
containing values that are half the `hindfoot_length` value. In the new
`hindfoot_half` column make sure there are no `NA`s and that all values
are less than 30.

    surveys_hindfoot_half <- surveys %>% 
      filter(!is.na(hindfoot_length)) %>%
      mutate(hindfoot_half = hindfoot_length /2) %>%
      filter(hindfoot_half < 30) %>%
      select(species_id, hindfoot_half)

#### Split-apply-combine analysis and the summarize() function

Many analyses use a *split-apply-combine* approach, where you first
split the data into groups, then perform a set of analysis steps, and
then combine the results. `dplyr` makes this easy using the
`summarize()` function.

`summarize()` function
----------------------

The `summarize()` function combines groups of data into a single-row
summary of that group. It is often used following `group_by()` which
takes as arguments column names that contain **categorical** variables
for which you want to calculate summary statistics.

For example, to compute mean `weight` by sex:

    surveys %>% 
      group_by(sex) %>%
      summarize(mean_weight = mean(weight, na.rm =TRUE))

Multiple columns of categorical values can be grouped at once using the
`group_by()` function. Additionally, the `summarize()` function can also
summarize multiple variables at once. For example, if we wanted to ger
rid of any `NA`s in the data, group our data both by sex and species id,
and then calculate the mean weight and the minimum weight, we could do
the following.

    surveys %>%
      filter(!is.na(weight)) %>%
      group_by(sex, species_id) %>%
      summarize(mean_weight = mean(weight), 
                min_weight = min(weight))

Sometimes we want the output of a function to be arranged in a
particular order. We can do this using the `arrange()` function at the
end of our data. For example, we can arrange our data in descending
order using the following:

    surveys  %>%
       filter(!is.na(weight)) %>%
      group_by(sex, species_id) %>%
      summarize(mean_weight = mean(weight),
                min_weight = min(weight)) %>%
      arrange(desc(mean_weight))

Counting
--------

When we work with data, we often want to know how many observations are
in a particular group. We can do this with the `dplyr` function
`count()`. If we wanted to count the number of rows for each sex, we
could use the following function.

    surveys %>%
      count(sex)

What other function have we learned could be used to do the same thing?
Combining the `group_by()` function and the `summarize()` function.

    surveys %>%
      group_by(sex) %>%
      summarize(count = n()) # the n function counts the number of items

Just like `group_by()`, we can `count()` using multiple variables, also
arrange the output.

    surveys %>% 
      count(sex, species_id) %>%
      arrange(species_id, desc(n))

Exporting data
==============

In preparation for our next lesson on plotting, we are going to prepare
a cleaned up version of the data set that doesn’t include any missing
data.

    surveys_complete <- surveys %>%
      filter(!is.na(weight),           # remove missing weight
             !is.na(hindfoot_length),  # remove missing hindfoot_length
             !is.na(sex))                # remove missing sex

Now we are going to remove observations for rare species so we can plot
how species abundances change through time.

    ## Extract the most common species_id
    species_counts <- surveys_complete %>%
        count(species_id) %>% 
        filter(n >= 50)

    ## Only keep the most common species
    surveys_complete <- surveys_complete %>%
      filter(species_id %in% species_counts$species_id)

To check that everyone has the same data, check that `surveys_complete`
has 30463 rows and 13 columns by typing `dim(surveys_complete)`.

To export this data, we can use the `read.csv()` function.

    write.csv(surveys_complete, file ="surveys_complete.csv") # use the file = to name the file and set the path to the file

BREAK 2 Switch to Erin
======================

Visualizing Data
================

Now we will discuss how to visualize our dataset using a very popular
package called `ggplot2`. In this section we will be creating boxplots,
scatterplots, and timeseries plots. We'll describe what faceting is and
how to use it in `ggplot2`, and also manipulate the aesthetics of plots.

The `ggplot2` package is included in the `tidyverse` package which we
already loaded, so we don't need to load it again.

How does ggplot2 work?

-   Plots in ggplot are built in a step-by-step process. You start with
    giving it the data, then you add levels of graphics on top of it.
    From there you keep adding layers to customize the plot. This allows
    for increased flexibility.

To build a basic ggplot plot, the following format is used
`ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()`

TASK: Make a plot of the relationship between animal weight and
hindfoot\_length.

Lets start with calling the data. We will be using our subset
`surveys_complete` dataset we created above.

Lets read in this new data to make sure we're all in the same plot

    ggplot(data=surveys_complete) # use this as an example of tab complete 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot1-1.png)

This command will generate the basic grid where your mapping will appear
when you set the mapping aesthetics.

Now, we will add in our aesthetics using the `aes()` function for
aesthetics

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/aes-1.png)

    # the aes() function defines the variables that will be used for plotting and how to present them, you can set color, x/y position, and size of plots in the aes() function. 
    # notice in the plot that the axes are named the same way that the variables you used for plotting are

See that still, we have no actual points added, but we have an x and y
axis that have labels and tick marks.

Next we are ready to plot our actual data by adding a "geom", which are
graphical representations of the data. There are a variety of geoms that
can be used.
`*`geom\_point()`for scatter plots, dot plots, etc.   *`geom\_boxplot()`for, well, boxplots!   *`geom\_line()`for trend lines, time series, etc.`

    # Add the geom by using a plus sign, and because we already set our mapping we don't need to include the mapping inside of geom_point
    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length))  + geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/geom-1.png)

    # Observations: all the points are black, so you can't tell which groups you have in the dataset 

Something we can do now is actually save our plot to a variable that you
can call it and easily add on different geoms or aesthetics using the
`+`.

    # To demonstrate this, we can save the basic mapping of our plot to a new variable, called surveys_plot
    surveys_plot <- ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length))  

    # Now we can add to that object, any additional mapping we want
    surveys_plot + geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/save_geom-1.png)

Note that in a `ggplot` function when adding new layers using the `+`
symbol, the plus symbol needs to be at the end of the preceding line,
rather than on the next line. For example:

    # This will cause an error and will not work
    surveys_plot 
     + geom_point()

    # This is correct
    surveys_plot +
      geom_point() 

    # Why? You need to tell ggplot that you want it to read down to the next line for mapping. The computer won't know unless you tell it to read to the next line

### Plotting Challenge 1 (allow 5 minutes)

Goal: Plot average hindfoot\_length in each plot\_type

    # Perform two filters
    challenge1 <- surveys_complete %>%
      group_by(plot_type) %>%
      summarize(mean_hindfoot = mean(hindfoot_length))

    ggplot(challenge1, mapping = aes(x=plot_type, y = mean_hindfoot)) + geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot_challenge1-1.png)

Customizing plots
-----------------

This is not a very attractive plot at the moment. To make it better we
can a few customizations.

First we'll add colors by specifying with the `geom_point` call.

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) +
    geom_point(color = "blue") 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color-1.png)

    # This makes all the colors blue

#### Notes on colors in ggplot

Some notes about colors in ggplot. R has many base colors that it
recognizes in plain english ("yellow","green", "red"). But you can also
customize colors using hex codes, AKA HTML color codes. These are all
six digit codes for very specific colors. For now we will stick with
basic colors, but just know that there are options for really any
colors. There are also pre-made color pallettes through packages like
`RColorBrewer` that are premade and can help. There are also dedicated
pallettes for colorblind friendly colors. These are particularly useful
when presenting data to a large audience.

We can also set colors for specific variables. For example, to color
every species in the data differently we can do the following.

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) +
    geom_point(aes(color = species_id)) # we can add an extra aes inside the geom_point function 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color_diff-1.png)

Alternatively, colors can also be set inside the initial `aes()`
mapping:

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length, color = species_id)) +
    geom_point() 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color_diff2-1.png)

Now we observe that every species has its own color
===================================================

### Plotting Challenge 2

Now instead of wanting to plot every species, we want to plot by
plot\_type.

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length, color = plot_type)) +
    geom_point() 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot_type_challenge-1.png)

These plots are getting better, but we are still not close to something
you would want to put in a presentation or have a student turn in on a
lab report. One way we can get it there is by customizing the axis
labels and titles, which we can do rather easily in `ggplot2`.

### Change axis labels and add a title

    surveys_complete_color <- ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length, color = species_id)) +
    geom_point()

    # To get a title we add the function `ggtitle()`
    surveys_complete_color + ggtitle("Relationship between Hindfoot length and body weight by species") 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/title-1.png)

    # To change our axes title we can add on the `ylab()` and `xlab()` functions. 
    surveys_complete_color + ggtitle("Relationship between Hindfoot length and body weight by species") + 
      ylab("Hindfoot Length (cm)") + 
      xlab("Weight (g)")

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/title-2.png)

    # To change our legend title we can add a new argument with the `guides()` function
    surveys_complete_color + ggtitle("Relationship between Hindfoot length and body weight by species") + 
      ylab("Hindfoot Length (cm)") + 
      xlab("Weight (g)") + 
      guides(color=guide_legend(title = "Species ID"))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/title-3.png)

    #Change font size 
    surveys_complete_color + ggtitle("Relationship between Hindfoot length and body weight by species") + 
      ylab("Hindfoot Length (cm)") + 
      xlab("Weight (g)") + 
      guides(color=guide_legend(title = "Species ID")) +
      theme(axis.title = element_text(size=12,face="bold"),
            plot.title = element_text(size=14, face="bold")) 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/title-4.png)

### Plot Challenge 3

Go back to the plot we made for our first challenge and add appropriate
axes titles and a plot title

    ggplot(challenge1, mapping = aes(x=plot_type, y = mean_hindfoot)) + geom_point() + xlab("Plot Type") +
      ylab("Hindfoot Length (cm)") + ggtitle("Mean Hindfoot length in each plot type") +  guides(color=guide_legend(title = "Plot Type"))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/add_title-1.png)

Next we can move on to plotting with boxplots. These are useful because
they plot the median, max and min and the first and third quartiles of
your data,

Boxplots
--------

We can also use a boxplot to explore the distribution of weight within
species.

This time we'll be mapping with weight rather than `hindfoot_lenght`

    ggplot(data=surveys_complete, mapping = aes(x= species_id, y=weight)) +
    geom_boxplot()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot-1.png)

We can add points to our boxplot by using `geom_jitter` and setting the
`alpha` parameter, which makes the points a level of transparency
defined by the user. We can then set the color inside our `geom_jitter`.

    ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
        geom_boxplot() +
        geom_jitter() # geom_jitter is a geom that makes the points not overlap as much, but it's still pretty hard to see

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot_jitter-1.png)

    # to help make the plots easier to see, we will add another parameter into the geom_jitter which is the `alpha`. The alpha can make the points have a certain level of transparency. We can also add a color to the points inside our geom jitter
    ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
        geom_boxplot(alpha = 0) +
        geom_jitter(alpha = 0.3, color = "tomato")

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot_jitter-2.png)

### Plotting Challenge 4

Make a boxplot using the hindfoot\_lenght rather than the weight

    ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
        geom_boxplot(alpha = 0) +
        geom_jitter(alpha = 0.3, color = "tomato")

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot_hindfoot-1.png)

Bar chart example
-----------------

    ggplot(data = surveys_complete, mapping = aes(x = species_id, y = hindfoot_length)) +
        geom_col()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/barplot_hindfoot-1.png)

Time series data
----------------

With time series data our goal will now be to

Let’s calculate number of counts per year for each genus and plot type.
First we need to group the data and count records within each group:

    yearly_counts <- surveys_complete %>%
      count(year, genus)

We can try first to plot with years on the x axis and counts on the y
axis, with the goal of creating a line for genus.

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) + # our count column is called "n" now
         geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/time_series_plot-1.png)

Why does this not work? We haven't told R to group the data for genera
together, so it's plotting not with respect to the genera distinction.

1.  We need to tell ggplot to draw a line for each genus by using a new
    argument in the mapping aesthetic function called `group`. The
    `group` argument adds a grouping similar to the dplyr `group_by`
    function. In this case we will now include `group = genus`.

<!-- -->

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/group_genus-1.png)

To make this more interesting now, we can distinguish the different
genera in the plot by specifying the colors.

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = genus, group = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/line_color-1.png)

#### Plotting Challenge 4

Instead of grouping monthly counts by genus rather than yearly counts,
we are interested in and coloring by sex.

    monthly_counts <- surveys_complete %>%
      count(month, genus)
    ggplot(data = monthly_counts, mapping = aes(x = month, y = n, color = genus, group = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot_challenge_4-1.png)

    # Why don't the axes make sense? Because months are discrete factors, not continuous. To fix this we can add the following `as.factor()` function before the variable month
    ggplot(data = monthly_counts, mapping = aes(x = as.factor(month), y = n, color = genus, group = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot_challenge_4-2.png)

Changing axes tick marks
------------------------

As is in this challenge example, sometimes your data in the table is not
in the "pretty" format you would like it to be on a finished plot. The
functions `scale_x_discrete()` and `scale_y_discrete()` are used to
customize discrete x and y axis, respectively. The functions
`scale_x_continuous()` and `scale_y_continuous()` are used with
continuous data.

Today we will focus on changing the discrete x axis for months. Setting
continuous scales works very similarly however.

It is possible to use these functions to change the following x or y
axis parameters :

-   axis titles
-   axis limits (data range to display)
-   choose where tick marks appear
-   manually label tick marks

The simplified version of these is

`scale_x_discrete(name, breaks, labels, limits)`
`scale_y_discrete(name, breaks, labels, limits)`

What do each of the arguments do? - name : x or y axis labels - breaks :
control the breaks in the guide (axis ticks, grid lines, …). Among the
possible values, there are : - NULL : hide all breaks - waiver() : the
default break computation - a character or numeric vector specifying
which breaks to display - labels : labels of axis tick marks. Allowed
values are : - NULL for no labels - waiver() for the default labels -
character vector to be used for break labels - limits : a character
vector indicating the data range. *Limits* is also used to change the
order of items.

Now we would like to change the month labels on our discrete axis to be
something more readable.

    ggplot(data = monthly_counts, mapping = aes(x = as.factor(month), y = n, color = genus, group = genus)) +
        geom_line() + 
        scale_x_discrete(labels=c("1"="Jan","2"="Feb.", "3"="Mar", "4"="April","5"="May",
                                  "6"="June","7"="July","8"="Aug", "9"="Sept","10"="Oct","11"="Nov",
                                  "12"="Dec")) # explain c for concatenate 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/change_month-1.png)

Faceting
--------

Faceting is a special technique in `ggplot2` that allows users to split
one plot into several based on a factor of interest. There are two types
of faceting:

-   `facet_wrap()` arranges a one-dimensional sequence of panels to
    allow them to cleanly fit on one page.
-   `facet_grid()` allows you to form a matrix of rows and columns of
    panels.

For both, you specify the variables to facet by using the `vars()`
function. For example `facet_wrap(facets=vars(facet_variable))` or
`facet_grid(rows = vars(row_variable), cols = vars(col_variable))`.

We can make a time series plot for each species by using the following
facet.

    ggplot(data= yearly_counts, mapping = aes(x= year, y = n)) +
      geom_line() + 
      facet_wrap(facets = vars(genus))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/facet-1.png)

Now we want to split each plot by the sex of the animals. To do this we
make a counts plot grouped by `year`, `species_id`, and `sex`.

    yearly_sex_counts <- surveys_complete %>% 
      count(year, genus, sex) %>%
      filter(sex != "") # remove empty rows, this may not be necessary

Now we can plot a separate line for each sex using the `color` argument.

    ggplot(data= yearly_sex_counts, mapping = aes(x= year, y = n, color = sex)) +
      geom_line() + 
      facet_wrap(facets = vars(genus))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/facet_color-1.png)

Now we can use `facet_grid` to split the plots by sex and organize the
plots into rows and columns.

    ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color = sex)) +
      geom_line() +
      facet_grid(rows= vars(sex), cols= vars(genus))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/facet_grid-1.png)

END OF DAY 1
============

Fill out stickies with things that went well, things that you would like
to see more of.

DAY 2: Begin with Erin
======================

Importing and working with messy data
=====================================

Now we will learn about reshaping messy data, such as what you might
encounter during labs.

Often people will make data tables that are not formatted best for use
in R. So one of our first steps is reformatting the data in a "tidy" way
that is suitable for loading into R.

Two of the critical functions for doing this are `gather()` and
`spread()`.

Reshaping with gather and spread
--------------------------------

When using spreadsheets with R, we try to follow these 4 rules for
creating "tidy" data.

1.  Each variable has its own column
2.  Each observation has its own row
3.  Each value must have its own cell
4.  Each type of observational unit forms a table

Animation about gather and spread. In long format you have one row for
every observation, while in wide format the observations are condensed.

<https://github.com/gadenbuie/tidyexplain>

The `gather()` function takes wide data and gathers it into long format,
while `spread()` takes long data and spreads it into long, where several
variables are split up.

Spreading
---------

For example, if we were given a table where there was one genus column
that we wanted to split into a table where each genus had its own column
we would want to spread the data.

`spread()` takes three arguments: 1. The data 2. The key column variable
whose values will become new column names. 3. The value column variable
whose values will fill the new column variables.

Gathering
---------

For example, if we were given the opposite situation with a table where
there were multiple columns, one for each genus, and we wanted to
condense them into into one column, we would use the `gather()`
function. This function takes the following 4 arguments.

1.  The data
2.  The *key* column variable we wish to create from the column names
3.  The *values* column variable we wish to create and fill with values
    associated with they key.
4.  The names of the columns we use to fill the key variable

Our messy data
--------------

Now we can pull up our messy data table in Excel and take a look.

Some common problems we have when working on collaborative, long term
projects is that common conventions for how to record variables can get
lost.

Common issues: 1. Dates in non-uniform formatting (DD/MM/YY vs.
MM/DD/YYYY) 2. Capitalization and abbreviations ("male" vs "M") 3.
Different systems for recoring a lack of data (NA vs. missing vs. 0)

Though we can perform data cleaning in R, for a short data set we can
hand clean our data in excel. Please go through the data and fix all
issues you spot.

With our data fixed we load in our data set.

    messy_surveys_fixed <- read.csv("surveys_messier_fixed.csv", header=TRUE)
    head(messy_surveys_fixed)

    ##   X record_id month day year plot_id species_id sex weight   genus
    ## 1 1         1     7  16 1977       2         NL   M     NA Neotoma
    ## 2 2        72     8  19 1977       2         NL   M     NA Neotoma
    ## 3 3       224     9  13 1977       2         NL         NA Neotoma
    ## 4 4       266    10  16 1977       2         NL         NA Neotoma
    ## 5 5       349    11  12 1977       2         NL         NA Neotoma
    ## 6 6       363    11  12 1977       2         NL         NA Neotoma
    ##    species   taxa Control Long.term.Krat.Exclosure Rodent.Exclosure
    ## 1 albigula Rodent      32                       NA               NA
    ## 2 albigula Rodent      31                       NA               NA
    ## 3 albigula Rodent      NA                       NA               NA
    ## 4 albigula Rodent      NA                        1               NA
    ## 5 albigula Rodent      NA                       NA               NA
    ## 6 albigula Rodent      NA                       NA                3
    ##   Short.term.Krat.Exclosure Spectab.exclosure
    ## 1                        NA                NA
    ## 2                        NA                NA
    ## 3                        NA                NA
    ## 4                        NA                NA
    ## 5                        NA                NA
    ## 6                        NA                NA

Now we see that currently there are multiple columns for each plot type.
If we want to combine the plot types into a single column, we will need
to use the `gather()` function.

    messy_gathered <- messy_surveys_fixed %>% gather(key = plot_type, value = hindfoot_length, -c(plot_id, record_id, month, day, year, species_id, sex, weight, genus, species, taxa, X))

    # the key is the variable whose values are column names
    # the value is a variable whose values are currently spread (in our case the hind_foot_length data has been spread)
    # the final argument contains the columns to ignore while gathering

#### Steps to fix the new messy data

### Recode step

#### Using unique

unique(messy\_data$sex)

### Separate step for species

### Spread measurement back out with the value column

#### Code used to create messy data

surveys\_messy &lt;- spread(surveys, plot\_type, hindfoot\_length)
surveys\_messy &lt;- head(surveys\_messy, n=30)
write.csv(file="surveys\_messy.csv", surveys\_messy)

In excel I sprinkled in a few challenges that could occur when you have
when multiple people are recording data

Break 2: switch to Bob
======================

Advanced plotting with ggplot
=============================

Changing ggplot themes
----------------------

`ggplot2` has several preloaded themes that can be used to change the
appearance of plots. For example:

    ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color= sex)) +
      geom_line() +
      facet_wrap(vars(genus)) + 
      theme_bw()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/ggplot_theme-1.png)

Arranging and Exporting plots
-----------------------------

Faceting is great for splitting one plot into multiple, but you can also
combine multiple plots using the `gridExtra` package. This package
allows you to combine multiple plots into a single figure using
`grid.arrange()`.

    # install.packages("gridExtra")

    library(gridExtra)

    ## 
    ## Attaching package: 'gridExtra'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

    spp_weight_boxplot <- ggplot(data = surveys_complete, 
                                 mapping = aes(x = genus, y = weight)) +
      geom_boxplot() +
      xlab("Genus") + ylab("Weight (g)") +
      scale_y_log10() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))

    spp_count_plot <- ggplot(data = yearly_counts, 
                             mapping = aes(x = year, y = n, color = genus)) +
      geom_line() + 
      xlab("Year") + ylab("Abundance")

    grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6)) # set the ncol and width 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/install_grid-1.png)

You can also save your plots with ggsave

    combo_plot <- grid.arrange(spp_weight_boxplot, spp_count_plot, ncol = 2, widths = c(4, 6))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/export_plot-1.png)

    ggsave("combo_plot_abun_weight.png", combo_plot, width = 10, dpi = 300)

    ## Saving 10 x 5 in image

Note that the `width` and `height` parameters determine the font size
saved in the plot.

Basic stats
===========

### T tests and anova

### Doing a basic linear model and plotting it

Link together filtering, toy example

Google sheets data loading and fixing
=====================================

Advanced ggplot code for calculating and adding error bars to a graph after you calculate the error
===================================================================================================

Calculating a line and adding the line to a geom plot
=====================================================

Wrap-up
=======

To recap today we have gone over the following data analysis skills: 1.
R Basics 2. Basic data manipulation using `dplyr` and `tidyr` 3.
Visualizing data with `ggplot2`, exporting and arranging data 4.
Importing and working with messy data

For the sake of time, this lesson was created from the data carpentry R
Ecology lesson. Please visit this website for more detailed information.
<https://datacarpentry.org/R-ecology-lesson/03-dplyr.html#reshaping_with_gather_and_spread>

As you go, we really care about your feedback so if everyone could write
down one thing you thought went really well on their green sticky note,
and write down one thing that could be improved on their red sticky
note, and turn these in as you leave.

### Lesson Plan for Bio TA R Training

Details:

-   Time: Thursday 1-5 and Friday 8:30-12 - lunch will be served both
    days at 12.
-   Audience: future Intro Bio TA's
-   Experience Level: Novice

### Agenda

1.  Introduction: Code of Conduct, Etherpad, sticky notes
2.  Brief introduction to Ecology Dataset
3.  Basics of R
4.  Manipulating Ecology Dataset in R with dplyr
5.  Plotting dataset in R
6.  Loading Messy data into R

### Introduction

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

1.  Intro to the sticky notes you will receive.

Please put your red sticky note on top of your computer if you have an
issue and a helper will come around. Please put up the green sticky note
when you have completed a task or are ready to move on.

### Introduction to Ecology Dataset

We will be working from the Ecology Data Carpentry Lesson. The material
is available later for your use at the Data Carpentry website.
<https://datacarpentry.org/R-ecology-lesson/index.html>.

Data files for the lesson are available and can be downloaded manually
here: <https://doi.org/10.6084/m9.figshare.1314459>

However, we will download them directly from R during the lessons when
we need them.

### Basics of R

#### R and R Studio Basics

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

### Manipulating Ecology Data Set

We are studying the species repartition and weight of animals caught in
plots in our study area. The dataset is stored as a comma separated
value (CSV) file. Each row holds information for a single animal.

#### Load packages

R has many, many functions that it can do already. However, developers
have created "packages" which contain groups of other specialized
functions. To be able to use these packages, they first have to be
installed and then loaded. To load a package you will load it as a
`library`. Today we will be using the `tidyr`, `dplyr`, `RSQLite`,
`ggplot2`, and `tibble` packages.

    # Install packages (always comment out your code using the hashtag to explain what a code chunk is doing)
    # Packages only need to be installed once
    #install.packages('tidyverse') #put object you will work on inside parentheses
    #install.packages('RSQLite')
    #install.packages('ggplot2')
    #install.packages('tibble')

    # Load libraries
    # Libraries need to be loaded every time you re-open your R session
    library(tidyverse)

    ## ── Attaching packages ──────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ─────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    library(RSQLite)
    library(ggplot2)
    library(tibble)

We are now ready to use these packages.

#### Load files into R

We can download the file directly from the internet using the following
function.

    download.file(url="https://ndownloader.figshare.com/files/2292169",
                  destfile = "portal_data_joined.csv")

The data can now be loaded using the `read.csv` function.

    # Use the read.csv function to load in data with comma separated values
    surveys <- read.csv("portal_data_joined.csv", header =TRUE) # setting header=TRUE will conserve your column names from your CSV

To view what the beginning of the file look like, we can use the
function `head()`

    head(surveys)

To view the entire dataset in a tab, use the command `View`.

    View(surveys)

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

To inspect the structure of our data we can use the `str()` function, or
the `class()` function.

    str(surveys)
    class(surveys)

We can also get a summary of our data set, including the length, class,
and content of each column using the `summary()` function.

    summary(surveys)

### Data Manipulation using `dplyr` and `tidyr`

`dplyr` is a package for making tabular data manipulation easier. It
pairs nicely with tidyr which enables you to swiftly convert between
different data formats for plotting and analysis. Both `dplyr` and
`tidyr` are included in the tidyverse package.

#### Selecting columns and filtering rows

To select columns of a data frame, use `select()`.

    select(surveys, plot_id, species_id, weight)

To select exclude particular columns, use a "-" symbol before the name
of the column.

    select(surveys, -record_id, -species_id) # record_id and species_id will be excluded

To filter rows based on specific criteria use `filter()`.

    filter(surveys, year ==1995)

#### Pipes

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

#### Mutate

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

#### Challenge

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

##### `summarize()` function

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

##### Counting

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

### Exporting data

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

### Visualizing Data

Now we will discuss how to visualize our dataset using a very popular
package called `ggplot2`. In this section we will be creating boxplots,
scatterplots, and timeseries plots. We'll describe what faceting is and
how to use it in `ggplot2`, and also manipulate the aesthetics of plots.

The `ggplot2` package is included in the `tidyverse` package which we
already loaded, so we don't need to load it again.

`ggplot2` likes for data to be "long" format (rather than "wide"
format), which means there is a column for every dimension and a row for
each observation. In the next section of the lesson we will discuss how
to change wide data to long format for use in plotting.

Plots in ggplot are built in a step-by-step process, where you add
graphics in different layers to customize the plot. This allows for
increased flexibility.

To build a basic ggplot plot, the following format is used
`ggplot(data = <DATA>, mapping = aes(<MAPPINGS>)) +  <GEOM_FUNCTION>()`

Lets start with calling the data. We will be using our subset
`surveys_complete` dataset we created above.

    ggplot(data=surveys_complete)

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/plot1-1.png)

This command will generate the basic grid where your mapping will appear
when you set the mapping aesthetics.

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) 

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/aes-1.png)

    # the aes() function defines the variables that will be used for plotting and how to present them, you can set color, x/y position, and size of plots in the aes() function. 

Next we are ready to plot our actual data by adding a "geom", which are
graphical representations of the data. There are a variety of geoms that
can be used.
`*`geom\_point()`for scatter plots, dot plots, etc.   *`geom\_boxplot()`for, well, boxplots!   *`geom\_line()`for trend lines, time series, etc.`

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length))  + geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/geom-1.png)

You can also save the basic aesthetics of a plot to a variable that you
can call and then add different geoms or aspects to it using `+`.

    surveys_plot <- ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length))  
    surveys_plot + geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/save_geom-1.png)

Note that in a `ggplot` function when adding new layers using the `+`
symbol, the plus symbol needs to be at the end of the preceding line,
rather than on the next line. For example:

    # This is correct
    surveys_plot +
      geom_point() 

    # This will cause an error and will not work
    surveys_plot 
     + geom_point()

##### Customizing plots

We can add colors within the `geom_point` call.

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) +
    geom_point(color = "blue")

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color-1.png)

We can also color every species in the data differently by doing the
following:

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length)) +
    geom_point(aes(color = species_id))

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color_diff-1.png)

Colors can also be set inside the initial `aes()` mapping:

    ggplot(data=surveys_complete, mapping = aes(x= weight, y=hindfoot_length, color = species_id)) +
    geom_point()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/color_diff2-1.png)

##### Boxplots

We can also use a boxplot to explore the distribution of weight within
species.

    ggplot(data=surveys_complete, mapping = aes(x= species_id, y=weight)) +
    geom_boxplot()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot-1.png)

We can add points to our boxplot by using `geom_jitter` and setting the
`alpha` parameter, which makes the points a level of transparency
defined by the user. We can then set the color inside our `geom_jitter`.

    ggplot(data = surveys_complete, mapping = aes(x = species_id, y = weight)) +
        geom_boxplot(alpha = 0) +
        geom_jitter(alpha = 0.3, color = "tomato")

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/boxplot_jitter-1.png)

#### Time series data

Let’s calculate number of counts per year for each genus. First we need
to group the data and count records within each group:

    yearly_counts <- surveys_complete %>%
      count(year, genus)

Time series data can be visualized as a line plot with years on the x
axis and counts on the y axis:

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n)) +
         geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/time_series_plot-1.png)

Unfortunately, this does not work because we plotted data for all the
genera together. We need to tell ggplot to draw a line for each genus by
modifying the aesthetic function to include `group = genus`.

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n, group = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/group_genus-1.png)

We can distinguish the different genera in the plot by specifying the
colors.

    ggplot(data = yearly_counts, mapping = aes(x = year, y = n, color = genus)) +
        geom_line()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/line_color-1.png)

##### Faceting

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

-   Skipping code regarding old syntax

#### Changing ggplot themes

`ggplot2` has several preloaded themes that can be used to change the
appearance of plots. For example:

    ggplot(data = yearly_sex_counts, mapping = aes(x = year, y = n, color= sex)) +
      geom_line() +
      facet_wrap(vars(genus)) + 
      theme_bw()

![](Data_Carpentry_BioTA_Training_Lesson_files/figure-markdown_strict/ggplot_theme-1.png)

#### Arranging and Exporting plots

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

### Importing and working with messy data

Now we will learn about reshaping messy data, such as what you might
encounter during labs.

#### Code used to create messy data

surveys\_messy &lt;- spread(surveys, plot\_type, hindfoot\_length)
surveys\_messy &lt;- head(surveys\_messy, n=30)
write.csv(file="surveys\_messy.csv", surveys\_messy) \# In excel I
sprinkled in a few challenges that could occur when you have \# multiple
people recording data

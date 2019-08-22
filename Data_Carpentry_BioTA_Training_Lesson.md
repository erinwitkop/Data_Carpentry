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
`library`. Today we will be using the `tidyverse` and `RSQLite`
packages.

    # Install packages (always comment out your code using the hashtag to explain what a code chunk is doing)
    # Packages only need to be installed once
    #install.packages(tidyverse) #put object you will work on inside parentheses
    #install.packages(RSQLite)


    # Load libraries
    # Libraries need to be loaded every time you re-open your R session
    library(tidyverse)

    ## ── Attaching packages ───────────────────────────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.2.1     ✔ purrr   0.3.2
    ## ✔ tibble  2.1.3     ✔ dplyr   0.8.3
    ## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
    ## ✔ readr   1.3.1     ✔ forcats 0.4.0

    ## ── Conflicts ──────────────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

    library(RSQLite)

We are now ready to use these packages.

#### Load files into R

We can download the file directly from the internet using the following
function.

    download.file(url="https://ndownloader.figshare.com/files/2292169",
                  destfile = "portal_data_joined.csv")

The data can now be loaded using the `read.csv` function.

    surveys <- read.csv("portal_data_joined.csv")

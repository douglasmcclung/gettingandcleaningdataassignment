# Getting and Cleaning Data Course Project

Scripts and data sets for the Getting and Cleaning Data Course's Project.  

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

```
Download and unzip the raw data files found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  
Save the unzipped files to a sub-directory or your R Studio working directory named UCI HAR Dataset.
```

## Running the script

Open the run_analysis.R script in R Studio.  Run the script.  

### What the script does

```
Merges the various Test data sets together (Activity, Subject and Results)
```
```
Merges the various Train data sets together (Activity, Subject and Results)
```
```
Merges the resulting Test and Train data sets into one set
```
```
Updates labels and variable names to their "english" equivalent
```
```
Calculates avg and std. deviation by activity and subject
```


## Built With

* [dplyr](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf)

## Authors

* **Doug McClung** - *Initial work* - [DouglasMcClung](https://github.com/douglasmcclung/gettingandcleaningdataassignment/edit/master/README.md)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details


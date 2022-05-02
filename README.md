# mcp_s-age_pipeline
This repository contains the source code for our paper:

> Stull, K.E., Chu, E.Y., Corron, L.K., & Price, M.H. (2021). *The Mixed Cumulative Probit: A multivariate generalization of transition analysis that accommodates variation in the shape, spread, and structure of data.* In review.  

<!-- Our pre-print is online here: -->

<!-- > Authors, (YYYY). _`r Title`_. Name of journal/book, Accessed `r format(Sys.Date(), "%d %b %Y")`. Online at <https://doi.org/xxx/xxx> -->


### How to cite

Please cite this compendium as:

> K.E. Stull, E.Y. Chu, L. Corron,  and M.H. Price, (2021). Compendium of R code and data for *The Mixed Cumulative Probit: A multivariate generalization of transition analysis that accommodates variation in the shape, spread, and structure of data.*. Accessed *Current Date*.

# Setup
This research compendium has been developed using the statistical programming language R. To work with the compendium, you will need the [R software](https://cloud.r-project.org/) itself and optionally [RStudio Desktop](https://rstudio.com/products/rstudio/download/). If you only have R and do not have RStudio, you will additionally have to install [Pandoc](https://pandoc.org/installing.html).

Below, we provide directions for [running the analyses using a Docker image](#Docker). One advantage of using Docker is that R's parallel processing libraries do not use forking on Windows, so running inside a Linux Docker container on Windows usually yields a much faster runtime for the multivariate optimization. *Due to the different ways in which result replication methods, such as using* `set.seed()`*, are initialized between operating systems, the only true way to replicate the results of this publication are to run the analyses in Docker.*

* The source code for this research compendium relies heavily on the R package `yada`, which can be found at the following **GitHub Repository**: https://github.com/MichaelHoltonPrice/yada. 

* Full documentation of each of the functions used for *MCP algorithm optimization* are available via an [HTML Vignette](https://github.com/MichaelHoltonPrice/yada/tree/dev/inst/doc/yada_vignette.html)   

* In the event that you would like to [Clone this Repository](#Clone) to follow the vignette using the same data, please refer to the instructions provided at the end of the README.

# Running the analyses using Docker  {#Docker}
Docker provides an appealing framework for running reproducible scientific analyses that we hope will see greater use in the future. We have provided a [Dockerfile](Dockerfile) that defines a Docker image which can be used to run all our publication analyses.

First, [install Docker](https://docs.docker.com/engine/install/) and ensure that it is available on the terminal/command line path.

Second, clone this repository using git (these directions assume use of the terminal/command line, but see above for how to download the directory directly using git) and change directory (cd) into the base of the repository.

```console
git clone https://github.com/ElaineYChu/mcp_s-age_pipeline
cd mcp_s-age_pipeline
```

Third, run the following command at the terminal to build the Docker image. To force all docker material to be (re)downloaded prior to creating the Docker image -- a step you should be certain you want to take -- use: "docker system prune -a".

```console
docker build -t michaelholtonprice/mcp_s-age_pipeline .
```

This will create a Linux image (Ubuntu 20.04), install R, install necessary dependencies, copy data and script files into the Docker image, and install R using the script install_yada.R that is part of this repository (specifically, commit b16034db9d81e59642ffda029ade8f91df669846 of yada is installed).

Fourth, start a Docker container with the following command:

```console
docker run --name mcp_s-age_pipeline -itv //c/mcp_s-age_pipeline_mirrored_dir:/mirrored_dir michaelholtonprice/mcp_s-age_pipeline
```

The preceding command places the user at a command line "inside" the Docker container. The -v tag in the command mirrors a directory on the host machine (C:\\mcp_s-age_pipeline_mirrored_dir) to a directory inside the Docker container (/mirrored_dir) that can be used to pass files between the host machine and the Docker container. The directory to the left of the semicolon is for the host machine and the directory to the right of the semicolon is for the Docker container. The path for the host machine may need to be modified for your situation.

Fifth, change directory (cd) into mcp_s-age_pipeline (where files were copied during creation of the Docker image; see the Dockerfile) and run all the analysis scripts:

```console
cd mcp_s-age_pipeline
Rscript run_all_analyses.R
```

Sixth and finally, copy the results to the mirrored directory:

```console
cp -fr ./results /mirrored_dir
```
# Cloning the Repository  {#Clone}
Cloning this repository means that you copy all files and scripts to your local system (*e.g.* laptop, desktop, server). There are two ways to achieve this goal:  

1. If you are using a Mac operating system or have another shell terminal system (such as [Git for Windows](https://gitforwindows.org/)), open your terminal and enter the following commands:

```console
cd "file/path/to/desired/repository/location"
git clone https://github.com/ElaineYChu/mcp_s-age_pipeline
cd mcp_s-age_pipeline
ls
```
These four lines of code will a) set the location where you want to save the repository, b) clone the repository, c) enter the newly-created directory, and d) list its contents.  

2. If you do not have or are unfamiliar with terminal command systems, you may also locate and click on the green button in this repository labeled "Code" with a downward arrow and select "Download ZIP." This will download a zipped file to your local system (probably found in your *Downloads* folder). Extract the embedded folder ("mcp_s-age_pipeline-main") and relocate it to your desired folder location. **From the folder, you can extract the data files to run the pipeline supplied by the [vignette](https://github.com/MichaelHoltonPrice/yada/tree/dev/inst/doc/yada_vignette.html) on your local system.**



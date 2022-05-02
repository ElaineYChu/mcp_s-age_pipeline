# The following two commands can be used to build the Docker image and start a
# container. The -v tag mirrors a folder on the host machine with the
# /mirrored_dir folder in the Docker container.
#
# docker build -t michaelholtonprice/mcp_s-age_pipeline .
# docker run --name mcp_s-age_pipeline -itv //c/mcp_s-age_pipeline_mirrored_dir:/mirrored_dir michaelholtonprice/mcp_s-age_pipeline
#
# If desired, the following command starts a container without mirroring a
# directory on the host machine:
#
# docker run --name mcp_s-age_pipeline -it michaelholtonprice/mcp_s-age_pipeline
FROM ubuntu:20.04

# Set the following environmental variable to avoid interactively setting the
# timezone with tzdata when installing R
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y git && \
    apt-get install -y apt-transport-https && \
    apt-get install -y software-properties-common && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/' && \
    apt-get update && \
    apt-get install -y r-base && \
    apt-get install -y libcurl4-openssl-dev && \
    apt-get install -y libssl-dev && \
    apt-get install -y libxml2-dev && \
    apt-get install -y pandoc && \
    apt-get clean

# Make directories
RUN mkdir mcp_s-age_pipeline
RUN mkdir mcp_s-age_pipeline/results
RUN mkdir mcp_s-age_pipeline/data

# Copy input files
COPY /data/SVAD_US.csv /mcp_s-age_pipeline/data/SVAD_US.csv
COPY /data/US_var_info.csv /mcp_s-age_pipeline/data/US_var_info.csv

# Copy .R files
COPY install_yada.R /mcp_s-age_pipeline/install_yada.R
COPY make_multivariate_crossval_results.R /mcp_s-age_pipeline/make_multivariate_crossval_results.R
COPY make_publication_results.R /mcp_s-age_pipeline/make_publication_results.R
COPY make_univariate_crossval_results.R /mcp_s-age_pipeline/make_univariate_crossval_results.R
COPY run_all_analyses.R /mcp_s-age_pipeline/run_all_analyses.R
COPY solvex_US.R /mcp_s-age_pipeline/solvex_US.R
COPY solvey_US_multivariate.R /mcp_s-age_pipeline/solvey_US_multivariate.R
COPY solvey_US_univariate.R /mcp_s-age_pipeline/solvey_US_univariate.R
COPY write_US_problems.R /mcp_s-age_pipeline/write_US_problems.R

# Install the specific yada commit that was used for publication with the
# following file. This also install dplyr, ggplot2, and tidyr.
RUN Rscript mcp_s-age_pipeline/install_yada.R
# Use Rocker with R 4.3
FROM rocker/verse:4.3

RUN Rscript -e "install.packages('BiocManager', repos='https://cloud.r-project.org')"

RUN Rscript -e "BiocManager::install(version = '3.18')" && \
    Rscript -e "BiocManager::install(c('edgeR', 'limma'))"

RUN Rscript -e "remotes::install_version('dplyr', version = '1.1.4', repos = 'https://cloud.r-project.org')"

#cannot chown /home/rstudio, will break running container, therefore make subdir
RUN mkdir -p /home/rstudio/chk2 && \
    chown -R rstudio:rstudio /home/rstudio/chk2


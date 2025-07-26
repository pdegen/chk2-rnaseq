FROM rocker/verse:4.2

RUN Rscript -e "install.packages('BiocManager', repos='https://cloud.r-project.org')" && \
    Rscript -e "BiocManager::install(version = '3.15', ask = FALSE)" && \
    Rscript -e "options(repos = BiocManager::repositories()); BiocManager::install(c('edgeR', 'limma', 'GO.db','org.Hs.eg.db'), ask = FALSE)"


RUN Rscript -e "remotes::install_version('dplyr', version = '1.1.4', repos = 'https://cloud.r-project.org')" && \
    Rscript -e "remotes::install_version('knitr', version = '1.42', repos = 'https://cloud.r-project.org')" && \
    Rscript -e "remotes::install_version('markdown', version = '1.6', repos = 'https://cloud.r-project.org')" && \
    Rscript -e "install.packages(c('pheatmap', 'statmod'))"

#cannot chown /home/rstudio, will break running container, therefore make subdir
RUN mkdir -p /home/rstudio/chk2 && \
    chown -R rstudio:rstudio /home/rstudio/chk2


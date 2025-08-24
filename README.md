# CHK2

Code for reproducing the RNA-Seq analysis in Muñoz-Maldonado et al. (2025)

To reproduce the analysis, you must first download the data from GEO, accession number [GSE303774](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE303774). You can either download the raw data to perform alignment and quantification or download the count matrix to perform downstream differential expression and enrichment analysis.

## Downstream analysis with Docker

Assuming you have Make and Docker installed and saved the `counts.csv` matrix in `/data`:

- Run `make run`
- Open the RStudio Server via [http://localhost:8787/](http://localhost:8787/)
- Open `analysis.qmd`
- Render the current document (via button or Ctrl+Shift+K)

This will run edgeR using the `/data/GSE303774_raw_counts.csv.gz` matrix (obtained from GEO) and save the results table in `/data/edger_table.csv`. Quarto will render a `analysis.html` fill with additional figures. The output should show:

> Significant genes: 2223 (up: 1054, down: 1169)

### DDR heatmap

The Quarto file produces a heatmap of DDR DEGs using R. However, in the paper, we show the same heatmap generated with Python's seaborn library. This part is not included in the Docker image to limit its size. To reproduce the same heatmap as used in the paper, run the Jupyter notebook [heatmap.ipynb](heatmap.ipynb) with the Conda environment from [environment.yaml](environment.yaml):

```{bash}
conda env create -f environment.yaml
conda activate chk2-rnaseq
```

### Notes for Docker Desktop

If you use Docker Desktop 4.34 or earlier, see [How do I enable file sharing?](https://docs.docker.com/desktop/troubleshoot-and-support/faqs/linuxfaqs/#how-do-i-enable-file-sharing)

User remapping leads to files in the container being owned by root (id=0). To avoid `chown` every time the container is exited, the following solution can be employed:

```{bash}
# Recursively grant rwx to your user on the shared folder
sudo setfacl -R -m u:$USER:rwx /your/shared/folder
```

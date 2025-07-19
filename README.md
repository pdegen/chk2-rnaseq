# CHK2

Code for reproducing the RNA-Seq analysis in Muñoz-Maldonado et al. (2025)

To reproduce the analysis, you must first download the data from GEO. (TO DO: insert link). You can either download the raw data (TO DO: insert size) to perform alignment and quantification or download the count matrix to perform downstream differential expression and enrichment analysis.

## Downstream analysis with Docker

Assuming you have Make and Docker installed and saved the `counts.csv` matrix in `/data`:

- Run `make run_container`
- Open the RStudio Server via [http://localhost:8787/](http://localhost:8787/)
- Open `analysis.qmd`
- Render the current document (via button or Ctrl+Shift+K)

This will run edgeR using the `/data/counts.csv` matrix and save the results table in `/data/edger_table.csv`. The output should show:

> Significant genes: 2223 (up: 1054, down: 1169)

### Notes for Docker Desktop

If you use Docker Desktop 4.34 or earlier, see [How do I enable file sharing?](https://docs.docker.com/desktop/troubleshoot-and-support/faqs/linuxfaqs/#how-do-i-enable-file-sharing)

User remapping leads to files in the container being owned by root (id=0). To avoid `chown` every time the container is exited, the following solution can be employed:

```{bash}
# Recursively grant rwx to your user on the shared folder
sudo setfacl -R -m u:$USER:rwx /your/shared/folder
```

# HC_snakemake

* This repository contains pipeline built with Snakemake to detect somatic and germline variants using GATK HaplotypeCaller function. The variant calling is based on GATK Best Practices of variant detection by calling SNPs and indels simultaneously via local de-novo assembly of haplotypes.

* The WGS data used here are TCGA data from tissues such as breast, ovary and uterus and downloaded from Genomic Data Commons.

* This pipeline assumes that the TCGA data has been downloaded and already exists in the analyzable bam formats with their indexed files.

* The reference genome used for alignment and analyses here is Hg38.

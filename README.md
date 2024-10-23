# HC_snakemake

* This repository contains pipeline built with Snakemake to detect somatic and germline variants using GATK HaplotypeCaller function. The variant calling is based on GATK Best Practices of variant detection by calling SNPs and indels simultaneously via local de-novo assembly of haplotypes. The run uses PairHMM using the OpenMP multi-threaded AVX-accelerated native PairHMM implementation.

* The WGS data used here are TCGA data from tissues such as breast, ovary and uterus and downloaded from Genomic Data Commons.

* This pipeline assumes that the TCGA data has been downloaded and already exists in the analyzable bam formats with their indexed files.

* The reference genome used for alignment and analyses here is Hg38.


## Project dependencies

- Conda
- Snakemake

## Directory structure

* The directory structure follows that of Snakemake and are organized as below:
  - config/ - contains the Snakemake-configuration files of samples.yaml, config.yaml, sample details and cluster details
  - results/ - contains output directories and results from the ```gatk HaplotypeCaller``` run
  - logs/ - contains the run details
  - scripts/ - contains the scripts used in the pipeline

* The config file (```config/config.yaml```) can be customized depending on the analyses and the user specification such as
  - Input files
  - Output directories
  - Different tools and methods, example
```gatk HaplotypeCaller``` or ```gatk GatherVcfs```

* The config file (config/cluster_qsub.yaml) contains other parameters, such as the number of threads to use.

## How to run by invoking Snakemake

```
path/to/bin/snakemake -s path/to/Snakemake/HaplotypeCaller/HC.snakefile --cluster-config path/to/HaplotypeCaller/config/cluster_qsub.yaml --cluster "qsub -l h_vmem={cluster.h_vmem},h_rt={cluster.h_rt} -pe {cluster.pe} -binding {cluster.binding}" --jobs 20 --rerun-incomplete
```


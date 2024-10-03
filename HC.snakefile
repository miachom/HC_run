# Define config file (optional) for paths and parameters
configfile: "config/config.yaml"
configfile: "config/samples.yaml"


# Define the final rule to process all samples and combine their VCFs
rule all:
    input:
        expand("results/HC/{tumor}/unfiltered_{chromosomes}.vcf.gz",tumor=config["tumor"],chromosomes=config["chromosomes"]),
        expand("results/HC/{tumor}/unfiltered_{chromosomes}.vcf.gz.tbi",tumor=config["tumor"],chromosomes=config["chromosomes"]),
        expand("results/HC/{tumor}/unfiltered_{chromosomes}_bamout.bai",tumor=config["tumor"],chromosomes=config["chromosomes"]),
        expand("results/HC/{tumor}/unfiltered_{chromosomes}_bamout.bam",tumor=config["tumor"],chromosomes=config["chromosomes"]),
#        expand("results/GatherVcfs/HC/{tumor}/gathered_unfiltered.vcf.gz",tumor=config["tumor"]),
#        expand("results/GatherVcfs/HC/{tumor}/gathered_unfiltered.vcf.gz.tbi", tumor = config["tumor"])

# Rule to run GATK HaplotypeCaller for each sample and chromosome

rule haplotype_caller:
    input:
        tumor_filepath = lambda wildcards: config["base_file_name"][wildcards.tumor]
    output:
        vcf="results/HC/{tumor}/unfiltered_{chromosomes}.vcf.gz",
        tbi="results/HC/{tumor}/unfiltered_{chromosomes}.vcf.gz.tbi",
        bam="results/HC/{tumor}/unfiltered_{chromosomes}_bamout.bam",
        bai="results/HC/{tumor}/unfiltered_{chromosomes}_bamout.bai"
    params:
        reference_genome = config["reference_genome"],
        gatk = config["gatk_path"],
        tumor = lambda wildcards: config["tumor"][wildcards.tumor]
        #gvcf_mode=config.get("gvcf_mode", False)  # Optionally turn on GVCF mode via config
    log:
        "logs/HC/{tumor}/unfiltered_{chromosomes}_HC.txt"
    shell:
         "({params.gatk} HaplotypeCaller \
          -reference {params.reference_genome} \
          -input {input.tumor_filepath} \
          -intervals {wildcards.chromosomes} \
          -bamout {output.bam} \
          -output {output.vcf}) 2> {log}"



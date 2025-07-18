
rule nonsnps_hard_fltr:
    input:
        nonsnp_unfiltered_vcf = "{bucket}/wgs/pipeline/{ref}/{date}/unfltr_vcf/nonsnps.vcf.gz",
        nonsnp_unfiltered_tbi = "{bucket}/wgs/pipeline/{ref}/{date}/unfltr_vcf/nonsnps.vcf.gz.tbi"
    output:
        nonsnp_filtered_vcf = "{bucket}/wgs/pipeline/{ref}/{date}/hardflt_vcf/nonsnp_fltr.vcf.gz",
        nonsnp_filtered_tbi = "{bucket}/wgs/pipeline/{ref}/{date}/hardflt_vcf/nonsnp_fltr.vcf.gz.tbi"
    threads: 4
    resources:
         time   = 240,
         mem_mb = 24000
    shell:
        '''
            gatk --java-options "-Xmx24g -Xms3g" \
                VariantFiltration \
                -V {input.nonsnp_unfiltered_vcf} \
                -O {output.nonsnp_filtered_vcf} \
                --filter-name "QUAL40" -filter "QUAL < 40.0" \
                --verbosity ERROR
        '''

rule snps_hard_fltr:
    input:
        snp_unfiltered_vcf = "{bucket}/wgs/pipeline/{ref}/{date}/sites_only_gather_vcf/gather.snp_sites_only.vcf.gz",
        snp_unfiltered_tbi = "{bucket}/wgs/pipeline/{ref}/{date}/sites_only_gather_vcf/gather.snp_sites_only.vcf.gz.tbi"
    output:
        snp_filtered_vcf = "{bucket}/wgs/pipeline/{ref}/{date}/hardflt_vcf/snp_fltr.vcf.gz",
        snp_filtered_tbi = "{bucket}/wgs/pipeline/{ref}/{date}/hardflt_vcf/snp_fltr.vcf.gz.tbi"
    threads: 4
    resources:
         time   = 240,
         mem_mb = 24000
    shell:
        '''
            gatk --java-options "-Xmx24g -Xms3g" \
                VariantFiltration \
                -V {input.snp_unfiltered_vcf} \
                -O {output.snp_filtered_vcf} \
                --filter-name "QUAL30" -filter "QUAL < 30.0" \
                --verbosity ERROR
        '''


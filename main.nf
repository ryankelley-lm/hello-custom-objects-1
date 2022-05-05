#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { BWA_INDEX } from './modules/bwa/index/main.nf'
include { BWA_MEM   } from './modules/bwa/mem/main.nf'

def test_data_dir = "https://raw.githubusercontent.com/nf-core/test-datasets/modules/data"
genome_fasta = "${test_data_dir}/genomics/sarscov2/genome/genome.fasta"
test_1_fastq_gz = "${test_data_dir}/genomics/sarscov2/illumina/fastq/test_1.fastq.gz"

workflow {
    input = [
        [ id:'test', single_end:true ], // meta map
        [
            file(test_1_fastq_gz, checkIfExists: true)
        ]
    ]
    fasta = file(genome_fasta, checkIfExists: true)

    BWA_INDEX ( fasta )
    BWA_MEM ( input, BWA_INDEX.out.index, false )
}

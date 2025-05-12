#!/bin/bash

mkdir -p data
mkdir -p ref
mkdir -p results

cd data

# 1. Download and convert SRA to FASTQ
while read srr; do
    prefetch $srr
    fastq-dump --split-files $srr
done < SRR_Acc_List.txt


# 2. Quality Control
fastqc *.fastq
multiqc 
.
# Remove zip files
rm *_fastqc.zip
cd ..

cd ref

# Download prebuilt GRCh38 index
wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz

# Extract it
tar -xvzf grch38_genome.tar.gz
cd ..

# 5. Align reads and create BAM files (for single read files only)
echo "Starting alignment..."
for id in $(ls data/*_1.fastq | sed 's/.*\///' | sed 's/_1.fastq//' | sort -u); do
  echo "Aligning $id"
  hisat2 -x ref/grch38/genome \
    -U data/${id}_1.fastq \
    -S results/${id}.sam
  echo "Converting SAM to BAM for $id"
  samtools view -Sb results/${id}.sam > results/${id}.bam
  echo "Sorting BAM for $id"
  samtools sort results/${id}.bam -o results/${id}.sorted.bam
  
  # Index the sorted BAM
  samtools index results/${id}.sorted.bam
  
  # Remove intermediate files to save space
  rm results/${id}.sam results/${id}.bam
done

# 6. Gene quantification with featureCounts
echo "Counting features..."
featureCounts -a ref/GCF_000001405.40_GRCh38.p14_genomic.gtf \
  -o results/counts.txt \
  -T 4 \
  results/*.sorted.bam

echo "RNA-Seq pipeline completed!"
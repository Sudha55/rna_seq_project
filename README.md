# SQLite-Based Parkinson's RNA-Seq DEG Analysis

## Abstract
This project creates a full pipeline for exploring differential gene expression in Parkinson’s disease starting from downloading, processing, aligning and quantification of the raw fastq data to full DEG analysis. Then it creates a simple SQLite database and Python analysis tool for exploring differential gene expression in Parkinson's disease using RNA-Seq data. The project answers the question: "Which genes are most differentially expressed between the Parkinson’s Disease and healthy/controlled individuals?” Although the project uses statistically insignificant sample size (3 samples), it is intended to create and run the full pipeline in a local machine with limited storage and processing capacities. This project is just a concept of proof to a full pipeline. 

## OBJECTIVES

- To develop a reproducible RNA-seq pipeline to analyze gene expression in Parkinson's disease, automating data processing, alignment, statistical analysis and visualization using publicly available datasets
- Success will be measured by an automated pipeline for data processing, a database for storing results, statistical analysis identifying differentially expressed genes, and visualizations
- I (Sudha) is responsible for designing, implementing, and testing the RNA-seq pipeline, writing the Bash scripts, performing the analysis using Python and R, and documenting the entire process. This entire workflow is done in a local Mac machine.
- This project is achievable within the scope of the resources and tools available, including publicly available datasets. It will use SQLite for storing sample metadata and DEG results, automate QC + alignment + quantification in bash script, and use Python (Jupyter notebook) for DEG analysis + visualization.
- A working version of this project is completed over the course of 5–6 weeks, totaling about 35+ hours. 

## Deliverables

- **Reproducible RNA-seq pipeline**
  - `pipeline.sh`: A single Bash script that:
    - Downloads public RNA-Seq data (from SRA toolkit).
    - Performs QC (FastQC/MultiQC).
    - Aligns reads (Hisat2).
    - Quantifies gene counts (featureCounts).
    - Success metric: Script runs end-to-end without errors on any local machine/High performance Computing if all requirements satisfy and the machine has the required processing power and storage.

- **SQL Database**
  - `parkinsons.db`: SQLite database with:
    - Table 1 : samples (sample IDs, condition, tissue source)
    - Table 2: deg_results (gene IDs, log2FC, p-values, adjusted p-values).
    - Success metric: Python scripts can query/insert data.

- **DEG Analysis & Visualization (Python Jupyter notebook)**
  - A Jupyter notebook (`Deseq_Analysis.ipynb`) that performs:
    - Loads gene counts into a Pandas DataFrame
    - Performs statistical analysis using python libraries
    - Generate required plots 

- **Documentation**: A `README.md` file, User_Manual.pdf file for user documentation and code explaination, requirements.txt


- **Success Metrics**: The code can be reproduced by other students

## Background
Parkinson's disease (PD) is a chronic and progressive neurodegenerative disorder that primarily affects movement. It is caused by the loss of dopamine-producing neurons in the substantia nigra, a part of the brain responsible for controlling movement. Common symptoms include tremors, stiffness, and difficulty with balance and coordination. While medications can help manage symptoms, there is currently no cure for the disease.

## What is DEG (Differential Gene Expression)?
Differential gene expression analysis helps researchers identify genes whose expression levels differ significantly between two or more biological conditions, such as healthy vs. diseased tissues. In the context of RNA-Seq, DEG analysis compares gene read counts across groups to detect genes that may be involved in the disease process.

## Why Build a Gene Expression Database for Parkinson's?
Projects like this could be helpful in understanding which genes are most affected in Parkinson's disease, and how can one achieve it. There has been many researches on DEG of many tumorous diseases, but very less neurodegenerative diseases. The project is done in an attempt to understand the gap in this research field.

The same version of code does not exist anywhere, as the whole pipeline was created by myself based on my need (low storage, low processing on a local machine) for single read files. However, many RNA seq analyses use pair-end reads, and create pipelines for that, which is why this project may slightly differ from other existing code. 

## Project Components
There are 3 components in this project:
1. **Working reproducible bash pipeline**: There is one reproducible bash pipeline named `pipeline.sh`. It performs the RNA seq analysis like quality check, alignment, annotation, and quantification in one `.sh` file itself. All you need to do is download the requirements from `requirements.txt` and run the pipeline using your own choice of data, or my data listed in `SRR_Acc_list.txt`.  
2. **A working database**: For the purpose of reproducibility, I have used SQLite. It stores the metadata and DEG results, and queries them to get DEG data for visualization in Python. All you need to do is have SQLite installed, and you create and run the database from the code itself. It will be named `parkinsons.db` in your machine.
3. **The python script** is written in Jupyter notebook as mentioned before. The codes are written in organized cells that will provide the visualizations once you run these cells sequentially. The best way to run this script will be in Jupyter notebook.  
The detailed explanation on what these scripts do will be on `User_Manual.pdf`, with full description of the code and how to exactly run them on Jupyter notebook. 

## DATA
The data I have used is from NCBI SRA run selector. The SRA study number is SRP049203 and BioID is PRJNA264625. While this data contains 14 samples, each fasta files from these samples were as huge as ~12GB. This would take a lot of processing and storage power. Since my aim was to create a reproducible scripts for everyone, and not only the ones with an access to HPC, I used only 3 samples: `SRR1619543`, `SRR1619538`, `SRR1619537` for my analysis. Even with 3 samples, each alignment took me over an hour. Which is why, a very high storage and computing power is expected to run this whole pipeline. The link to the data is:  
https://www.ncbi.nlm.nih.gov/Traces/study/?acc=PRJNA264625&o=acc_s%3Aa&s=SRR1619543,SRR1619538,SRR1619537

## USERS
The users of this projects are researchers in clinical areas, students, any anyone with interest and access to high computing powers. The pipeline is fairly technical, so I would expect them to have some technical background.

## IMPLEMENTATION CONSTRAINTS
The main implementation constraints were the storage and processing on my local machine. While I could have used the High performance computing, my aim was reproducibility within students, so I had to make the project as small as possible. As a consequence, I had no significantly expressed DEGs, so I had to randomize the log2fold values in order to show that the script works.

## REFERENCES
Daehwan Kim, Ben Langmead, and Steven L Salzberg. “HISAT: a fast spliced aligner with low memory requirements”. In: Nature methods 12.4 (2015), pp. 357–360. doi: 10.1038/nmeth.3317.

Yang Liao, Gordon K Smyth, and Wei Shi. “featureCounts: an efficient general purpose program for assigning sequence reads to genomic features”. In: Bioinformatics 30.7 (2014), pp. 923–930. doi: 10.1093/bioinformatics/btt656.

Michael I Love, Wolfgang Huber, and Simon Anders. “Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2”. In: Genome Biology 15.12 (2014), p. 550. doi: 10.1186/s13059-014-0550-8.

Kurvits L, Lättekivi F, Reimann E, et al. Transcriptomic profiles in Parkinson’s disease. Experimental Biology and Medicine. 2021;246(5):584-595. doi:10.1177/1535370220967325

Jia, E., Pan, M., Liu, Z., Zhou, Y., Zhao, X., Dong, J., Bai, Y., & Ge, Q. (2020). Transcriptomic profiling of differentially expressed genes and related pathways in different brain regions in Parkinson’s disease. Neuroscience Letters, 732, 135074. https://doi.org/10.1016/j.neulet.2020.135074

Ma, S.-X., & Lim, S. B. (2021). Single-cell RNA sequencing in Parkinson’s disease. Biomedicines, 9(4), 368. https://doi.org/10.3390/biomedicines9040368

Heng Li, Bob Handsaker, Alec Wysoker, Tim Fennell, Jue Ruan, Nils Homer, Gabor Marth, Goncalo Abecasis, Richard Durbin, 1000 Genome Project Data Processing Subgroup, The Sequence Alignment/Map format and SAMtools, Bioinformatics, Volume 25, Issue 16, August 2009, Pages 2078–2079, https://doi.org/10.1093/bioinformatics/btp352

Woodard CM, Campos BA, Kuo SH, Nirenberg MJ, Nestor MW, Zimmer M, Mosharov EV, Sulzer D, Zhou H, Paull D, Clark L, Schadt EE, Sardi SP, Rubin L, Eggan K, Brock M, Lipnick S, Rao M, Chang S, Li A, Noggle SA. iPSC-derived dopamine neurons reveal differences between monozygotic twins discordant for Parkinson's disease. Cell Rep. 2014 Nov 20;9(4):1173–82. doi: 10.1016/j.celrep.2014.10.023. Epub 2014 Nov 6. PMID: 25456120; PMCID: PMC4255586.


License
MIT License (See more on License page)



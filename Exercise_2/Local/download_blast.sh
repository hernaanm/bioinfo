#! /usr/bin/sh
wget https://ftp.ncbi.nlm.nih.gov/blast/db/FASTA/swissprot.gz
gzip -d -k swissprot.gz
wget https://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.13.0+-x64-linux.tar.gz
tar -xvf ncbi-blast-2.13.0+-x64-linux.tar.gz
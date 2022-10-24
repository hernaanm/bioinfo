#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;
use Bio::SeqIO;
use Bio::SeqUtils;

my $seqio_obj;
my $seq_obj;
my $seqout;

my $inputPath = "Input/";
my $outputPath = "Output/";
my $exercise = "Exercise_1";


$seqio_obj = Bio::SeqIO->new(-file => "Input/Exercise_1/sequence.gb", 
                             -format => "genbank" ); 

$seq_obj = $seqio_obj->next_seq;


my @all_trans = Bio::SeqUtils->translate_6frames($seq_obj);


	for (my $i = 0; $i < @all_trans; $i++) {
        print("Sequence_" . ($i + 1) );
        print("\n");
	    print($all_trans[$i]->seq);
        print("\n");
        print("\n");
        $seqout = Bio::SeqIO->new(-file => ">" . $outputPath . $exercise . "/output_" . ($i + 1) . ".fasta", -format => "fasta");
        $seqout->write_seq($all_trans[$i]);
        
    }

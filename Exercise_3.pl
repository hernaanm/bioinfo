use Bio::Tools::Run::Alignment::Clustalw;


my $seqio_obj1;
my $seqio_obj2;
my $seq_obj1;
my $seq_obj2;
my $seqout;
my $outputPath = "Output/Exercise_3" ;

$seqio_obj1 = Bio::SeqIO->new(-file => "Input/Exercise_3/sequence.fasta", 
                             -format => "fasta" ); 


$seqio_obj2 = Bio::SeqIO->new(-file => "Input/Exercise_3/sequence1.fasta", 
                             -format => "fasta" ); 


$seqio_obj3 = Bio::SeqIO->new(-file => "Input/Exercise_3/sequence2.fasta", 
                             -format => "fasta" ); 


$seqio_obj4 = Bio::SeqIO->new(-file => "Input/Exercise_3/sequence3.fasta", 
                             -format => "fasta" ); 
my @seq_array =();

$seq_obj1 = $seqio_obj1->next_seq();
$seq_obj2 = $seqio_obj2->next_seq();
$seq_obj3 = $seqio_obj3->next_seq();
$seq_obj4 = $seqio_obj4->next_seq();

push(@seq_array,$seq_obj1);
push(@seq_array,$seq_obj2);
push(@seq_array,$seq_obj3);
push(@seq_array,$seq_obj4);

	for (my $i = 0; $i < 4; $i++) {
        print("Sequence_" . ($i + 1) );
        print("\n");
	    print($seq_array[$i]);
        print("\n");
        print("\n");
    }



$factory = Bio::Tools::Run::Alignment::Clustalw->new(-matrix => 'BLOSUM');
$ktuple = 3;
$factory->ktuple($ktuple);

# @seq_array is an array of Bio::Seq objects
$seq_array_ref = \@seq_array;

$aln = $factory->align($seq_array_ref);


$seqout = Bio::AlignIO->new(-file => ">Output/Exercise_3/alignement.fasta", -format => "fasta");
$seqout->write_aln($aln)
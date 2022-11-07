use Bio::Factory::EMBOSS;
use Bio::SeqIO;
use Bio::Seq;

$f = Bio::Factory::EMBOSS -> new();

 my $fasta_input = Bio::SeqIO->new(
  -file => "./Input/sequence.fasta"
);

my $seq = $fasta_input->next_seq;

my $get_orf = $f->program("getorf");
$get_orf->run({
  -sequence => $seq,
  -outseq => "./Output/orfs.fasta",
  -table => 1,
});
 

 my $patmatmotifs = $f->program('patmatmotifs');
 $patmatmotifs->run({-sequence => $seq,
              	    -full => 1,
                    -outfile => "./Output/patmotmotifs.fasta"});
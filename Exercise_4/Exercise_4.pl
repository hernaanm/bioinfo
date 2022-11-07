use Bio::SearchIO;
use Bio::DB::GenPept;

my $pattern = @ARGV[0];

my $pattern = lc($pattern);
my $outputPath = "./Output/$pattern";
my $inputPath = "./Input/blast.out";

my $blast_file = Bio::SearchIO->new(
  -file => $inputPath,
  -format => 'blast'
);

my $gb = Bio::DB::GenPept->new();

my $hits_number = 0;

my $blast = $blast_file->next_result ;

while ( my $hit = $blast->next_hit ) {
my $hit_description = lc($hit->description);

    if ($hit_description =~ /$pattern/) {
        mkdir($outputPath, 0700) unless (-d $outputPath);
        
        my $accession = $hit->accession;
        my $accession_sequence = $gb->get_Seq_by_acc($accession);
        
        print($hit->name);
        print("\n");
        print($hit_description);
        print("\n");
        print("Sequence: " . $accession_sequence->seq);
        print("\n");
        print("\n");

        my $seqout = Bio::SeqIO->new(
        -file => ">$outputPath/$accession.fasta",
        -format => 'fasta'
        );
        $seqout->write_seq($accession_sequence);
        $hits_number++;
    }
}

print("Number of hits: " . $hits_number);
print("\n");

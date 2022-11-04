use Bio::Tools::Run::RemoteBlast;
use strict;
my $prog = 'blastp';
my $db   = 'swissprot';
my $e_val= '1e-10';
 
my @params = ( '-prog' => $prog,
       '-data' => $db,
       '-expect' => $e_val,
       '-readmethod' => 'SearchIO' );
 
my $factory = Bio::Tools::Run::RemoteBlast->new(@params);
 
$Bio::Tools::Run::RemoteBlast::HEADER{'MATRIX'} = 'BLOSUM62';
$Bio::Tools::Run::RemoteBlast::HEADER{'ALIGNEMENTS'} = '250';
$Bio::Tools::Run::RemoteBlast::HEADER{'FILTER'} = 'F';

 
#$v is just to turn on and off the messages
my $v = 1;
 
my $str = Bio::SeqIO->new(-file=>'./Input/orfs.fasta' , -format => 'fasta' );
 
 
while (my $input = $str->next_seq()){
  my $r = $factory->submit_blast($input);
  
 
  print STDERR "waiting..." if( $v > 0 );
  while ( my @rids = $factory->each_rid ) {
    foreach my $rid ( @rids ) {
      my $rc = $factory->retrieve_blast($rid);
      if( !ref($rc) ) {
        if( $rc < 0 ) {
          $factory->remove_rid($rid);
        }
        print STDERR "." if ( $v > 0 );
        sleep 5;
      } else {
        my $result = $rc->next_result();
        #save the output
        my $filename = $result->query_name()."\.out";
        $factory->save_output($filename);
        $factory->remove_rid($rid);
        print "\nQuery Name: ", $result->query_name(), "\n";
        while ( my $hit = $result->next_hit ) {
          next unless ( $v > 0);
          print "\thit name is ", $hit->name, "\n";
          while( my $hsp = $hit->next_hsp ) {
            print "\t\tscore is ", $hsp->score, "\n";
          }
        }
      }
    }
  }
}

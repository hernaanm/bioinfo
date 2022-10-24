# Importación de librerías
use Bio::Tools::Run::RemoteBlast;

# Activo errores y advertencias
use strict;
use warnings;

# Declaro variables
my $usage = "";
my $fileInput = "Input/Exercise_2/all.fasta";
my $prog = "blastp";
my $db   = "swissprot";
my $e_val= "1e-10";

my @params = ( "-prog" => $prog,
	"-data" => $db,
	"-expect" => $e_val,
	"-readmethod" => "SearchIO" );

my $factory = Bio::Tools::Run::RemoteBlast->new(@params);
my $fileOutput = "blast\.out";

# Ejecuto Blast contra una base de datos remota
my $r = $factory->submit_blast($fileInput);

print STDERR "Realizando la consulta BLAST...";

# Por cada resultado de BLAST, si hay un error en algún resultado lo salteo, en caso contrario lo guardo en archivo
while ( my @rids = $factory->each_rid ) {
	foreach my $rid ( @rids ) {
		my $rc = $factory->retrieve_blast($rid);
		if( !ref($rc) ) {
			if( $rc < 0 ) {
				$factory->remove_rid($rid);
			}
			print STDERR ".";
			sleep 5;
		} 
		else {
        		my $result = $rc->next_result();

			$factory->save_output($fileOutput);
        		$factory->remove_rid($rid);
		}
	}
}

# Informo de escritura correcta
print "\nQuery ejecutada, resultados guardados en $fileOutput", "\n";

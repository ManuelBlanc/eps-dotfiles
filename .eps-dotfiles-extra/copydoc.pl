#!/usr/bin/env perl

# ----------------------------------------------------------------------------
# Este programilla perl copia las cabezeras del .h al .c, para evitar tener
# que estar copiandolas a mano todo el rato, o tener que actualizar los
# cambios en dos sitios diferentes.
# ----------------------------------------------------------------------------
# "THE BEER-WARE LICENSE" (Revision 42):
# <manuel.blanc@estudiante.uam.es> escribio este programa. Mientras mantengas
# esta cabezera, puedes hacer lo que quieras con esto. Si un dia nos vemos y
# piensas que esto te ha sido util, puedes invitarme a una birra. MBlanc 2014
# ----------------------------------------------------------------------------

use 5.10.0;
use strict;
use warnings;
use File::Find;
use File::Basename;
use Getopt::Std;

# Etiquetas
my $TAG  = '/*#DOC*/';
my $HEAD = '/*#HEAD*/';

# Expresion regular para los prototipos ( en .c y .h)
my $proto_re = qr/^[^#].+?[*\s](\w+)\s*\(/;

my $path = $ARGV[0] // '.';

find(\&wanted, $path);
sub wanted {
	my $base = basename($_, '.c');

	# Solo ficheros acabados en .c, excluyendo .dox.c
	return unless (m/(?<!\.dox)\.c$/);

	# Debe tener cabeza
	unless (-e "$base.h") {
		warn "$base.c:0: fichero acéfalo. omitido\n";
		return
	}

	warn "$_\n";

	# Ficheros de entrada
	open(my $file_c, "<", "$base.c") or die "$base.c:0: no se pudo abrir: ($!)";
	open(my $file_h, "<", "$base.h") or die "$base.h:0: no se pudo abrir: ($!)";
	open(my $doxed,  ">", "$base.dox.c") or die "$base.dox.c:0: no se pudo abrir: ($!)";

 	# Variables
 	my %docs;
 	my @buffer;

	# Se recoje toda la documentacion de la cabezera
	while (<$file_h>) {
		if (m{/\*[!*]}) {
			my $isHeader = ($. == 1);

			# Accumular comentario
			push @buffer, $_;
			while (<$file_h>) {
				s/\.h\b/\.c/ if (m/\@file/);
				push @buffer, $_;
				last if /\*\//;
			}
			die "$base.h:$.: error de sintaxis, comentario no cerrado" if !defined;
			my $comment = join '', @buffer;

			# Guardarlo
			if ($isHeader) {
			    $docs{$HEAD} = $comment;
			}
			else {
			    $_ = <$file_h>;
			    $docs{$1} = $comment if ($_ =~ $proto_re);
			}

			# Vaciar buffer
			$#buffer = -1;
		}
	}

	# Se imprime la cabezera si es la primera linea del fichero
	if (index($_ = <$file_c>, $HEAD) != -1) {
		if ($docs{$HEAD}) {
			print $doxed $docs{$HEAD};
			$_ = <$file_c>;
		}
		else {
			warn "$base.c:$.: etiqueta #HEAD viuda";
		}
	}
	else {
		print $doxed $_;
	}

	# Se recorre el fuente, copiando cabezeras cuando se encuentre la etiqueta
	while (<$file_c>) {
		if (index($_, $TAG) != -1) {
		    $_ = <$file_c>;
		    if (!($_ =~ $proto_re) or !defined $docs{$1}) {
		        warn "$base.c:$.: etiqueta #DOC viuda \n";
		        print $doxed "/*#ERROR*/\n";
		    }
		    else {
		        print $doxed $docs{$1};
		    }
		}
		print $doxed $_;
	}

	close $file_h;
	close $file_c;
	close $doxed;
}

warn "[finished ", time - $^T, "s]\n";

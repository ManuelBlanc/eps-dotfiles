#!/usr/bin/env perl

# ----------------------------------------------------------------------------
# Busca y ejecuta un comando sobre las copias en conflicto de Dropbox.
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
use File::Which;
use Getopt::Std;
$Getopt::Std::STANDARD_HELP_VERSION = 1;
$main::VERSION = "1.0";

my %opts;
getopts("TBxdfp:2h", \%opts);

if ($opts{'h'}) {
	warn "uso: dupes [-TBd] [-p dropbox/] comando...\n";
	warn "-T : solo ficheros de texto\n";
	warn "-B : solo ficheros binarios\n";
	warn "-x : excluye los ficheros borrados\n";
	warn "-d : muestra un diff usando git (implica -2)\n";
	warn "-f : usa la ruta completa\n";
	warn "-p : cambia la ruta de Dropbox (por defecto: ~/Dropbox)\n";
	warn "-2 : tambien pasa por argumento el nombre del original\n";
	warn "-h : muestra esta ayuda\n";
	exit;
}

my $path = $opts{'p'} || $ENV{'HOME'} . '/Dropbox';
my @cmd  = @ARGV ? @ARGV : 'echo';
if ($opts{'d'}) {
	@cmd = split ' ', 'git diff --no-index --diff-algorithm=minimal --';
	$opts{'2'} = 1;
}

# Activate text and bin if neither is TRUE
$opts{'T'} = $opts{'B'} = 1 if !($opts{'T'} || $opts{'B'});

# Test if the shell command exists.
die "invalid command: @cmd\n" if (!which($cmd[0]));

find(\&wanted, $path);
sub wanted {
	$_ = $File::Find::name if $opts{'f'};
	return if !$opts{'T'} && -T;
	return if !$opts{'B'} && -B;
	return if  $opts{'x'} && /\(deleted [0-9a-f]{32}\)/;
	if (-f
		&& (/(.*) \(.*?'s conflicted copy .*?\)(\.?.*)/
		|| /(.*) \(Copia en conflicto de .*?\)(\.?.*)/
		)) {
		my @args = (@cmd, $_);
		push @args, "$1$2" if $opts{'2'};
		system @args;
	}
}

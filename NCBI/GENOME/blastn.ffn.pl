#!/usr/bin/perl
use strict;
use warnings;

my @fas=glob("*.fna");
foreach  (@fas) {
	$_=~/(\S+)_genomic.fna/;
	my $str = $1 . ".bln";
	system("blastn -query $_ -out $str -db Alliens -outfmt 6 -evalue 1e-3 -max_target_seqs 1 -num_threads 6");
}
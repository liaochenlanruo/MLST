#!/usr/bin/perl -w
use strict;

my @fa = glob("*-8.fa");
foreach  (@fa) {
	$_=~/(\d*[a-zA-Z]+\d+)\S+/;
	my $blastn = $1 . ".tpi";
	system("blastn -query $_ -out $blastn -db tpi.db -outfmt 6 -evalue 0.001 -num_threads 6 -max_target_seqs 1");
}
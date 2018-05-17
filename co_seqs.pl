#!/usr/bin/perl
use strict;
use warnings;

open OUT,">>All_loci_seqs.fa" || die;
my @fa = glob("*.fa");
foreach  (@fa) {
	$_ =~/(^[a-z]+)_/;
	my $loci = $1;
	open IN,"$_" || die;
	while (<IN>) {
		chomp;
		if (/(\>.+_)\d+/) {
			print OUT $1 . $loci . "\n";
		}else {
		    print OUT $_ . "\n";
		}
	}
}
close IN;
close OUT;

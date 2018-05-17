#!/usr/bin/perl
use strict;
use warnings;

open OUT,">ALL_glp2.txt" || die;
my @glp = glob("*.glp");
foreach  (@glp) {
	$_ =~ /(\d*[a-zA-Z]+\d+)/;
	my $str = $1;
	open IN,"$_" || die;
	while (<IN>) {
		chomp;
		print OUT $str . "_" . $_ ."\n";
	}
}
close IN;
close OUT;

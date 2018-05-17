#!/usr/bin/perl -w
use strict;

open OUT,">>All_glp.txt" || die;
my @blastn = glob("*.glp");
foreach  (@blastn) {
	$_=~/(\S+)\.glp/;
    open IN,"$_" || die;
	while (<IN>) {
		chomp;
		my @lines = split;
		if ($lines[6] < $lines[7]) {
		print OUT $1 ."_$lines[0]" . ":" . $lines[6] . "-" . $lines[7] . "\n";
		}else{
		print OUT $1 ."_$lines[0]" . ":" . $lines[7] . "-" . $lines[6] . "\n";
		}
	}
}
close IN;
close OUT;

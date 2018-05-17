#!/usr/bin/perl
use strict;
use warnings;

open OUT,">All_str_locis_order.fa" || die;
my @locis = glob("*.locis");
foreach  (@locis) {
	$_ =~ /(.+)\./;
#	my $str = $1;
#	print OUT ">$str\n";
	open IN,"$_" || die;
	while (<IN>) {
		chomp;
#        print OUT ">$str\n";
		if (/^\>/) {
			print OUT $_ . "\n"; 
		}
	}
}
close IN;
close OUT;


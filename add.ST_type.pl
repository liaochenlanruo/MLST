#!/usr/bin/perl
use strict;
use warnings;

my %hash;
open IN,"MLST_Profiles.txt" || die;
<IN>;
while (<IN>) {
	chomp;
	$_=~/(\d+)\t(.+)\t/;
	$hash{$2} = $1;
}
close IN;
open INF,"ST.all.tbl" || die;
open OUT,">ST.all.ST.tbl" ||die;
while (<INF>) {
	chomp;
	$_=~/(\S+)\t(.+)/;
	if (exists $hash{$2}) {
		print OUT $_ . "\t" . $hash{$2} . "\n";
	}else {
	    print OUT $_ . "\t" . "UST" . "\n";
	}
}
close INF;
close OUT;

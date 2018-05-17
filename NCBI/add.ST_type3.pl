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

my %ha;
my $i = 2000;
open INF,"ST.all.tbl" || die;
open OUT,">ST.all.ST.tbl" ||die;
<INF>;
while (<INF>) {
	chomp;
	$_=~/(\S+)\t(.+)/;
	my $capital = uc($2);#将序列转换为大写字母
	if (exists $hash{$capital}) {
		print OUT $_ . "\t" . $hash{$capital} . "\n";
	}elsif (exists $ha{$capital}) {
		print OUT $_ . "\t" . $ha{$capital} . "\n";
	}else {
	    $ha{$capital} = $i;
		$i++;
		print OUT $_ . "\t" . $ha{$capital} . "\n";
	}
}
close INF;
close OUT;

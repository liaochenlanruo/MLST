#!/usr/bin/perl
use strict;
use warnings;

system("mkdir Uncomplete Best Multi");
open OUT,">ST.tbl" || die;
my $ptal = 414;
my $glpl = 372;
my $gmkl = 504;
my $ilvl = 393;
my $purl = 348;
my $pycl = 363;
my $tpil = 435;
my %hash;
my @strains;

my @bln = glob("*.bln");
foreach my $bln (@bln) {
	$bln=~/(\S+).bln/;
	my $str = $1;
	my $fas = $1 . ".fas";
	my $faa = $1 . ".faa";
	my $ffn = $1 . ".ffn";
	my $count = 0;
	push @strains, $str;
	my %cds;
	local $/ = ">";
	open FFN, "$ffn" || die;
	<FFN>;
	while (<FFN>){
	    chomp;
		my ($header, $seqs) = split "\n", $_, 2;
		$header=~/(^\S+)/;
		my $id = $1;
		$seqs=~s/\n//g;
		$cds{$id} = $seqs;
	}
	close FFN;
	local $/ = "\n";
	open IN,"$bln" || die;
	while (<IN>) {
		chomp;
		$count++;
		my @lines = split;
		$lines[1]=~/(\S+)_(\d+)/;
		my $allele = $1;
		my $loci = $2;
		if ($allele eq "glp" && $lines[3] == $glpl && $lines[2] == 100.00) {
			$hash{$str}{"glp"} = $loci;
		}elsif ($allele eq "gmk" && $lines[3] == $gmkl && $lines[2] == 100.00) {
			$hash{$str}{"gmk"} = $loci;
		}elsif ($allele eq "ilv" && $lines[3] == $ilvl && $lines[2] == 100.00) {
			$hash{$str}{"ilv"} = $loci;
		}elsif ($allele eq "pta" && $lines[3] == $ptal && $lines[2] == 100.00) {
			$hash{$str}{"pta"} = $loci;
		}elsif ($allele eq "pur" && $lines[3] == $purl && $lines[2] == 100.00) {
			$hash{$str}{"pur"} = $loci;
		}elsif ($allele eq "pyc" && $lines[3] == $pycl && $lines[2] == 100.00) {
			$hash{$str}{"pyc"} = $loci;
		}elsif ($allele eq "tpi" && $lines[3] == $tpil && $lines[2] == 100.00) {
			$hash{$str}{"tpi"} = $loci;
		}else {
		    $hash{$str}{$allele} = $cds{$lines[0]};
		}
	}
	close IN;
	if ($count < 7) {
		system("mv -f $bln $ffn $faa $fas Uncomplete");
	}elsif ($count == 7) {
		system("mv -f $bln $ffn $faa $fas Best");
	}elsif ($count > 7) {
		system("mv -f $bln $ffn $faa $fas Multi");
	}
}
print OUT "Str\tglp\tgmk\tilv\tpta\tpur\tpyc\ttpi\n";
for (my $i=0;$i<@strains;$i++) {
	print OUT $strains[$i];
	my @all7 = ("glp", "gmk", "ilv", "pta", "pur", "pyc", "tpi");
	for (my $j=0;$j<@all7;$j++) {
		if (exists $hash{$strains[$i]}{$all7[$j]}) {
			print OUT "\t" . $hash{$strains[$i]}{$all7[$j]};
		}else {
		    print OUT "\t-";
		}
	}
	print OUT "\n";
}
close OUT;

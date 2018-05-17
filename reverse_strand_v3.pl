#!/usr/bin/perl
use strict;
use warnings;

sub reverse_complement {
        my $dna = shift;

        # reverse the DNA sequence
        my $revcomp = reverse($dna);

        # complement the reversed DNA sequence
        $revcomp =~ tr/ACGTacgt/TGCAtgca/;
        return $revcomp;
}

open IN, "tpi_seqs_reverse.fa" || die;
open OUT,">>tpi_seqs_reverse2normal.fa" || die;
while (<IN>) {
	chomp;
	if (/^\>/) {
		print OUT $_ . "\n";
	}else{
	    print OUT &reverse_complement($_) . "\n";
	}
}
close IN;
close OUT;

#!/usr/bin/perl
my $header;
my $seq = "";
my $fastaFile = "All_scaf.txt";
my %seq;
open IN, "$fastaFile" or die "Cannot find the specified fasta file $fastaFile";
while(my $line=<IN>){
        chomp($line);
        if ($line=~/^>/){ #the header line
                if (length $seq > 0){ #not the first line
                        $seq{$header} = $seq;
                }
                $header = substr($line,1); #remove >
                $seq = "";
        }else{
                $seq.=$line;
        }
}
$seq{$header} = $seq;
close IN;
open IN, "All_tpi.txt";
open OUT, ">tpi_seqs.fa";
while (my $line = <IN>){
     chomp ($line);
     my ($chr,$pos)=split (":",$line);
     my ($start,$end)=split ("-",$pos);
     my $seq = $seq{$chr};
	 my $start1 = $start - 1;
     my $part = substr($seq,$start1, $end-$start1); #add +1 or -1 after testing
     print OUT ">$line\n$part\n";
}
close IN;
close OUT;


#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(utf8)", ":std";

my $words1 ="突然";
my $words2 ="忽然";

if(@ARGV != 3){
    die "Usage :$0 input_file out_file out_file2\n";
}

open IN, "$ARGV[0]";
open OUT, ">$ARGV[1]";
open OUT1, ">$ARGV[2]";
while(my $line = <IN>){
    chomp $line;
    if($line=~/$words1/){
        print OUT "$line\n";
    }
    if($line=~/$words2/){
        print OUT1 "$line\n";
    }
}
close IN;
close OUT;
close OUT1;

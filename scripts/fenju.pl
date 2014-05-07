#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(utf8)", ":std";
my %fenge;
if(@ARGV != 2){
    die "Usage :$0 input_file out_file\n";
}
open IN, "$ARGV[0]";
open OUT, ">$ARGV[1]";
while(my $line = <IN>){
    $line=~s~[”]~~g;
    my @arr = split /[.!?。！？]/,$line;
    chomp @arr;
    foreach (@arr){
        next if $_=~/^\s*$/;
        print OUT "$_\n";
    }
}
close IN;
close OUT;

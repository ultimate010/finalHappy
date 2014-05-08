#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(gbk)", ":std";
my %fenge;
if(@ARGV != 3){
    die "Usage(gbk):$0 num_first input_file out_file \n";
}
my $lineCount = 0;
open IN, "$ARGV[1]";
open OUT, ">$ARGV[2]";
while(my $line = <IN>){
    chomp $line;
    my @arr = split /\t/,$line;
    $lineCount++;
    if($lineCount <= $ARGV[0]){
        print OUT "1";
    }else{
        print OUT "-1";
    }
    @arr = sort {getFirs($a)<=>getFirs($b)} @arr;
    foreach my $w (@arr){
        my @pas = split/\|/,$w;
        print OUT "\t$pas[0]:$pas[3]";
    }
    print OUT "\n";
}
close IN;
close OUT;

sub getFirs{
    my $w = shift;
    my @pas = split/\|/,$w;
    return $pas[0];
}


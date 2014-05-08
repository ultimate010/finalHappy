#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(gbk)", ":std";
my %fenge;
if(@ARGV != 4){
    die "Usage(gbk):$0 input_file out_file word2id_file id2word_file \n";
}
my %word2id;
my %id2word;
my $startPos = 1;
open IN, "$ARGV[0]";
open OUT, ">$ARGV[1]";
while(my $line = <IN>){
    $line=~s~[\r\n]+$~~;
    my @arr = split /`/,$line;
    foreach my $w (@arr){
        print OUT "$word2id{$w}`" if defined $word2id{$w};
        next if defined $word2id{$w};
        $word2id{$w} = $startPos;
        $id2word{$startPos} = $w;
        print OUT "$word2id{$w}`";
        $startPos++;
    }
    print OUT "\n";
}
close IN;
close OUT;

open OUT, ">$ARGV[2]";
foreach (sort keys %word2id){
    print OUT "$_\t$word2id{$_}\n";
}
close OUT;
open OUT, ">$ARGV[3]";
foreach (sort keys %id2word){
    print OUT "$_\t$id2word{$_}\n";
}
close OUT;

#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(gbk)", ":std";
my %fenge;
if(@ARGV != 3){
    die "Usage(gbk):$0 input_file out_file id2word_file \n";
}
my %id2word;
open IN, "$ARGV[2]" or die $!;
while(my $line = <IN>){
    chomp $line;
    my @arr = split /\t/,$line;
    $id2word{$arr[0]} = $arr[1];
}
close IN;

my %wordFrq;
$. = 0;
open IN, "$ARGV[0]" or die $!;
open OUT, ">$ARGV[1]";
while(my $line = <IN>){
    next if $. < 9; #跳过前8
    chomp $line;
    #print $line;
    #<stdin>;
    my @arr = split / /,$line;
    shift @arr;
    foreach my $w (@arr){
        my @word = split /:/,$w;

        print OUT "$id2word{$word[0]}:$word[1] ";
        $wordFrq{$id2word{$word[0]}}++;
    }
    print OUT "\n";
}
close IN;
close OUT;

foreach (sort{$wordFrq{$a} <=> $wordFrq{$b}} keys %wordFrq){
    print "$_\t$wordFrq{$_}\n";
}

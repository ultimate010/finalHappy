#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(utf8)", ":std";

$ORGFILE = "";#分词后

my %fenge;
if(@ARGV != 1){
    die "Usage(utf8):$0 input_file\n";
}
open IN, "$ARGV[0]";
while(my $line = <IN>){
    chomp $line;
    my @arr = split/\t/,$line;
    doIt(@_);
}
close IN;
#step
#从分词后找出含数据的句子
#将这个句子根据id做映射合并
#将映射结果做tf_idf
#训练交叉检验

sub doIt{
    my($one,$one_file,$two,$two_file)= @_;
    findSent(@_);

}

sub findSent{
    my($one,$one_file,$two,$two_file)= @_;
    print STDERR "Doing findsent: $one\t$one_file\t$two\t$two_file\n";
    open IN , $ORGFILE or die $!;
    open OUT1 , ">$one_file" or die $!;
    open OUT2 , ">$two_file" or die $!;
    while(my $line = <IN>){
        if(){
        }
    }
    close OUT1;
    close OUT2;
    close IN:

}

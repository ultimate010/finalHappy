#!/usr/bin/perl
#!/usr/bin/perl
use strict;
use Encode;
use utf8;
use open ":encoding(utf-8)", ":std";
my $WENGDANGSHU = 0; #总文档数
my %hashLine2WordCount; #文档出现每个词计数
my %hashLine2WordTotal; #文档出现总词计数
my %hashWord2DocCount; #词出现文档数
my %hashLine2Wordtf; #文档出现每个词tf
my %hashLine2Wordidf; #文档出现每个词idf
my %hashLine2Wordtfidf; #文档出现每个词tfidf

if(@ARGV != 2){
    die "Usage(utf8):$0 input_file out_file\n";
}

open IN, $ARGV[0] or die $!;

while(<IN>){
    chomp;
    my @arr = split /`/; #分隔符`
    $WENGDANGSHU++;
    $hashLine2WordTotal{$WENGDANGSHU} = @arr;
    foreach (@arr){
        ${$hashLine2WordCount{$WENGDANGSHU}}{$_}++; #当前行词出现次数
    }
    foreach (keys %{$hashLine2WordCount{$WENGDANGSHU}}){ #遍历每个词
        $hashWord2DocCount{$_}++; #当前词出现文档数
    }
}
close IN;

#compute tf idf
my @idfArr; #all tfidf;
for(my $i = 1;$i <= $WENGDANGSHU;$i++){
    foreach my $word (keys %{$hashLine2WordCount{$i}}){ #遍历每个词
        my $idf = log($WENGDANGSHU / $hashWord2DocCount{$word}); #分子不可能为0
        ${$hashLine2Wordidf{$i}}{$word} = $idf;
        my $tf = ${$hashLine2WordCount{$i}}{$word} / $hashLine2WordTotal{$i};
        ${$hashLine2Wordtf{$i}}{$word} = $tf;
        my $tfidf = $idf * $tf;
        ${$hashLine2Wordtfidf{$i}}{$word} = $tfidf;
        push @idfArr,$tfidf;
    }
}

@idfArr = sort{$a <=> $b} @idfArr; #从小到大
my $fazhi = $idfArr[int(@idfArr * 0.2)]; #删除最低20% tfidf 的数据

open OUT , ">$ARGV[1]" or die $!;
for(my $i = 1;$i <= $WENGDANGSHU;$i++){
    foreach my $word (keys %{$hashLine2WordCount{$i}}){ #遍历每个词
        #next if $tfidf < $fazhi; #是否去掉最抵的百分之x
        print OUT $word."|${$hashLine2Wordtf{$i}}{$word}|${$hashLine2Wordidf{$i}}{$word}|${$hashLine2Wordtfidf{$i}}{$word}"."\t";
    }
    print OUT "\n";
}
close OUT;




# 说明

本pipeline适用于Bc群菌株的MLST批量分型，若想用于其他物种的分型，需要自行更换[数据库](https://pubmlst.org/databases/)，并修改脚本中的等位基因信息。运行脚本前用于需要注意观察“blastn.ffn.pl”中输入文件的后缀名是否和自己的数据匹配，若不匹配，需要修改脚本中的第5、7行的“.ffn”为自己的后缀名。

```
#!/usr/bin/perl
use strict;
use warnings;

my @fas=glob("*.ffn");
foreach  (@fas) {
	$_=~/(\S+).ffn/;
	my $str = $1 . ".bln";
	system("blastn -query $_ -out $str -db alleles -outfmt 6 -evalue 1e-3 -max_target_seqs 1 -num_threads 6");
}
```

# 操作步骤

## 文件准备

下载[MLST profiles](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadProfiles&scheme_id=1)，并保存为“MLST_Profiles.txt”。

## 建立数据库

下载Bc Group的[七个管家基因序列](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadAlleles)并合并至一个文件“alleles.fa”，并构建数据库

```
makeblastdb -in alleles.fa -out alleles -dbtype nucl
```

将“alleles.nhr”、“alleles.nin”、“alleles.nsq”、“MLST_Profiles.txt”以及三个perl脚本拷贝到工作目录中

## Blast比对等位基因并获取等位基因编号/序列

以基因组的scaffold/基因序列为query，与管家基因库“alleles”比对。

- (A) 若数据为从NCBI下载的基因组，则运行“NCBI/GENOME”中的脚本

```
perl blastn.ffn.pl
getST.v7.pl
```

- (B) 若数据为从NCBI下载的基因序列，则运行“NCBI/CDS”中的脚本

```
perl blastn.ffn.pl
getST.v6.pl
```

- (C) 若为自己测序的数据，建议进行基因组组装和基因预测(原核生物基因组组装及基因预测可用[PGCGAP](https://github.com/liaochenlanruo/pgcgap)完成)，以基因序列为query，运行“Others”中的脚本

```
perl blastn.ffn.pl
getST.v4.pl
```

## 获取序列型(ST)

```
perl add.ST_type.pl
```

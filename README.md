# 文件准备

下载[MLST profiles](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadProfiles&scheme_id=1)，并保存为“MLST_Profiles.txt”。

# 建立数据库

下载Bc Group的[七个管家基因序列](https://pubmlst.org/bigsdb?db=pubmlst_bcereus_seqdef&page=downloadAlleles)并合并至一个文件“alleles.fa”，并构建数据库

```
makeblastdb -in alleles.fa -out alleles -dbtype nucl
```

# 将“alleles.nhr”、“alleles.nin”、“alleles.nsq”、“MLST_Profiles.txt”以及三个perl脚本拷贝到工作目录中

# Blast比对等位基因并获取等位基因编号/序列

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

- (C) 若为自己测序的数据，建议进行基因组组装和基因预测，以基因序列为query，运行“Others”中的脚本

```
perl blastn.ffn.pl
getST.v4.pl
```

# 获取序列型(ST)

```
perl add.ST_type.pl
```

or

```
perl add.ST_type3.pl
```
